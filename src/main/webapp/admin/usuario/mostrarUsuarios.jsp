<%@page import="entidades.Usuario"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

        .custom-select {
            border-radius: 30px;
            padding: 0 20px;
            border: 1px solid #007bff;
            box-shadow: 0 2px 4px rgba(0, 123, 255, 0.2);
            transition: all 0.3s ease;
        }
        .custom-select:focus {
            border-color: #0056b3;
            box-shadow: 0 0 8px rgba(0, 123, 255, 0.5);
            outline: none;
        }

        .btn-filter {
            border-radius: 30px;
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            font-weight: bold;
            box-shadow: 0 2px 4px rgba(0, 123, 255, 0.3);
            transition: all 0.3s ease;
        }
        .btn-filter:hover {
            background-color: #0056b3;
            box-shadow: 0 4px 8px rgba(0, 123, 255, 0.5);
        }
    </style>
</head>
<body class="bg-light">
    <div class="container">
        <h1>Tabla de Usuarios</h1>
        
        <div class="col-md-6 mx-auto mb-4">
            <form action="UsuarioServlet" method="get">
                <div class="row align-items-center">
                    <div class="col-8">
                        <select class="form-control custom-select" name="cboCodeUsuarios">
                            <%
                                List<Usuario> listUsuariox = (List<Usuario>) request.getAttribute("listUsuario");
                                if (listUsuariox != null) {
                                    for (Usuario item : listUsuariox) {
                            %>
                            <option value="<%=item.getIdUsuario()%>"><%=item.getIdUsuario()%></option>
                            <%      }
                                }
                            %>
                        </select>
                    </div>
                    <div class="col-4">
                        <button type="submit" name="action" value="filtrar" class="btn btn-filter">Filtrar Código</button>
                    </div>
                </div>
            </form>
        </div>
        <a href="admin/usuario/UsuarioHome.jsp" class="btn btn-primary btn-back">Regresar al Menú</a>

        <div class="table-container">
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
                                String imgUrl = u.getImgUrl() != null && !u.getImgUrl().isEmpty() ? u.getImgUrl() : "default-avatar.png";
                    %>
                    <tr>
                        <td><%=u.getIdUsuario()%></td>
                        <td><%=u.getNombre()%></td>
                        <td><%=u.getApellido()%></td>
                        <td><%=u.getCorreo()%></td>
                        <td><%=u.getContraseña()%></td>
                        <td><img src="<%=imgUrl%>" class="img-mini-user" alt="Imagen Usuario"></td>
                        <td><%=u.getFechaCreacion()%></td>
                    </tr>
                    <%
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.4.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
