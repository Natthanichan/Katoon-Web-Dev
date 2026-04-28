const searchInput = document.getElementById("searchInput");
const searchBtn   = document.getElementById("searchBtn");
const resultsGrid = document.getElementById("resultsGrid");

// ============================================================
// LOAD PREVIEW KATOONS (on the search page itself)
// ============================================================
async function loadPreviewKatoons(keyword) {
    const url = keyword
        ? `http://localhost:3000/api/katoons?keyword=${encodeURIComponent(keyword)}`
        : `http://localhost:3000/api/katoons`;

    try {
        const response = await fetch(url);
        const katoons  = await response.json();

        if (!Array.isArray(katoons)) return;

        resultsGrid.innerHTML = "";

        if (katoons.length === 0) {
            resultsGrid.innerHTML = `<p class="text-muted">No results found.</p>`;
            return;
        }

        katoons.slice(0, 5).forEach((katoon) => {
            resultsGrid.innerHTML += `
                <div class="col">
                    <article class="katoon-card-proto">
                        <img src="${katoon.cover_image || ''}"
                             class="katoon-img"
                             alt="${katoon.title}"
                             onerror="this.src='https://via.placeholder.com/180x280?text=No+Image'">
                        <div class="proto-info">
                            <span class="proto-category">${katoon.category || ""}</span>
                            <h3 class="proto-title">${katoon.title}</h3>
                        </div>
                    </article>
                </div>
            `;
        });

    } catch (error) {
        console.log("Search preview error:", error);
    }
}

// ============================================================
// GO TO RESULT PAGE
// ============================================================
function goToResultPage() {
    const keyword  = searchInput.value.trim();
    const searchBy = document.querySelector(".search-group .selected")?.textContent?.trim().replace("▼","").trim() || "All";

    window.location.href = `ResultPage.html?keyword=${encodeURIComponent(keyword)}&searchBy=${encodeURIComponent(searchBy)}`;
}

searchBtn.addEventListener("click", goToResultPage);

searchInput.addEventListener("keydown", (e) => {
    if (e.key === "Enter") goToResultPage();
});

// ============================================================
// INIT — load random/all katoons as suggestions
// ============================================================
window.addEventListener("load", () => loadPreviewKatoons(""));