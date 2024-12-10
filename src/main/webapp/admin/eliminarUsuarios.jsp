<%@page import="entidades.Usuario"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eliminar Usuarios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8d7da;
        }
        .btn-red {
            background-color: #dc3545;
            color: white;
        }
        .btn-red:hover {
            background-color: #c82333;
            color: white;
        }
        .table thead {
            background-color: #dc3545;
            color: white;
        }
        .table-hover tbody tr:hover {
            background-color: #f5c6cb;
        }
        .form-control {
            margin-bottom: 15px;
        }
        .container {
            max-width: 900px;
            margin: auto;
        }
        .table-container {
            display: flex;
            justify-content: center;
        }
        .btn-fullwidth {
            width: 100%;
        }
        .table img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
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
<body class="p-4">
    <div class="container">
        <h1 class="text-center text-danger mb-4">Eliminar Usuarios</h1>
        
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
                        <button type="submit" name="action" value="filtrarEliminar" class="btn btn-filter">Filtrar Código</button>
                    </div>
                </div>
            </form>
        </div>
        
        <div class="text-start mb-3">
            <a href="admin/UsuarioHome.jsp" class="btn btn-red">Regresar al Menú</a>
        </div>

        <form action="UsuarioServlet" method="post" class="p-4 rounded shadow-sm bg-white">
            <div class="mb-3">
                <label for="idid" class="form-label">ID</label>
                <input type="text" name="id" id="idid" class="form-control" readonly>
            </div>
            <div class="mb-3">
                <label for="idnombres" class="form-label">Nombres</label>
                <input type="text" name="nombres" id="idnombres" class="form-control" readonly>
            </div>
            <div class="mb-3">
                <label for="idappaterno" class="form-label">Apellidos</label>
                <input type="text" name="apellidos" id="idapellidos" class="form-control" readonly>
            </div>
            <div class="mb-3">
                <label for="idapmaterno" class="form-label">Correo</label>
                <input type="text" name="correo" id="idcorreo" class="form-control" readonly>
            </div>
            <div class="mb-3">
                <label for="idapmaterno" class="form-label">Contraseña</label>
                <input type="text" name="contra" id="idcontra" class="form-control" readonly>
            </div>
            <div class="mb-3">
                <label for="idapmaterno" class="form-label">Imagen URL</label>
                <input type="text" name="img" id="idimg" class="form-control" readonly>
            </div>
            <div class="d-flex justify-content-between">
                <button type="submit" name="action" value="eliminar" class="btn btn-danger btn-fullwidth">Eliminar</button>
            </div>
        </form>

        <h3 class="text-center text-danger mt-5">Lista de Usuarios</h3>
        <div class="table-container">
            <table class="table table-striped table-hover table-bordered mt-3" id="mitabla">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombres</th>
                        <th>Apellido</th>
                        <th>Correo</th>
                        <th>Contraseña</th>
                        <th>Imagen</th>
                        <th>Eliminar</th>
                    </tr>
                </thead>
                <tbody id="mitabla">
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
                        <td>
                            <img src="<%= u.getImgUrl() %>" alt="Imagen Usuario">
                        </td>
                        <td>
                            <button type="button" class="btn btn-red" onclick="Seleccionar()">Seleccionar</button>
                        </td>
                    </tr>
                    <% 
                            } 
                        } 
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        function Seleccionar() {
            var table = document.getElementById("mitabla");
            for (var i = 1; i < table.rows.length; i++) {
                table.rows[i].onclick = function () {
                    document.getElementById('idid').value = this.cells[0].innerHTML; 
                    document.getElementById('idnombres').value = this.cells[1].innerHTML; 
                    document.getElementById('idapellidos').value = this.cells[2].innerHTML; 
                    document.getElementById('idcorreo').value = this.cells[3].innerHTML; 
                    document.getElementById('idcontra').value = this.cells[4].innerHTML; 
                    document.getElementById('idimg').value = this.cells[5].querySelector('img').src;
                };
            }
        }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
