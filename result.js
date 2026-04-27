// -------------------------
// 1. ดึง element มาก่อน
// -------------------------
const resultGrid = document.getElementById("resultGrid");
const searchTermText = document.querySelector(".search-term");

const resultSearchInput = document.getElementById("resultSearchInput");
const resultSearchBtn = document.getElementById("resultSearchBtn");

// -------------------------
// 2. อ่านค่า URL
// -------------------------
const params = new URLSearchParams(window.location.search);

let keyword = params.get("keyword") || "";
let searchBy = params.get("searchBy") || "All";

// -------------------------
// 3. ฟังก์ชันโหลดข้อมูล
// -------------------------
async function loadResults() {
  searchTermText.textContent = keyword;

  const url =
    `http://localhost:3000/api/katoons?keyword=${encodeURIComponent(keyword)}&searchBy=${encodeURIComponent(searchBy)}`;

  const response = await fetch(url);
  const katoons = await response.json();

  resultGrid.innerHTML = "";

  katoons.forEach((katoon) => {
    resultGrid.innerHTML += `
      <div class="col">
        <article class="katoon-card">
          <img src="${katoon.cover_image}" class="result-img">
          <h3>${katoon.title}</h3>
        </article>
      </div>
    `;
  });
}

// -------------------------
// 4. 🔥 ใส่ตรงนี้ (searchAgain)
// -------------------------
function searchAgain() {
  const newKeyword = resultSearchInput.value.trim();

  const newUrl = `?keyword=${encodeURIComponent(newKeyword)}&searchBy=${encodeURIComponent(searchBy)}`;
  window.history.pushState({}, "", newUrl);

  keyword = newKeyword;

  loadResults();
}

// -------------------------
// 5. 🔥 ใส่ตรงนี้ (event)
// -------------------------
resultSearchBtn.addEventListener("click", searchAgain);

resultSearchInput.addEventListener("keydown", (e) => {
  if (e.key === "Enter") {
    searchAgain();
  }
});

// -------------------------
// 6. โหลดครั้งแรก
// -------------------------
loadResults();
