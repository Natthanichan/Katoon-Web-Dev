const searchInput = document.getElementById("searchInput");
const searchBtn = document.getElementById("searchBtn");

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

function goToResultPage() {
  const keyword = searchInput.value.trim();

  window.location.href =
    `ResultPage.html?keyword=${encodeURIComponent(keyword)}&searchBy=${encodeURIComponent(searchBy)}`;
}

searchBtn.addEventListener("click", goToResultPage);

searchInput.addEventListener("keydown", (e) => {
  if (e.key === "Enter") {
    goToResultPage();
  }
});
