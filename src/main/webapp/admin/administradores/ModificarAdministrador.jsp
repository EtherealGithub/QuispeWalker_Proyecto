<%@ page import="entidades.Administrador"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modificar Administrador</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f9f4;
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
            color: #2e7d32;
        }
        .form-container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }
        .form-group label {
            color: #388e3c;
        }
        .btn-primary {
            background-color: #2e7d32;
            border-color: #2e7d32;
        }
    </style>
</head>
<body class="p-4">
    <div class="container">
        <h1>Modificar Administrador</h1>
        <a href="AdministradorServlet?action=mostrar" class="btn btn-primary mb-4">Volver a la Lista</a>

        <div class="form-container">
            <form action="AdministradorServlet?action=modificar" method="post">
                <div class="form-group mb-3">
                    <label for="dni">DNI:</label>
                    <input type="text" class="form-control" id="dni" name="dni" value="<%= ((Administrador) request.getAttribute("adminSeleccionado")).getDni() %>" readonly>
                </div>
                <div class="form-group mb-3">
                    <label for="nombres">Nombres:</label>
                    <input type="text" class="form-control" id="nombres" name="nombres" value="<%= ((Administrador) request.getAttribute("adminSeleccionado")).getNombre() %>" required>
                </div>
                <div class="form-group mb-3">
                    <label for="apellidos">Apellidos:</label>
                    <input type="text" class="form-control" id="apellidos" name="apellidos" value="<%= ((Administrador) request.getAttribute("adminSeleccionado")).getApellido() %>" required>
                </div>
                <div class="form-group mb-3">
                    <label for="correo">Correo:</label>
                    <input type="email" class="form-control" id="correo" name="correo" value="<%= ((Administrador) request.getAttribute("adminSeleccionado")).getCorreo() %>" required>
                </div>
                <button type="submit" class="btn btn-primary" name="action" value="actualizar">Actualizar Datos</button>
            </form>
        </div>

        <h3 class="text-center">Lista de Administradores</h3>
        <table class="table table-striped table-hover table-bordered mt-3">
            <thead class="table-dark">
                <tr>
                    <th>DNI</th>
                    <th>Nombres</th>
                    <th>Apellidos</th>
                    <th>Correo</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Administrador> listAdministrador = (List<Administrador>) request.getAttribute("listAdministradores");
                    if (listAdministrador != null && !listAdministrador.isEmpty()) {
                        for (Administrador admin : listAdministrador) {
                %>
                <tr>
                    <td><%= admin.getDni() %></td>
                    <td><%= admin.getNombre() %></td>
                    <td><%= admin.getApellido() %></td>
                    <td><%= admin.getCorreo() %></td>
                    <td>
                        <a href="../../AdministradorServlet?action=modificar&dni=<%= admin.getDni() %>" class="btn btn-warning btn-sm">Modificar</a>
                        <a href="AdministradorServlet?action=eliminar&dni=<%= admin.getDni() %>" class="btn btn-danger btn-sm" onclick="return confirm('¿Estás seguro de que deseas eliminar este administrador?');">Eliminar</a>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="5" class="text-center">No hay administradores registrados</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.4.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
