const hamburger = document.getElementById('hamburger');
const navbar = document.querySelector('header.navbar');

hamburger.addEventListener('click', () => {
    navbar.classList.toggle('active');
});

