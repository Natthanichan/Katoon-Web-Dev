// ============================================================
// ADMIN GUARD — redirect if not logged in as admin
// ============================================================
(function () {
    const role = localStorage.getItem("loginRole");
    if (role !== "admin") {
        window.location.href = "Homepage.html";
    }
})();

// ============================================================
// STATE
// ============================================================
let selectedCard = null;
let selectedKatoonId = null;

// ============================================================
// ELEMENTS
// ============================================================
const addBtn         = document.getElementById("addBtn");
const addAnim        = document.getElementById("addAnim");
const outAnim        = document.getElementById("outAnim");
const logoutBtn      = document.getElementById("logoutBtn");
const popup          = document.getElementById("popup");
const closeBtn       = document.getElementById("closeBtn");
const saveBtn        = document.getElementById("saveBtn");
const updateBtn      = document.getElementById("updateBtn");
const deleteBtn      = document.getElementById("deleteBtn");
const adminGrid      = document.getElementById("adminGrid");
const coverInput     = document.getElementById("coverInput");
const titleInput     = document.getElementById("titleInput");
const authorInput    = document.getElementById("authorInput");
const genreInput     = document.getElementById("genreInput");
const dateInput      = document.getElementById("dateInput");
const descInput      = document.getElementById("descriptionInput");
const statusInput    = document.getElementById("statusInput");

const API = "http://localhost:3000/api/katoons";

// ============================================================
// LOGOUT
// ============================================================
if (logoutBtn) {
    logoutBtn.addEventListener("click", (e) => {
        e.preventDefault();
        if (outAnim) { outAnim.stop(); outAnim.play(); }
        localStorage.removeItem("loginRole");
        localStorage.removeItem("loginData");
        setTimeout(() => { window.location.href = "Homepage.html"; }, 400);
    });
}

// ============================================================
// LOAD ALL KATOONS FROM SERVER
// ============================================================
async function loadAdminKatoons() {
    try {
        const res = await fetch(API);
        const katoons = await res.json();

        // Remove all cards except add-card
        document.querySelectorAll(".card").forEach(c => c.remove());

        katoons.forEach(k => renderCard(k));
    } catch (err) {
        console.log("Load error:", err);
    }
}

// ============================================================
// RENDER A CARD
// ============================================================
function renderCard(katoon) {
    const card = document.createElement("div");
    card.className = "card";
    card.dataset.id = katoon.katoon_ID;

    card.innerHTML = `
        <img src="${katoon.cover_image || ''}" alt="${katoon.title}"
             onerror="this.src='https://via.placeholder.com/180x240?text=No+Image'">
        <p class="genre">${katoon.category || ''}</p>
        <p class="card-title">${katoon.title}</p>
    `;

    card.addEventListener("click", () => openEditCard(card, katoon));
    adminGrid.appendChild(card);
}

// ============================================================
// OPEN POPUP — ADD MODE
// ============================================================
addBtn.addEventListener("click", (e) => {
    e.preventDefault();
    selectedCard = null;
    selectedKatoonId = null;
    resetForm();
    if (addAnim) { addAnim.stop(); addAnim.play(); }
    popup.classList.add("show");
});

// ============================================================
// OPEN POPUP — EDIT MODE
// ============================================================
function openEditCard(card, katoon) {
    selectedCard = card;
    selectedKatoonId = katoon.katoon_ID;

    titleInput.value   = katoon.title || "";
    authorInput.value  = katoon.author || "";
    descInput.value    = katoon.description || "";
    genreInput.value   = katoon.category || "Romance";
    dateInput.value    = katoon.release_day || "Monday";
    statusInput.value  = katoon.status || "Ongoing";

    popup.classList.add("show");
}

// ============================================================
// CLOSE POPUP
// ============================================================
closeBtn.addEventListener("click", () => {
    popup.classList.remove("show");
    resetForm();
});

