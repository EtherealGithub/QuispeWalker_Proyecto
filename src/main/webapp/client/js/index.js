document.addEventListener("DOMContentLoaded", () => {
    const heroes = document.querySelectorAll(".hero, .hero2, .hero3, .hero4, .hero5");

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add("active");
               
                observer.unobserve(entry.target);
            }
        });
    }, {
        threshold: 0.5 
    });

    heroes.forEach(hero => observer.observe(hero));
});