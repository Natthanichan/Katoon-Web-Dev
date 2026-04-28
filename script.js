// ============================================================
// NAVBAR ANIMATIONS
// ============================================================
document.addEventListener("DOMContentLoaded", function () {
    const searchAnim = document.getElementById("searchAnim");
    const loginAnim  = document.getElementById("loginAnim");

    if (searchAnim) {
        searchAnim.addEventListener("click", () => {
            searchAnim.stop();
            searchAnim.play();
        });
    }

    if (loginAnim) {
        loginAnim.addEventListener("click", () => {
            loginAnim.stop();
            loginAnim.play();
        });
    }
});

// ============================================================
// QUOTE OF THE DAY
// ============================================================
async function fetchDailyQuote() {
    const quoteTextBox   = document.getElementById("quoteText");
    const quoteAuthorBox = document.getElementById("quoteAuthor");

    if (!quoteTextBox || !quoteAuthorBox) return;

    try {
        const response = await fetch("https://quote-garden.onrender.com/api/v3/quotes/random");
        const result   = await response.json();
        quoteTextBox.innerText   = `"${result.data[0].quoteText}"`;
        quoteAuthorBox.innerText = `- ${result.data[0].quoteAuthor}`;
    } catch (error) {
        quoteTextBox.innerText   = '"Keep reading, keep dreaming!"';
        quoteAuthorBox.innerText = "- KATOON Team";
    }
}

window.addEventListener("load", fetchDailyQuote);

// ============================================================
// LOGIN MODAL
// ============================================================
function openModal() {
    const modal = document.getElementById("loginModal");
    if (modal) modal.classList.add("show");
}

function closeModal() {
    const modal = document.getElementById("loginModal");
    if (modal) modal.classList.remove("show");
}

// Close modal on outside click
window.addEventListener("click", (e) => {
    const loginModal = document.getElementById("loginModal");
    if (loginModal && e.target === loginModal) closeModal();
});

// ============================================================
// LOGIN
// ============================================================
document.addEventListener("DOMContentLoaded", () => {
    const userBtn  = document.getElementById("userLoginBtn");
    const adminBtn = document.getElementById("adminLoginBtn");

    if (userBtn)  userBtn.addEventListener("click",  () => login("user"));
    if (adminBtn) adminBtn.addEventListener("click", () => login("admin"));
});

async function login(type) {
    const username = document.getElementById("username")?.value.trim();
    const password = document.getElementById("password")?.value.trim();

    if (!username || !password) {
        alert("Please enter username and password");
        return;
    }

    const url = type === "admin"
        ? "http://localhost:3000/api/login/admin"
        : "http://localhost:3000/api/login/user";

    try {
        const res  = await fetch(url, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ username, password })
        });
        const data = await res.json();

        if (!res.ok) {
            alert(data.message || "Login failed");
            return;
        }

        localStorage.setItem("loginRole", data.role);
        localStorage.setItem("loginData", JSON.stringify(data));

        if (data.role === "admin") {
            window.location.href = "Admin.html";
        } else {
            window.location.href = "UserPage.html";
        }

    } catch (err) {
        console.log(err);
        alert("Cannot connect to server");
    }
}