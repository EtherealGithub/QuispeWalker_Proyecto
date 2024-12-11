<%@ page import="entidades.Administrador"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eliminar Administrador</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-4 bg-light">
    <div class="container">
        <h1 class="text-center mb-4 text-primary">Eliminar Administradores</h1>
        <a href="AdministradorHome.jsp" class="btn btn-secondary mb-4">Regresar al Menú</a>

        <!-- Formulario de búsqueda -->
        <form action="AdministradorServlet" method="get" class="mb-4">
            <input type="hidden" name="action" value="filterByName">
            <div class="row">
                <div class="col-md-9">
                    <input type="text" class="form-control" name="nombres" placeholder="Buscar por Nombres">
                </div>
                <div class="col-md-3">
                    <button type="submit" class="btn btn-primary w-100">Buscar</button>
                </div>
            </div>
        </form>

        <h3 class="text-center">Lista de Administradores</h3>
        <table class="table table-striped table-hover table-bordered mt-3">
            <thead class="table-dark">
                <tr>
                    <th>DNI</th>
                    <th>Nombres</th>
                    <th>Apellidos</th>
                    <th>Correo</th>
                    <th>Fecha de Creación</th>
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
                    <td><%= admin.getFechaCreacion() %></td>
                    <td>
                        <a href="EliminarAdministradorServlet?dni=<%= admin.getDni() %>" class="btn btn-danger btn-sm" onclick="return confirm('¿Estás seguro de que deseas eliminar este administrador?');">Eliminar</a>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="6" class="text-center">No hay administradores registrados</td>
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
