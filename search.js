const searchInput = document.getElementById("searchInput");
const searchBtn = document.getElementById("searchBtn");
const resultsGrid = document.getElementById("resultsGrid");

let searchBy = "All";

document.querySelectorAll(".dropdown-options li").forEach((item) => {
  item.addEventListener("click", function () {
    const dropdown = this.closest(".custom-dropdown");
    dropdown.querySelector(".selected").innerHTML = `${this.textContent} <span>▼</span>`;

    const label = dropdown.closest(".search-group").querySelector(".label-text").textContent;

    if (label.includes("Search by")) {
      searchBy = this.textContent;
    }
  });
});

async function loadKatoons() {
  const keyword = searchInput.value.trim();

  const url = `http://localhost:3000/api/katoons?keyword=${encodeURIComponent(keyword)}&searchBy=${encodeURIComponent(searchBy)}`;

  try {
    const response = await fetch(url);
    const katoons = await response.json();

    if (!Array.isArray(katoons)) {
      console.log("Data is not array:", katoons);
      return;
    }

    if (katoons.length === 0) {
      resultsGrid.innerHTML = `<p>No results found</p>`;
      return;
    }

    resultsGrid.innerHTML = "";

    katoons.forEach((katoon) => {
      const imagePath = katoon.cover_image || "image/default.jpg";

      resultsGrid.innerHTML += `
        <div class="col">
          <article class="katoon-card-proto">
            <img src="${imagePath}" alt="${katoon.title}" class="katoon-img">
            <div class="proto-info">
              <span class="proto-category">${katoon.category}</span>
              <h3 class="proto-title">${katoon.title}</h3>
            </div>
          </article>
        </div>
      `;
    });
  } catch (error) {
    console.log("Fetch error:", error);
  }
}

searchBtn.addEventListener("click", loadKatoons);

searchInput.addEventListener("keydown", function (e) {
  if (e.key === "Enter") {
    loadKatoons();
  }
});
