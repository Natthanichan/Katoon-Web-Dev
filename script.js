// navbar normal page
document.addEventListener("DOMContentLoaded", function () {
    const searchanim = document.getElementById("searchAnim");
    const loginanim = document.getElementById("loginAnim");

    searchAnim.addEventListener("click", () => {
        searchAnim.stop();
        searchAnim.play();
    });

    loginAnim.addEventListener("click", () => {
        loginAnim.stop();
        loginAnim.play();
    });
});

// navbar admin page
document.addEventListener("DOMContentLoaded", function () {
    const outAnim = document.getElementById("outAnim");
    const addBtn = document.getElementById("addBtn");
    const addAnim = document.getElementById("addAnim");
    const popup = document.getElementById("popup");
    const closeBtn = document.getElementById("closeBtn");

    // logout animation
    outAnim.addEventListener("click", () => {
        outAnim.stop();
        outAnim.play();
    });

    // add + popup
    addBtn.addEventListener("click", () => {
        addAnim.stop();
        addAnim.play();
        popup.classList.add("show"); // 👈 เปิด
    });

    // ปิด popup
    closeBtn.addEventListener("click", () => {
        popup.classList.remove("show");
    });

    // คลิกนอก = ปิด
    window.addEventListener("click", (e) => {
        if (e.target === popup) {
            popup.classList.remove("show");
        }
    });
});

// ------------------------------------------------------------------ //

// --- PUBLIC WEB SERVICE: QUOTE GARDEN ---
async function fetchDailyQuote() {
    try {
        // Fetching a random quote from the public web service
        const response = await fetch('https://quote-garden.onrender.com/api/v3/quotes/random');
        const result = await response.json();
        
        // Extracting data from the JSON response
        const quoteText = result.data[0].quoteText;
        const quoteAuthor = result.data[0].quoteAuthor;

        // Updating the homepage UI
        document.getElementById('quoteText').innerText = `"${quoteText}"`;
        document.getElementById('quoteAuthor').innerText = `- ${quoteAuthor}`;
    } catch (error) {
        console.log("Error connecting to web service:", error);
        document.getElementById('quoteText').innerText = "Keep reading, keep dreaming!";
    }
}

// Ensure the quote loads when the page opens
window.addEventListener("load", fetchDailyQuote);

// --------------------------------------------------------------------- //

function openModal() {
  document.getElementById("loginModal").style.display = "flex";
}

function closeModal() {
  document.getElementById("loginModal").style.display = "none";
}


window.onclick = function(event) {
  let modal = document.getElementById("loginModal");
  if (event.target == modal) {
    closeModal();
  }
}