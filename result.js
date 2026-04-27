const resultGrid = document.getElementById("resultGrid");
const searchTermText = document.querySelector(".search-term");
const seriesCount = document.querySelector(".series-count");

const params = new URLSearchParams(window.location.search);

let keyword = params.get("keyword") || "";
let searchBy = params.get("searchBy") || "All";

async function loadResults() {
  searchTermText.textContent = keyword || "All";

  const url =
    `http://localhost:3000/api/katoons?keyword=${encodeURIComponent(keyword)}&searchBy=${encodeURIComponent(searchBy)}`;

  try {
    resultGrid.innerHTML = `<p>Loading...</p>`;

    const response = await fetch(url);
    const katoons = await response.json();

    resultGrid.innerHTML = "";
    seriesCount.textContent = `${katoons.length} series`;

    if (katoons.length === 0) {
      resultGrid.innerHTML = `<p>No results found</p>`;
      return;
    }

    katoons.forEach((katoon) => {
      const imagePath = katoon.cover_image || "images/default.jpg";

      resultGrid.innerHTML += `
        <div class="col">
          <article class="katoon-card">
            <div class="img-container">
              <img src="${imagePath}" alt="${katoon.title}" class="result-img">
            </div>
            <div class="card-info">
              <h3 class="comic-title">${katoon.title}</h3>
              <p class="comic-author">${katoon.category}</p>
              <p class="comic-stats">${katoon.status}</p>
            </div>
          </article>
        </div>
      `;
    });
  } catch (error) {
    console.log(error);
    resultGrid.innerHTML = `<p>Cannot load results</p>`;
  }
}

loadResults();
