const homeGrid = document.getElementById("homeGrid");

const selectedTitles = [
  "one husband is enough",
  "your letter",
  "my clueless love diary",
  "our secret alliance",
  "welcome to the rose mansion"
];

async function loadHomepageKatoons() {
  try {
    const response = await fetch("http://localhost:3000/api/katoons");
    const katoons = await response.json();

    homeGrid.innerHTML = "";

    const selected = selectedTitles
      .map(title => katoons.find(k => k.title.toLowerCase() === title.toLowerCase()))
      .filter(Boolean);

    selected.forEach((katoon) => {
      homeGrid.innerHTML += `
        <div class="col">
          <article class="katoon-card">
            <img src="${katoon.cover_image}" alt="${katoon.title}">
            <div class="katoon-category">${katoon.category}</div>
            <div class="katoon-title">${katoon.title}</div>
          </article>
        </div>
      `;
    });

  } catch (err) {
    console.log("Homepage error:", err);
  }
}

window.addEventListener("load", loadHomepageKatoons);
