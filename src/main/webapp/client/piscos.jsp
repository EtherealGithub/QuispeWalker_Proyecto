<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JQ-Piscos</title>
    <link rel="stylesheet" href="client/css/productos.css">
</head>
<body>
    <header class="navbar">
        <div class="logo">
            <img src="client/imgs/LOGO-JQ.png" alt="JQLogo">
            <span>JONNY QUISPE</span>
        </div>
        <nav class="menu">
            <a href="client/index.jsp">Inicio</a>
            <a href="#">Piscos</a>
            <a href="ProductoClienteServlet?action=catalogoPorCategoria&idCategoria=2">Whiskys</a>
            <a href="ProductoClienteServlet?action=catalogoPorCategoria&idCategoria=3">Vinos</a>
            <a href="client/about.jsp">Sobre Nosotros</a>
        </nav>
        <div class="hamburger" id="hamburger">
            <span></span>
            <span></span>
            <span></span>
        </div>
    </header>
    
    <main>
        <section class="hero">
            <img src="client/imgs/BannerPisco.jpg" alt="">
            <h1>Bienvenido a Jonny Quispe</h1>
            <p>Explora nuestra colección de whiskies y vinos exclusivos</p>
        </section>

        <section class="product container">
            <h2>Catálogo de Productos</h2>
            <div class="product-grid">
                <c:forEach var="producto" items="${productos}">
                    <article class="product-item">
                        <img src="${producto.imagen}" alt="${producto.nombre}">
                        <h3>${producto.nombre}</h3>
                        <p class="price">$${producto.precio}</p>
                        <a href="#" class="btn">Comprar</a>
                    </article>
                </c:forEach>
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
                    <a href="#"><img src="client/imgs/twitter.png" alt="Twitter"></a>
                    <a href="#"><img src="client/imgs/icono facebook.jpg" alt="Facebook"></a>
                    <a href="#"><img src="client/imgs/icono whatsapp.jpg" alt="WhatsApp"></a>
                    <a href="#"><img src="client/imgs/icono tiktok.jpg" alt="TikTok"></a>
                    <a href="#"><img src="client/imgs/youtube.png" alt="YouTube"></a>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2024 JonnyQuispe. Todos los derechos reservados.</p>
        </div>
    </footer>
</body>
<script src="client/js/productos.js"></script>

</html>
