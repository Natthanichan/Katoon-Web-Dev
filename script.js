// navbar normal page
document.addEventListener("DOMContentLoaded", function () {
    const searchAnim = document.getElementById("searchAnim");
    const loginAnim = document.getElementById("loginAnim");

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

// navbar admin page
document.addEventListener("DOMContentLoaded", function () {
    const outAnim = document.getElementById("outAnim");
    const addBtn = document.getElementById("addBtn");
    const addAnim = document.getElementById("addAnim");
    const popup = document.getElementById("popup");
    const closeBtn = document.getElementById("closeBtn");

    if (outAnim) {
        outAnim.addEventListener("click", () => {
            outAnim.stop();
            outAnim.play();

            localStorage.removeItem("loginRole");
            localStorage.removeItem("loginData");

            window.location.href = "Homepage.html";
        });
    }

    if (addBtn && popup) {
        addBtn.addEventListener("click", () => {
            if (addAnim) {
                addAnim.stop();
                addAnim.play();
            }
            popup.classList.add("show");
        });
    }

    if (closeBtn && popup) {
        closeBtn.addEventListener("click", () => {
            popup.classList.remove("show");
        });
    }

    window.addEventListener("click", (e) => {
        if (popup && e.target === popup) {
            popup.classList.remove("show");
        }

        const loginModal = document.getElementById("loginModal");
        if (loginModal && e.target === loginModal) {
            closeModal();
        }
    });
});

// quote
async function fetchDailyQuote() {
    const quoteTextBox = document.getElementById("quoteText");
    const quoteAuthorBox = document.getElementById("quoteAuthor");

    if (!quoteTextBox || !quoteAuthorBox) return;

    try {
        const response = await fetch("https://quote-garden.onrender.com/api/v3/quotes/random");
        const result = await response.json();

        quoteTextBox.innerText = `"${result.data[0].quoteText}"`;
        quoteAuthorBox.innerText = `- ${result.data[0].quoteAuthor}`;
    } catch (error) {
        console.log("Error connecting to web service:", error);
        quoteTextBox.innerText = "Keep reading, keep dreaming!";
    }
}

window.addEventListener("load", fetchDailyQuote);

// login modal
function openModal() {
    document.getElementById("loginModal").classList.add("show");
}

function closeModal() {
    document.getElementById("loginModal").classList.remove("show");
}

// login
document.addEventListener("DOMContentLoaded", () => {
    const userBtn = document.getElementById("userLoginBtn");
    const adminBtn = document.getElementById("adminLoginBtn");

    if (userBtn) {
        userBtn.addEventListener("click", () => login("user"));
    }

    if (adminBtn) {
        adminBtn.addEventListener("click", () => login("admin"));
    }
});

async function login(type) {
    const username = document.getElementById("username").value.trim();
    const password = document.getElementById("password").value.trim();

    const url = type === "admin"
        ? "http://localhost:3000/api/login/admin"
        : "http://localhost:3000/api/login/user";

    try {
        const res = await fetch(url, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ username, password })
        });

        const data = await res.json();

        if (!res.ok) {
            alert(data.message);
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
