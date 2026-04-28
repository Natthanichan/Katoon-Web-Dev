const homeGrid = document.getElementById("homeGrid");
let currentDay = "Monday";

// ============================================================
// LOAD KATOONS BY DAY
// ============================================================
async function loadHomepageKatoons(day) {
    try {
        const response = await fetch(`http://localhost:3000/api/katoons?keyword=${encodeURIComponent(day)}&searchBy=Day`);
        const allKatoons = await response.json();

        // Filter by release_day matching selected day
        const filtered = allKatoons.filter(k =>
            k.release_day && k.release_day.toLowerCase() === day.toLowerCase()
        );

        homeGrid.innerHTML = "";

        if (filtered.length === 0) {
            homeGrid.innerHTML = `<p class="text-muted">No katoons scheduled for ${day}.</p>`;
            return;
        }

        filtered.forEach((katoon) => {
            homeGrid.innerHTML += `
                <div class="col">
                    <a href="DetailPage.html?id=${katoon.katoon_ID}" style="text-decoration:none; color:inherit;">
                        <article class="katoon-card">
                            <img src="${katoon.cover_image}"
                                 alt="${katoon.title}"
                                 onerror="this.src='https://via.placeholder.com/180x260?text=No+Image'">
                            <div class="katoon-category">${katoon.category || ""}</div>
                            <div class="katoon-title">${katoon.title}</div>
                        </article>
                    </a>
                </div>
            `;
        });

    } catch (err) {
        console.log("Homepage error:", err);
        homeGrid.innerHTML = `<p class="text-muted">Could not load katoons. Is the server running?</p>`;
    }
}

// ============================================================
// DAY PILL FILTER
// ============================================================
document.querySelectorAll(".day-pill").forEach((pill) => {
    pill.addEventListener("click", () => {
        document.querySelectorAll(".day-pill").forEach(p => p.classList.remove("active"));
        pill.classList.add("active");
        currentDay = pill.dataset.day;
        loadHomepageKatoons(currentDay);
    });
});

// ============================================================
// INIT — load today's day by default
// ============================================================
window.addEventListener("load", () => {
    const days = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];
    const todayName = days[new Date().getDay()];

    // Try to activate today's pill
    const todayPill = document.querySelector(`.day-pill[data-day="${todayName}"]`);
    if (todayPill) {
        document.querySelectorAll(".day-pill").forEach(p => p.classList.remove("active"));
        todayPill.classList.add("active");
        currentDay = todayName;
    }

    loadHomepageKatoons(currentDay);
});