<%@ page import="entidades.Administrador"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Guardar Administradores</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-4 bg-light">
    <div class="container">
        <h1 class="text-center mb-4 text-primary">Gestionar Administradores</h1>
        <a href="AdministradorHome.jsp" class="btn btn-secondary mb-4">Regresar al Menú</a>

        <% 
            // Obtener los datos del administrador seleccionado para modificar (si existen)
            Administrador adminSeleccionado = (Administrador) request.getAttribute("adminSeleccionado");
            String action = (adminSeleccionado != null) ? "modificar" : "guardar";
        %>

        <div class="card p-4 mb-4">
            <h4 class="card-title"><%= (adminSeleccionado != null) ? "Modificar Administrador" : "Registrar Administrador" %></h4>
            <form name="adminForm" action="GuardarAdministradorServlet" method="post">
                <div class="mb-3">
                    <label for="dni" class="form-label">DNI:</label>
                    <input type="text" class="form-control" id="dni" name="dni" value="<%= (adminSeleccionado != null) ? adminSeleccionado.getDni() : "" %>" <%= (adminSeleccionado != null) ? "readonly" : "" %> required>
                </div>
                <div class="mb-3">
                    <label for="nombres" class="form-label">Nombres:</label>
                    <input type="text" class="form-control" id="nombres" name="nombres" value="<%= (adminSeleccionado != null) ? adminSeleccionado.getNombre() : "" %>" required>
                </div>
                <div class="mb-3">
                    <label for="apellidos" class="form-label">Apellidos:</label>
                    <input type="text" class="form-control" id="apellidos" name="apellidos" value="<%= (adminSeleccionado != null) ? adminSeleccionado.getApellido() : "" %>" required>
                </div>
                <div class="mb-3">
                    <label for="correo" class="form-label">Correo:</label>
                    <input type="email" class="form-control" id="correo" name="correo" value="<%= (adminSeleccionado != null) ? adminSeleccionado.getCorreo() : "" %>" required>
                </div>
                <button type="submit" class="btn btn-primary w-100" name="action" value="<%= action %>">
                    <%= (adminSeleccionado != null) ? "Actualizar" : "Guardar" %>
                </button>
            </form>
        </div>

        <!-- Botón para cargar la lista de administradores -->
        <form action="MostrarAdministradoresServlet" method="get">
            <button type="submit" class="btn btn-primary w-100 mb-4">Cargar Administradores</button>
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
                        <a href="ModificarAdministradorServlet?dni=<%= admin.getDni() %>" class="btn btn-warning btn-sm">Modificar</a>
                        <a href="EliminarAdministradorServlet?dni=<%= admin.getDni() %>" class="btn btn-danger btn-sm">Eliminar</a>
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.1/jquery.validate.min.js"></script>
    <script type="text/javascript">
        $(function(){
            $("form[name='adminForm']").validate({
                rules: {
                    dni: {
                        required: true,
                        digits: true,
                        minlength: 8,
                        maxlength: 8
                    },
                    nombres: {
                        required: true,
                        minlength: 3,
                        maxlength: 50
                    },
                    apellidos: {
                        required: true,
                        minlength: 3,
                        maxlength: 50
                    },
                    correo: {
                        required: true,
                        email: true
                    }
                },
                messages: {
                    dni: {
                        required: "Ingrese el DNI",
                        digits: "El DNI debe contener solo números",
                        minlength: "El DNI debe tener 8 dígitos",
                        maxlength: "El DNI debe tener 8 dígitos"
                    },
                    nombres: {
                        required: "Ingrese los nombres",
                        minlength: "Los nombres deben tener al menos 3 caracteres",
                        maxlength: "Los nombres no deben exceder los 50 caracteres"
                    },
                    apellidos: {
                        required: "Ingrese los apellidos",
                        minlength: "Los apellidos deben tener al menos 3 caracteres",
                        maxlength: "Los apellidos no deben exceder los 50 caracteres"
                    },
                    correo: {
                        required: "Ingrese el correo electrónico",
                        email: "Ingrese un correo válido"
                    }
                },
                submitHandler: function(form) {
                    form.submit();
                }
            });
        });
    </script>
</body>
</html>
