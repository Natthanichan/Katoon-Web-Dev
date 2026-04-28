let selectedCard = null;

const addBtn = document.getElementById("addBtn");
const addAnim = document.getElementById("addAnim");
const popup = document.getElementById("popup");
const closeBtn = document.getElementById("closeBtn");

const saveBtn = document.getElementById("saveBtn");
const updateBtn = document.getElementById("updateBtn");
const deleteBtn = document.getElementById("deleteBtn");

const adminGrid = document.getElementById("adminGrid");

const coverInput = document.getElementById("coverInput");
const titleInput = document.getElementById("titleInput");
const genreInput = document.getElementById("genreInput");

addBtn.addEventListener("click", (e) => {
    e.preventDefault();

    selectedCard = null;
    resetForm();

    if (addAnim) {
        addAnim.stop();
        addAnim.play();
    }

    popup.classList.add("show");
});

closeBtn.addEventListener("click", () => {
    popup.classList.remove("show");
    resetForm();
});

saveBtn.addEventListener("click", () => {
    const file = coverInput.files[0];
    const title = titleInput.value.trim();
    const genre = genreInput.value;

    if (!file || !title) {
        alert("Please add cover picture and title");
        return;
    }

    const imageURL = URL.createObjectURL(file);

    const card = document.createElement("div");
    card.className = "card";

    card.innerHTML = `
        <img src="${imageURL}" alt="${title}">
        <p class="genre">${genre}</p>
        <p class="card-title">${title}</p>
    `;

    card.addEventListener("click", () => {
        openEditCard(card);
    });

    adminGrid.appendChild(card);

    popup.classList.remove("show");
    resetForm();
});

function openEditCard(card) {
    selectedCard = card;

    const title = card.querySelector(".card-title").innerText;
    const genre = card.querySelector(".genre").innerText;

    titleInput.value = title;
    genreInput.value = genre;

    popup.classList.add("show");
}

updateBtn.addEventListener("click", () => {
    if (!selectedCard) {
        alert("Please select a card first");
        return;
    }

    const file = coverInput.files[0];
    const title = titleInput.value.trim();
    const genre = genreInput.value;

    if (!title) {
        alert("Please enter title");
        return;
    }

    selectedCard.querySelector(".card-title").innerText = title;
    selectedCard.querySelector(".genre").innerText = genre;

    if (file) {
        const imageURL = URL.createObjectURL(file);
        selectedCard.querySelector("img").src = imageURL;
    }

    popup.classList.remove("show");
    resetForm();
    selectedCard = null;
});

deleteBtn.addEventListener("click", () => {
    if (!selectedCard) {
        alert("Please select a card first");
        return;
    }

    selectedCard.remove();
    selectedCard = null;

    popup.classList.remove("show");
    resetForm();
});

window.addEventListener("click", (e) => {
    if (e.target === popup) {
        popup.classList.remove("show");
        resetForm();
        selectedCard = null;
    }
});

function resetForm() {
    coverInput.value = "";
    titleInput.value = "";
}
