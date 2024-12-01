<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin</title>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<nav class="navbar navbar-expand-lg" style="background-color: #002855;">
    <div class="container-fluid">
        <a class="navbar-brand text-white" href="#">Admin</a>
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
            
                <li class="nav-item">
                    <a class="nav-link text-white active" aria-current="page" href="inicio.jsp">Inicio</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link text-white" href="../UsuarioServlet">Usuarios</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link text-white" href="productos.jsp">Productos</a>
                </li>
   
                <li class="nav-item">
                    <a class="nav-link text-white" href="administradores.jsp">Administradores</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
  <h1 class="text-center">Bienvenido a la Vista de Administrador</h1>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