window.addEventListener("click", (e) => {
    if (e.target === popup) {
        popup.classList.remove("show");
        resetForm();
        selectedCard = null;
        selectedKatoonId = null;
    }
});

// ============================================================
// SAVE — POST new katoon to server
// ============================================================
saveBtn.addEventListener("click", async () => {
    const title  = titleInput.value.trim();
    const author = authorInput.value.trim();
    const genre  = genreInput.value;
    const day    = dateInput.value;
    const desc   = descInput.value.trim();
    const status = statusInput.value;
    const file   = coverInput.files[0];

    if (!title) { alert("Please enter a title"); return; }

    let imageURL = "";

    if (file) {
        imageURL = URL.createObjectURL(file);
    }

    try {
        const res = await fetch(API, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                title,
                author,
                category: genre,
                release_day: day,
                description: desc,
                status,
                cover_image: imageURL
            })
        });

        if (!res.ok) throw new Error("Save failed");

        const saved = await res.json();

        renderCard({
            katoon_ID: saved.katoon_ID,
            title,
            category: genre,
            cover_image: imageURL
        });

        popup.classList.remove("show");
        resetForm();
    } catch (err) {
    console.log("Save error:", err);
    alert("Save failed ❌");
    return;
}
});

// ============================================================
// UPDATE — PUT existing katoon
// ============================================================
updateBtn.addEventListener("click", async () => {
    if (!selectedCard) { alert("Please select a card first"); return; }

    const title  = titleInput.value.trim();
    const author = authorInput.value.trim();
    const genre  = genreInput.value;
    const day    = dateInput.value;
    const desc   = descInput.value.trim();
    const status = statusInput.value;
    const file   = coverInput.files[0];

    if (!title) { alert("Please enter a title"); return; }

    let imageURL = selectedCard.querySelector("img").src;
    if (file) imageURL = URL.createObjectURL(file);

    try {
        const res = await fetch(`${API}/${selectedKatoonId}`, {
            method: "PUT",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                title,
                author,
                category: genre,
                release_day: day,
                description: desc,
                status,
                cover_image: imageURL
            })
        });

        if (!res.ok) {
            alert("Update failed ❌");
            return;
        }

    } catch (err) {
        console.log("Update error:", err);
        return;
    }
    // Update card UI regardless
    selectedCard.querySelector(".card-title").innerText = title;
    selectedCard.querySelector(".genre").innerText = genre;
    if (file) selectedCard.querySelector("img").src = imageURL;

    popup.classList.remove("show");
    resetForm();
    selectedCard = null;
    selectedKatoonId = null;
});

// ============================================================
// DELETE — DELETE katoon from server
// ============================================================
deleteBtn.addEventListener("click", async () => {
    if (!selectedCard) { alert("Please select a card first"); return; }

    if (!confirm("Are you sure you want to delete this katoon?")) return;

    try {
        console.log("selectedKatoonId =", selectedKatoonId);
        console.log("DELETE URL =", `${API}/${selectedKatoonId}`);

        const res = await fetch(`${API}/${selectedKatoonId}`, {
        method: "DELETE"
        });

        const data = await res.json();

        if (!res.ok) {
            console.log("Delete failed:", data);
            alert(data.message || "Delete failed ❌");
            return;
        }

        selectedCard.remove();
        popup.classList.remove("show");
        resetForm();

    } catch (err) {
        console.log("Delete error:", err);
        alert("Delete error ❌");
    }
});
// ============================================================
// HELPERS
// ============================================================
function resetForm() {
    coverInput.value      = "";
    titleInput.value      = "";
    authorInput.value     = "";
    descInput.value       = "";
    genreInput.value      = "Romance";
    dateInput.value       = "Monday";
    statusInput.value     = "Ongoing";
    selectedCard          = null;
    selectedKatoonId      = null;
}

// ============================================================
// INIT
// ============================================================
window.addEventListener("load", loadAdminKatoons);