<%@page import="entidades.Usuario"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Guardar Usuarios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f9f4;
        }
        h1, h3 {
            text-align: center;
            margin-bottom: 20px;
            color: #2e7d32;
        }
        .btn-back {
            margin-bottom: 20px;
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
        .form-group input {
            border: 1px solid #c8e6c9;
        }
        .btn-primary {
            background-color: #2e7d32;
            border-color: #2e7d32;
        }
        .btn-primary:hover {
            background-color: #388e3c;
            border-color: #388e3c;
        }
        .table thead {
            background-color: #388e3c;
            color: white;
        }
        .table img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
        }
    </style>
</head>
<body class="p-4">
    <div class="container">
        <h1 class="text-center mb-4">Guardar Usuarios</h1>
        <a href="UsuarioHome.jsp" class="btn btn-primary btn-back">Regresar al Menú</a>

        <div class="form-container">
            <form name="registration" action="UsuarioServlet" method="post">
                <div class="form-group mb-3">
                    <label for="nombres">Nombres:</label>
                    <input type="text" class="form-control" id="nombres" name="nombres" required>
                </div>
                <div class="form-group mb-3">
                    <label for="apellidos">Apellidos:</label>
                    <input type="text" class="form-control" id="apellidos" name="apellidos" required>
                </div>
                <div class="form-group mb-3">
                    <label for="correo">Correo:</label>
                    <input type="email" class="form-control" id="correo" name="correo" required>
                </div>
                <div class="form-group mb-3">
                    <label for="contra">Contraseña:</label>
                    <input type="password" class="form-control" id="contra" name="contra" required>
                </div>
                <div class="form-group mb-3">
                    <label for="img">Imagen (URL):</label>
                    <input type="url" class="form-control" id="img" name="img">
                </div>
                <button type="submit" class="btn btn-primary btn-block w-100" name="action" value="guardar">Guardar</button>
            </form>
        </div>

        <h3>Lista de Usuarios</h3>
        <table class="table table-striped table-hover table-bordered">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombres</th>
                    <th>Apellido</th>
                    <th>Correo</th>
                    <th>Contraseña</th>
                    <th>Imagen</th>
                    <th>Fecha de Creación</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Usuario> listUsuario = (List<Usuario>) request.getAttribute("listUsuario");

                    if (listUsuario != null) {
                        for (Usuario u : listUsuario) {
                %>
                <tr>
                    <td><%= u.getIdUsuario() %></td>
                    <td><%= u.getNombre() %></td>
                    <td><%= u.getApellido() %></td>
                    <td><%= u.getCorreo() %></td>
                    <td><%= u.getContraseña() %></td>
                    <td><img src="<%= u.getImgUrl() %>" alt="Imagen Usuario"></td>
                    <td><%= u.getFechaCreacion() %></td>
                </tr>
                <%
                        }
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
            $("form[name='registration']").validate({
                rules: {
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
                    },
                    contra: {
                        required: true,
                        minlength: 6
                    },
                    img: {
                        url: true
                    }
                },
                messages: {
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
                    },
                    contra: {
                        required: "Ingrese la contraseña",
                        minlength: "La contraseña debe tener al menos 6 caracteres"
                    },
                    img: {
                        url: "Ingrese una URL válida"
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
