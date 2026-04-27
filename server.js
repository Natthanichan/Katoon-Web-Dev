const express = require("express");
const mysql = require("mysql2");
const cors = require("cors");
const path = require("path");

const app = express();

app.use(cors());
app.use(express.json());

app.use("/image", express.static(path.join(__dirname, "image")));
app.use("/images", express.static(path.join(__dirname, "images")));

const db = mysql.createConnection({
  host: "localhost",
  user: "dev",
  password: "",
  database: "katoonmodels_db"
});

db.connect((err) => {
  if (err) {
    console.log("Database connection failed:", err);
    return;
  }
  console.log("Connected to MySQL");
});

app.get("/api/katoons", (req, res) => {
  const { keyword, searchBy, category, status } = req.query;

  let sql = `
    SELECT katoon_ID, title, status, category, description, release_day, cover_image
    FROM Katoon
    WHERE 1=1
  `;

  const values = [];

  if (keyword && keyword.trim() !== "") {
    if (searchBy === "Title") {
      sql += " AND title LIKE ?";
      values.push(`%${keyword}%`);
    } else if (searchBy === "Category") {
      sql += " AND category LIKE ?";
      values.push(`%${keyword}%`);
    } else {
      sql += " AND (title LIKE ? OR category LIKE ? OR status LIKE ?)";
      values.push(`%${keyword}%`, `%${keyword}%`, `%${keyword}%`);
    }
  }

  if (category && category !== "All") {
    sql += " AND category = ?";
    values.push(category);
  }

  if (status && status !== "All") {
    sql += " AND status = ?";
    values.push(status);
  }

  db.query(sql, values, (err, results) => {
    if (err) {
      console.log(err);
      return res.status(500).json({ message: "Database error" });
    }

    res.json(results);
  });
});

app.get("/api/katoons/:id", (req, res) => {
  const sql = `
    SELECT katoon_ID, title, status, category, description, release_day, cover_image
    FROM Katoon
    WHERE katoon_ID = ?
  `;

  db.query(sql, [req.params.id], (err, results) => {
    if (err) {
      console.log(err);
      return res.status(500).json({ message: "Database error" });
    }

    if (results.length === 0) {
      return res.status(404).json({ message: "Katoon not found" });
    }

    res.json(results[0]);
  });
});

app.listen(3000, () => {
  console.log("Server running at http://localhost:3000");
});
