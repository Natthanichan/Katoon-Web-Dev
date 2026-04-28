const express = require("express");
const mysql   = require("mysql2");
const cors    = require("cors");
const path    = require("path");

const app = express();
console.log("RUNNING SERVER FILE:", __filename);

app.use(cors());
app.use(express.json());
app.use("/image",  express.static(path.join(__dirname, "image")));
app.use("/images", express.static(path.join(__dirname, "images")));

// ============================================================
// DATABASE
// ============================================================

const db = mysql.createConnection({
    host: "localhost",
    port: 3306,
    user: "root123",
    password: "root12345678",
    database: "katoonmodels_db"
});

db.connect((err) => {
    if (err) { console.log("Database connection failed:", err); return; }
    console.log("Connected to MySQL");
});

// ============================================================
// GET /api/katoons
// ============================================================
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
        } else if (searchBy === "Day") {
            sql += " AND release_day = ?";
            values.push(keyword);
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
        if (err) { console.log(err); return res.status(500).json({ message: "Database error" }); }
        res.json(results);
    });
});

// ============================================================
// GET /api/katoons/:id
// ============================================================
app.get("/api/katoons/:id", (req, res) => {
    const sql = `
        SELECT katoon_ID, title, status, category, description, release_day, cover_image
        FROM Katoon
        WHERE katoon_ID = ?
    `;
    db.query(sql, [req.params.id], (err, results) => {
        if (err) { console.log(err); return res.status(500).json({ message: "Database error" }); }
        if (results.length === 0) return res.status(404).json({ message: "Katoon not found" });
        res.json(results[0]);
    });
});

// ============================================================
// POST /api/katoons  (Admin — create)
// ============================================================
app.post("/api/katoons", (req, res) => {
    const { title, category, release_day, description, status, cover_image } = req.body;
    if (!title) return res.status(400).json({ message: "Title is required" });

    const sql = `
        INSERT INTO Katoon (title, status, category, description, release_day, cover_image)
        VALUES (?, ?, ?, ?, ?, ?)
    `;
    db.query(sql, [title, status || "Ongoing", category, description, release_day, cover_image || ""], (err, result) => {
        if (err) { console.log(err); return res.status(500).json({ message: "Database error" }); }
        res.status(201).json({ katoon_ID: result.insertId, message: "Katoon created" });
    });
});

// ============================================================
// PUT /api/katoons/:id  (Admin — update)
// ============================================================
app.put("/api/katoons/:id", (req, res) => {
    const { title, category, release_day, description, status, cover_image } = req.body;
    const sql = `
        UPDATE Katoon
        SET title=?, status=?, category=?, description=?, release_day=?, cover_image=?
        WHERE katoon_ID=?
    `;
    db.query(sql, [title, status, category, description, release_day, cover_image, req.params.id], (err) => {
        if (err) { console.log(err); return res.status(500).json({ message: "Database error" }); }
        res.json({ message: "Katoon updated" });
    });
});

// ============================================================
// DELETE /api/katoons/:id  (Admin — delete)
// ============================================================
app.delete("/api/katoons/:id", (req, res) => {
    const id = req.params.id;

    db.query("SET FOREIGN_KEY_CHECKS = 0", (err) => {
        if (err) return res.status(500).json({ message: err.sqlMessage });

        db.query("DELETE FROM Katoon WHERE katoon_ID = ?", [id], (err, result) => {
            if (err) {
                db.query("SET FOREIGN_KEY_CHECKS = 1");
                return res.status(500).json({ message: err.sqlMessage });
            }

            db.query("SET FOREIGN_KEY_CHECKS = 1", () => {
                res.json({ message: "Katoon deleted" });
            });
        });
    });
});
// ============================================================
// POST /api/login/user   ← แก้ Users → User
// ============================================================
app.post("/api/login/user", (req, res) => {
    const { username, password } = req.body;
    if (!username || !password) return res.status(400).json({ message: "Username and password required" });

    // ตาราง database ชื่อ User (ไม่มี s)
    const sql = "SELECT user_id, name FROM User WHERE name = ? AND password = ?";
    db.query(sql, [username, password], (err, results) => {
        if (err) return res.status(500).json({ message: "Database error" });
        if (results.length === 0) return res.status(401).json({ message: "Invalid username or password" });
        res.json({ role: "user", user: results[0] });
    });
});

// ============================================================
// POST /api/login/admin
// ============================================================
app.post("/api/login/admin", (req, res) => {
    const { username, password } = req.body;
    if (!username || !password) return res.status(400).json({ message: "Username and password required" });

    const sql = "SELECT username, role FROM Admin_Account WHERE username = ? AND password = ?";
    db.query(sql, [username, password], (err, results) => {
        if (err) return res.status(500).json({ message: "Database error" });
        if (results.length === 0) return res.status(401).json({ message: "Invalid admin credentials" });
        res.json({ role: "admin", admin: results[0] });
    });
});

// ============================================================
// START
// ============================================================
app.listen(3000, () => console.log("Server running at http://localhost:3000"));