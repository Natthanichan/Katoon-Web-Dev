const express = require("express");
const mysql = require("mysql2");
const cors = require("cors");
const path = require("path");

const app = express();

app.use(cors());
app.use(express.json());
app.use("/image", express.static(path.join(__dirname, "image")));
app.use("/images", express.static(path.join(__dirname, "images")));

//server config
app.use(express.static(__dirname));

app.get("/", (req, res) => {
    res.sendFile(path.join(__dirname, "Homepage.html"));
});


const db = mysql.createConnection({
    host: "localhost",
    port: 3306,
    user: "root123",
    password: "root12345678",
    database: "katoonmodels_db"
});

db.connect((err) => {
    if (err) {
        console.log("Database connection failed:", err);
        return;
    }
    console.log("Connected to MySQL");
});

// GET all/search katoons
app.get("/api/katoons", (req, res) => {
    const { keyword, searchBy, category, status } = req.query;

    let sql = `
        SELECT katoon_ID, title, author, status, category, description, release_day, cover_image
        FROM Katoon
        WHERE 1=1
    `;
    const values = [];

    if (keyword && keyword.trim() !== "") {
        if (searchBy === "Title") {
            sql += " AND title LIKE ?";
            values.push(`%${keyword}%`);
        } else if (searchBy === "Author") {
            sql += " AND author LIKE ?";
            values.push(`%${keyword}%`);
        } else if (searchBy === "Category") {
            sql += " AND category LIKE ?";
            values.push(`%${keyword}%`);
        } else if (searchBy === "Day") {
            sql += " AND release_day = ?";
            values.push(keyword);
        } else {
            sql += " AND (title LIKE ? OR author LIKE ? OR category LIKE ? OR status LIKE ?)";
            values.push(`%${keyword}%`, `%${keyword}%`, `%${keyword}%`, `%${keyword}%`);
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
            console.log("Search error:", err);
            return res.status(500).json({ message: "Database error" });
        }
        res.json(results);
    });
});

// GET detail
app.get("/api/katoons/:id", (req, res) => {
    const sql = `
        SELECT katoon_ID, title, author, status, category, description, release_day, cover_image
        FROM Katoon
        WHERE katoon_ID = ?
    `;

    db.query(sql, [req.params.id], (err, results) => {
        if (err) return res.status(500).json({ message: "Database error" });
        if (results.length === 0) return res.status(404).json({ message: "Not found" });
        res.json(results[0]);
    });
});

// CREATE
app.post("/api/katoons", (req, res) => {
    const { title, author, category, release_day, description, status, cover_image } = req.body;

    if (!title) return res.status(400).json({ message: "Title required" });

    const sql = `
        INSERT INTO Katoon (title, author, status, category, description, release_day, cover_image)
        VALUES (?, ?, ?, ?, ?, ?, ?)
    `;

    db.query(
        sql,
        [title, author, status || "Ongoing", category, description, release_day, cover_image || ""],
        (err, result) => {
            if (err) {
                console.log("Create error:", err);
                return res.status(500).json({ message: "Database error" });
            }
            res.status(201).json({ katoon_ID: result.insertId, message: "Created" });
        }
    );
});

// UPDATE
app.put("/api/katoons/:id", (req, res) => {
    const { title, author, category, release_day, description, status, cover_image } = req.body;

    const sql = `
        UPDATE Katoon
        SET title=?, author=?, status=?, category=?, description=?, release_day=?, cover_image=?
        WHERE katoon_ID=?
    `;

    db.query(
        sql,
        [title, author, status, category, description, release_day, cover_image, req.params.id],
        (err) => {
            if (err) {
                console.log("Update error:", err);
                return res.status(500).json({ message: "Database error" });
            }
            res.json({ message: "Updated" });
        }
    );
});

// DELETE
app.delete("/api/katoons/:id", (req, res) => {
    const id = req.params.id;

    db.query("SET FOREIGN_KEY_CHECKS = 0", () => {
        db.query("DELETE FROM Katoon WHERE katoon_ID = ?", [id], (err) => {
            db.query("SET FOREIGN_KEY_CHECKS = 1");

            if (err) return res.status(500).json({ message: err.sqlMessage });
            res.json({ message: "Deleted" });
        });
    });
});

// LOGIN USER
app.post("/api/login/user", (req, res) => {
    const { username, password } = req.body;

    const sql = "SELECT user_id, name FROM User WHERE name = ? AND password = ?";
    db.query(sql, [username, password], (err, results) => {
        if (err) return res.status(500).json({ message: "Database error" });
        if (results.length === 0) return res.status(401).json({ message: "Invalid" });

        res.json({ role: "user", user: results[0] });
    });
});

// LOGIN ADMIN
app.post("/api/login/admin", (req, res) => {
    const { username, password } = req.body;

    const sql = "SELECT username FROM Admin_Account WHERE username = ? AND password = ?";
    db.query(sql, [username, password], (err, results) => {
        if (err) return res.status(500).json({ message: "Database error" });
        if (results.length === 0) return res.status(401).json({ message: "Invalid" });

        res.json({ role: "admin", admin: results[0] });
    });
});

app.listen(3000, () => {
    console.log("Server running at http://localhost:3000");
});

