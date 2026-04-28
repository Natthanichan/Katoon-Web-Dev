const params = new URLSearchParams(window.location.search);
const katoonId = params.get("id");

async function loadDetail() {
    if (!katoonId) return;

    try {
        const response = await fetch(`http://localhost:3000/api/katoons/${katoonId}`);
        const katoon = await response.json();

        document.getElementById("detailCover").src = katoon.cover_image;
        document.getElementById("detailTitle").innerText = katoon.title;
        document.getElementById("detailCategory").innerText = `Category: ${katoon.category}`;
        document.getElementById("detailDay").innerText = katoon.release_day || "Monday";
        document.getElementById("detailDesc").innerText = katoon.description;

    } catch (error) {
        console.log("Detail error:", error);
    }
}

loadDetail();
