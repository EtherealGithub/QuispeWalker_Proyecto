<%@page import="entidades.Usuario"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tabla de Usuarios</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .table-container {
            margin: 30px auto;
            max-width: 90%;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            overflow: hidden;
        }
        .img-mini-user {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
        }
        h1 {
            text-align: center;
            margin: 20px 0;
            color: #007bff;
        }
        .btn-back {
            margin: 10px 0;
            display: block;
            width: fit-content;
        }
    </style>
</head>
<body class="bg-light">
    <div class="container">
        <h1>Tabla de Usuarios</h1>
        <a href="UsuarioHome.jsp" class="btn btn-primary btn-back">Regresar al Menú</a>

            <table class="table table-striped table-hover table-bordered">
                <thead class="thead-dark">
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
                        <td><%=u.getIdUsuario()%></td>
                        <td><%=u.getNombre()%></td>
                        <td><%=u.getApellido()%></td>
                        <td><%=u.getCorreo()%></td>
                        <td><%=u.getContraseña()%></td>
                        <td><img src="<%=u.getImgUrl()%>" class="img-mini-user" alt="Imagen Usuario"></td>
                        <td><%=u.getFechaCreacion()%></td>
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
</body>
</html>
