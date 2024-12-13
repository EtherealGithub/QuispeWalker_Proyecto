<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Opciones de Usuarios</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
        .option-card button {
            width: 100%;
            height: 100%;
            border: none;
            background: none;
            padding: 0;
            margin: 0;
        }
        .option-card {
            cursor: pointer;
            transition: transform 0.2s ease;
        }
        .option-card:hover {
            transform: scale(1.05);
        }
    </style>
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
                    <a class="nav-link text-white" href="UsuarioHome.jsp">Usuarios</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link text-white" href="../../ProductoServlet?action=mostrar">Productos</a>
                </li>
   
                <li class="nav-item">
                    <a class="nav-link text-white" href="../administradores/AdministradorHome.jsp">Administradores</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
<div class="container my-5">
    <form action="../../UsuarioServlet" method="get">
        <div class="row text-center">

            <div class="col-md-3">
                <button name="action" value="mostrar" class="card option-card bg-primary text-white">
                    <div class="card-body">
                        <i class="fas fa-users fa-3x mb-3"></i>
                        <h5 class="card-title">Mostrar Usuarios</h5>
                    </div>
                </button>
            </div>

            <div class="col-md-3">
                <button name="action" value="guardar" class="card option-card bg-success text-white">
                    <div class="card-body">
                        <i class="fas fa-user-plus fa-3x mb-3"></i>
                        <h5 class="card-title">Guardar Usuarios</h5>
                    </div>
                </button>
            </div>

            <div class="col-md-3">
                <button name="action" value="modificar" class="card option-card bg-warning text-white">
                    <div class="card-body">
                        <i class="fas fa-user-edit fa-3x mb-3"></i>
                        <h5 class="card-title">Modificar Usuarios</h5>
                    </div>
                </button>
            </div>

            <div class="col-md-3">
                <button name="action" value="eliminar" class="card option-card bg-danger text-white">
                    <div class="card-body">
                        <i class="fas fa-user-times fa-3x mb-3"></i>
                        <h5 class="card-title">Eliminar Usuarios</h5>
                    </div>
                </button>
            </div>
        </div>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.4.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
