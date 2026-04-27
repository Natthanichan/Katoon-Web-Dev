const searchInput = document.getElementById("searchInput");
const searchBtn = document.getElementById("searchBtn");
const resultsGrid = document.getElementById("resultsGrid");

async function loadKatoons() {
  const keyword = searchInput.value.trim();

  const url = `http://localhost:3000/api/katoons?keyword=${encodeURIComponent(keyword)}`;

  try {
    const response = await fetch(url);
    const katoons = await response.json();

    if (!Array.isArray(katoons)) return;

    if (katoons.length === 0) {
      resultsGrid.innerHTML = `<p>No results found</p>`;
      return;
    }

    // 🔥 ลบของเดิม (placeholder)
    resultsGrid.innerHTML = "";

    // 🔥 ใส่ของใหม่ แต่ใช้ class เดิมทั้งหมด
    katoons.forEach((katoon) => {
      const imagePath = katoon.cover_image || "images/default.jpg";

      resultsGrid.innerHTML += `
        <div class="col">
          <article class="katoon-card-proto">
            
            <img src="${imagePath}" style="width:100%; height:280px; border-radius:20px; margin-bottom:10px; object-fit:cover;">

            <div class="proto-info">
              <span class="proto-category">${katoon.category}</span>
              <h3 class="proto-title">${katoon.title}</h3>
            </div>

          </article>
        </div>
      `;
    });

  } catch (error) {
    console.log(error);
  }
}

// 🔥 event
searchBtn.addEventListener("click", () => {
  const keyword = searchInput.value.trim();

  // โหลด preview
  loadKatoons();

  // เด้งหน้า
  window.location.href = `ResultPage.html?keyword=${encodeURIComponent(keyword)}`;
});

searchInput.addEventListener("keydown", (e) => {
  if (e.key === "Enter") {
    const keyword = searchInput.value.trim();

    loadKatoons();

    window.location.href = `ResultPage.html?keyword=${encodeURIComponent(keyword)}`;
  }
});
