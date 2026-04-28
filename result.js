const resultGrid     = document.getElementById("resultGrid");
const searchTermText = document.querySelector(".search-term");
const resultSearchInput = document.getElementById("resultSearchInput");
const resultSearchBtn   = document.getElementById("resultSearchBtn");

const params   = new URLSearchParams(window.location.search);
let keyword    = params.get("keyword")  || "";
let searchBy   = params.get("searchBy") || "All";

// ============================================================
// LOAD RESULTS
// ============================================================
async function loadResults() {
    if (searchTermText) searchTermText.textContent = keyword || "—";

    const url = `http://localhost:3000/api/katoons?keyword=${encodeURIComponent(keyword)}&searchBy=${encodeURIComponent(searchBy)}`;

    try {
        const response = await fetch(url);
        const katoons  = await response.json();

        resultGrid.innerHTML = "";

        if (!Array.isArray(katoons) || katoons.length === 0) {
            resultGrid.innerHTML = `<p class="text-muted mt-3">No results found for "<strong>${keyword}</strong>".</p>`;
            return;
        }

        katoons.forEach((katoon) => {
            resultGrid.innerHTML += `
                <div class="col">
                    <a href="DetailPage.html?id=${katoon.katoon_ID}" style="text-decoration:none; color:inherit;">
                        <article class="katoon-card">
                            <img src="${katoon.cover_image}" class="result-img"
                                 alt="${katoon.title}"
                                 onerror="this.src='https://via.placeholder.com/180x260?text=No+Image'">
                            <h3 class="comic-title">${katoon.title}</h3>
                            <p class="comic-author">${katoon.category || ""}</p>
                        </article>
                    </a>
                </div>
            `;
        });

    } catch (err) {
        console.log("Result error:", err);
        resultGrid.innerHTML = `<p class="text-muted">Could not load results. Is the server running?</p>`;
    }
}

// ============================================================
// SEARCH AGAIN
// ============================================================
function searchAgain() {
    const newKeyword = resultSearchInput.value.trim();
    keyword = newKeyword;

    const newUrl = `?keyword=${encodeURIComponent(newKeyword)}&searchBy=${encodeURIComponent(searchBy)}`;
    window.history.pushState({}, "", newUrl);

    if (searchTermText) searchTermText.textContent = newKeyword || "—";
    loadResults();
}

resultSearchBtn.addEventListener("click", searchAgain);

resultSearchInput.addEventListener("keydown", (e) => {
    if (e.key === "Enter") searchAgain();
});

// Pre-fill search input with current keyword
if (resultSearchInput && keyword) {
    resultSearchInput.value = keyword;
}

// ============================================================
// INIT
// ============================================================
window.addEventListener("load", loadResults);