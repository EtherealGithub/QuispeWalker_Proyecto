<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Sidebar</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

<style>
    .sidebar {
        background-color: #002855;
        color: white;
        min-height: 100vh;
        width: 250px;
        position: fixed;
    }

    .sidebar .nav-link {
        color: white;
        font-weight: 500;
        padding: 10px;
    }

    .sidebar .nav-link:hover {
        background-color: #003366;
        border-radius: 5px;
        color: #fff;
    }

    .sidebar .nav-link.active {
        background-color: #004080;
        border-radius: 5px;
    }

    .content {
        margin-left: 250px; 
        padding: 20px;
    }
</style>
</head>
<body>

<div class="d-flex">
    <nav class="sidebar d-flex flex-column p-3">
        <h4 class="text-center mb-4">Admin</h4>
        <ul class="nav flex-column">
            <li class="nav-item mb-2">
                <a class="nav-link active" href="inicio.jsp">
                    <i class="bi bi-house-door-fill"></i> Inicio
                </a>
            </li>
            <li class="nav-item mb-2">
                <a class="nav-link" href="categorias/CategoriaHome.jsp">
                    <i class="bi bi-people-fill"></i> Categorias
                </a>
            </li>
            <li class="nav-item mb-2">
                <a class="nav-link" href="../ProductoServlet?action=mostrar">
                    <i class="bi bi-box-seam"></i> Productos
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="administradores/GestionAdmin.jsp">
                    <i class="bi bi-person-fill"></i> Administradores
                </a>
            </li>
        </ul>
    </nav>

    <div class="content">
        <h1 class="text-center">Bienvenido a la Vista de Administrador</h1>
        <p>Este es el contenido principal de tu aplicación.</p>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
