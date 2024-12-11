<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menú Administrador</title>
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
                    <a class="nav-link text-white active" aria-current="page" href="../inicio.jsp">Inicio</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="../usuario/UsuarioHome.jsp">Usuarios</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="../productos.jsp">Productos</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="AdministradorHome.jsp">Administradores</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <h1 class="text-center">Bienvenido a la Vista de Administrador</h1>
    
    <div class="text-center mt-4">
        <a href="GuardarAdministrador.jsp?action=guardar" class="btn btn-primary">Crear Administrador</a>
		<a href="../../AdministradorServlet?action=mostrar" class="btn btn-warning">Listar administradores</a>
		<a href="../../AdministradorServlet?action=eliminar" class="btn btn-danger">Eliminar Administrador</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
