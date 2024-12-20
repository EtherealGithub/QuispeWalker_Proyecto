<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JQ-Wiskys</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
            <a href="ProductoClienteServlet?action=catalogoPorCategoria&idCategoria=1">Piscos</a>
            <a href="#">Whiskys</a>
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
            <img src="client/imgs/BannerWisky.jpg" alt="">
            <h1>Bienvenido a Jonny Quispe</h1>
            <p>Explora nuestra colección de whiskies y vinos exclusivos</p>
        </section>

        <section class="product container" >
            <h2>Catálogo de Productos</h2>
            <br>
            <div class="row">
                <c:forEach var="producto" items="${productos}">
                    <div class="col-md-4 mb-4">
                        <div class="card" style="background-color: #39210F; color: #FFFFFF; border: none; border-radius: 20px; text-align: center; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);">
                            <img src="${producto.imagen}" alt="${producto.nombre}" class="card-img-top">
                            <div class="card-body">
                                <h5 class="card-title">${producto.nombre}</h5>
                                <p class="card-text">$${producto.precio}</p>
                                <button class="btn btn-primary" data-toggle="modal" data-target="#productModal" 
                                    onclick="setModalData('${producto.id}', '${producto.nombre}', '${producto.precio}', '${producto.imagen}')">
                                    Comprar
                                </button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </section>
    </main>
    
   	<div class="modal fade" id="productModal" tabindex="-1" role="dialog" aria-labelledby="productModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="background-color: #153750; color: #FFFFFF; border: none; border-radius: 15px; text-align: center; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalProductName">Nombre del Producto</h5>
                </div>
                <div class="modal-body">
                    <img id="modalProductImage" src="" alt="Imagen del producto" class="img-fluid mb-3">
                    <p><strong>ID:</strong> <span id="modalProductId">12345</span></p>
                    <p><strong>Precio Unitario:</strong> $<span id="modalProductPrice">0.00</span></p>
                    <label for="productQuantity">Cantidad:</label>
                    <input type="number" id="productQuantity" class="form-control" value="1" min="1" max="99">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                    <button type="button" class="btn btn-primary">Agregar al Carrito</button>
                </div>
            </div>
        </div>
    </div>

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
    
    <script>
        function setModalData(id, nombre, precio, imagen) {
            document.getElementById("modalProductId").textContent = id;
            document.getElementById("modalProductName").textContent = nombre;
            document.getElementById("modalProductPrice").textContent = precio;
            document.getElementById("modalProductImage").src = imagen;
        }
    </script>
    
</body>
<script src="client/js/productos.js"></script>
</html>
