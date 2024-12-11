<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JQ-Vinos</title>
    <link rel="stylesheet" href="css/productos.css">
</head>
<body>
    <header class="navbar">
        <div class="logo">
            <img src="imgs/LOGO-JQ.png" alt="JQLogo">
            <span>JONNY QUISPE</span>
        </div>
        <nav class="menu">
            <a href="index.jsp">Inicio</a>
            <a href="piscos.jsp">Piscos</a>
            <a href="vinos.jsp">Vinos</a>
            <a href="wiskys.jsp">Wisky</a>
            <a href="about.jsp">About</a>
        </nav>
        <div class="hamburger" id="hamburger">
            <span></span>
            <span></span>
            <span></span>
        </div>
    </header>
    
    <main>
        <section class="hero">
            <img src="imgs/BannerVino.jpg" alt="">
            <h1>Bienvenido a Jonny Quispe</h1>
            <p>Explora nuestra colección de whiskies y vinos exclusivos</p>
        </section>

        <section class="product container">
            <h2>Catálogo de Productos</h2>
            <div class="product-grid">
                <article class="product-item">
                    <img src="images/1.jpg" alt="Gold Label">
                    <h3>Gold Label</h3>
                    <p class="price">$200</p>
                    <a href="#" class="btn">Comprar</a>
                </article>
                <article class="product-item">
                    <img src="images/2.jpg" alt="Cardhu">
                    <h3>Cardhu</h3>
                    <p class="price">$150</p>
                    <a href="#" class="btn">Comprar</a>
                </article>
                <article class="product-item">
                    <img src="images/3.jpg" alt="Whiskey Green">
                    <h3>Whiskey Green</h3>
                    <p class="price">$100</p>
                    <a href="#" class="btn">Comprar</a>
                </article>
                <article class="product-item">
                    <img src="images/4.jpg" alt="Ron Caldas">
                    <h3>Ron Caldas</h3>
                    <p class="price">$200</p>
                    <a href="#" class="btn">Comprar</a>
                </article>
            </div>
        </section>
    </main>

    <footer>
        <div class="footer-container container">
            <div class="footer-contact">
                <h3>Contáctanos</h3>
                <p><strong>Dirección:</strong> Av. Principal 123, Lima, Perú</p>
                <p><strong>Teléfono:</strong> +51 987 654 321</p>
                <p><strong>Email:</strong> contacto@flordecana.pe</p>
            </div>
            
            <div class="footer-links">
                <h3>Enlaces Rápidos</h3>
                <ul>
                    <li><a href="Principal.html">Inicio</a></li>
                    <li><a href="Nosotros.html">Nosotros</a></li>
                    <li><a href="Catalogo.html">Catálogo</a></li>
                    <li><a href="#">Contáctanos</a></li>
                </ul>
            </div>
            
            <div class="footer-social">
                <h3>Síguenos</h3>
                <div class="social-icons">
                	<a href="#"><img src="imgs/twitter.png" alt="Twitter"></a>
                    <a href="#"><img src="imgs/icono facebook.jpg" alt="Facebook"></a>
                    <a href="#"><img src="imgs/icono whatsapp.jpg" alt="WhatsApp"></a>
                    <a href="#"><img src="imgs/icono tiktok.jpg" alt="TikTok"></a>
                    <a href="#"><img src="imgs/youtube.png" alt="YouTube"></a>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2024 JonnyQuispe. Todos los derechos reservados.</p>
        </div>
    </footer>
</body>
<script src="js/productos.js"></script>
</html>
