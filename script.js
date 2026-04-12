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