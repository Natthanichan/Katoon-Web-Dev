const params    = new URLSearchParams(window.location.search);
const katoonId  = params.get("id");

async function loadDetail() {
    if (!katoonId) {
        console.log("No katoon ID in URL");
        return;
    }

    try {
        const response = await fetch(`http://localhost:3000/api/katoons/${katoonId}`);

        if (!response.ok) throw new Error("Katoon not found");

        const katoon = await response.json();

        document.getElementById("detailCover").src = katoon.cover_image || "";
        document.getElementById("detailTitle").innerText    = katoon.title || "Unknown Title";
        document.getElementById("detailCategory").innerText = `Category: ${katoon.category || "—"}`;
        document.getElementById("detailDay").innerText      = katoon.release_day || "—";
        document.getElementById("detailDesc").innerText     = katoon.description || "No description available.";

        // Update page title
        document.title = `KATOON | ${katoon.title}`;

    } catch (error) {
        console.log("Detail error:", error);
        document.getElementById("detailTitle").innerText = "Could not load katoon details.";
    }
}

window.addEventListener("load", loadDetail);