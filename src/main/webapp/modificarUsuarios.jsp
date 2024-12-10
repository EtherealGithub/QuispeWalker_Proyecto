<%@page import="entidades.Usuario"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modificar Usuarios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #fffbe6;
        }
        .btn-yellow {
            background-color: #ffc107;
            color: #212529;
        }
        .btn-yellow:hover {
            background-color: #e0a800;
            color: white;
        }
        .table thead {
            background-color: #ffc107;
            color: #212529;
        }
        .table-hover tbody tr:hover {
            background-color: #fff3cd;
        }
        .form-control {
            margin-bottom: 15px;
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
        <h1 class="text-center text-warning mb-4">Modificar Usuarios</h1>
        
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
                        <button type="submit" name="action" value="filtrarModificar" class="btn btn-filter">Filtrar Código</button>
                    </div>
                </div>
            </form>
        </div>
        
        <div class="text-start mb-3">
            <a href="UsuarioHome.jsp" class="btn btn-yellow " >Regresar al Menú</a>
        </div>

        <form action="UsuarioServlet" method="post" class="p-4 rounded shadow-sm bg-white">
            <div class="mb-3">
                <label for="idid" class="form-label">ID</label>
                <input type="text" name="id" id="idid" class="form-control" readonly>
            </div>
            <div class="mb-3">
                <label for="idnombres" class="form-label">Nombres</label>
                <input type="text" name="nombres" id="idnombres" class="form-control">
            </div>
            <div class="mb-3">
                <label for="idappaterno" class="form-label">Apellidos</label>
                <input type="text" name="apellidos" id="idapellidos" class="form-control">
            </div>
            <div class="mb-3">
                <label for="idapmaterno" class="form-label">Correo</label>
                <input type="text" name="correo" id="idcorreo" class="form-control">
            </div>
           	<div class="mb-3">
                <label for="idapmaterno" class="form-label">Contraseña</label>
                <input type="text" name="contra" id="idcontra" class="form-control">
            </div>
            <div class="mb-3">
                <label for="idapmaterno" class="form-label">Imagen URL</label>
                <input type="text" name="img" id="idimg" class="form-control">
            </div>
            <button type="submit" name="action" value="modificar" class="btn btn-yellow w-100">Modificar</button>
        </form>

        <h3 class="text-center text-warning mt-5">Lista de Usuarios</h3>
        <table class="table table-striped table-hover table-bordered mt-3" id="mitabla">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombres</th>
                    <th>Apellido</th>
                    <th>Correo</th>
                    <th>Contraseña</th>
                    <th>Imagen</th>
                    <th>Modificar</th>
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
                        <button type="button" class="btn btn-yellow" onclick="Seleccionar()">Seleccionar</button>
                    </td>
                </tr>
                <% 
                        } 
                    } 
                %>
            </tbody>
        </table>
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.1/jquery.validate.min.js"></script>
    <script type="text/javascript">
        $(function(){
            $("form[name='registration']").validate({
                rules: {
                    nombres: {
                        required: true
                    },
                    apellidos: {
                        required: true
                    },
                    correo: {
                        required: true,
                        email: true
                    },
                    contra: {
                        required: true
                    },
                    img: {
                        url: true
                    }
                },
                messages: {
                    nombres: {
                        required: "Ingrese los nombres"
                    },
                    apellidos: {
                        required: "Ingrese los apellidos"
                    },
                    correo: {
                        required: "Ingrese el correo electrónico",
                        email: "Ingrese un correo válido"
                    },
                    contra: {
                        required: "Ingrese la contraseña"
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

