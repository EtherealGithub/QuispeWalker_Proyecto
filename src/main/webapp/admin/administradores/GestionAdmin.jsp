<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Gestión de Administradores</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet"> <!-- Iconos de Bootstrap -->
    <style>
        .sidebar {
            height: 100vh;
            width: 250px;
            position: fixed;
            top: 0;
            left: 0;
            background-color: #343a40;
            color: white;
        }
        .sidebar .nav-link {
            color: #ddd;
        }
        .sidebar .nav-link.active {
            background-color: #007bff;
        }
        .content {
            margin-left: 260px;
            padding: 20px;
        }
    </style>
</head>
<body onload="listAdministrators(); loadRoles();">

        <!-- Sidebar -->
    <nav class="sidebar d-flex flex-column p-3">
        <h4 class="text-center mb-4">Admin</h4>
        <ul class="nav flex-column">
            <li class="nav-item mb-2">
                <a class="nav-link" href="../inicio.jsp">
                    <i class="bi bi-house-door-fill"></i> Inicio
                </a>
            </li>
            <li class="nav-item mb-2">
                <a class="nav-link active" href="#">
                    <i class="bi bi-people-fill"></i> Categorias
                </a>
            </li>
            <li class="nav-item mb-2">
                <a class="nav-link" href="../../ProductoServlet?action=mostrar">
                    <i class="bi bi-box-seam"></i> Productos
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="../administradores/GestionAdmin.jsp">
                    <i class="bi bi-person-fill"></i> Administradores
                </a>
            </li>
            <li class="nav-item mt-4">
				 <form action="<%= request.getContextPath() %>/LoginServlet" method="post">
                    <input type="hidden" name="type" value="logout">
                    <button class="btn btn-outline-light" type="submit">
                        <i class="bi bi-box-arrow-right"></i> Cerrar Sesión
                    </button>
                </form>
            </li>
        </ul>
    </nav>


    <!-- Contenido principal -->
    <div class="content">
        

        <div class="row">
            <div class="col-12 text-center">
                <h3>Listado de Administradores</h3>
            </div>
            <c:if test="${sessionScope.rol == 'OWNER'}">
                <div class="col-12">
                    <button type="button" class="btn btn-primary btn-lg" onclick="openDialog()">Nuevo Administrador</button>
                </div>
            </c:if>
            <br><br>
            <div class="col-12">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Apellido</th>
                            <th>Correo</th>
                            <th>URL</th>
                            <th>Fecha Registro</th>
                            <th>Rol</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody id="tbody">
                        <!-- Filas dinámicas -->
                    </tbody>
                </table>
            </div>
        </div>

        
    </div>

    <!-- Modal para registrar nuevo administrador -->
    <c:if test="${sessionScope.rol == 'OWNER'}">
    <div class="modal fade" id="modalForm" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title text-center" id="myModalLabel">Registrar Administrador</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>            
                </div>
                <div class="modal-body">
                    <form role="form">
                        <div class="form-group">
                            <label>Nombre</label>
                            <input class="form-control" type="text" id="inputNombre">
                        </div>
                        <div class="form-group">
                            <label>Apellido</label>
                            <input class="form-control" type="text" id="inputApellido">
                        </div>
                        <div class="form-group">
                            <label>Correo</label>
                            <input class="form-control" type="email" id="inputCorreo">
                        </div>
                        <div class="form-group">
                            <label>Contraseña</label>
                            <input class="form-control" type="password" id="inputContrasena">
                        </div>
                        <div class="form-group">
                            <label>URL</label>
                            <input class="form-control" type="text" id="inputUrl">
                        </div>
                        <div class="form-group">
                            <label>Rol</label>
                            <select class="form-select" id="inputRol">
                                <!-- Opciones dinámicas -->
                            </select>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary submitBtn d-grid gap-2 col-6 mx-auto" onclick="registerAdministrator()">Registrar</button>
                </div>
            </div>
        </div>
    </div>
    </c:if>

    <!-- Modal para actualizar/eliminar administrador -->
    <c:if test="${sessionScope.rol == 'OWNER'}">
    <div class="modal fade" id="modalFormUpdateDelete" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title text-center" id="myModalLabel">Actualizar y Eliminar Administrador</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>            
                </div>
                <div class="modal-body">
                    <form role="form">
                        <input type="hidden" id="inputIdUsuario">
                        <div class="form-group">
                            <label>Nombre</label>
                            <input class="form-control" type="text" id="updateNombre">
                        </div>
                        <div class="form-group">
                            <label>Apellido</label>
                            <input class="form-control" type="text" id="updateApellido">
                        </div>
                        <div class="form-group">
                            <label>Correo</label>
                            <input class="form-control" type="email" id="updateCorreo">
                        </div>
                        <div class="form-group">
                            <label>Contraseña</label>
                            <input class="form-control" type="password" id="updateContrasena">
                        </div>
                        <div class="form-group">
                            <label>URL</label>
                            <input class="form-control" type="text" id="updateUrl">
                        </div>
                        <div class="form-group">
                            <label>Rol</label>
                            <select class="form-select" id="updateRol">
                                <!-- Opciones dinámicas -->
                            </select>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary submitBtn d-grid gap-2 col-5 mx-auto" onclick="updateAdministrator()">Actualizar</button>
                    <button type="button" class="btn btn-danger submitBtn d-grid gap-2 col-5 mx-auto" onclick="deleteAdministrator()">Eliminar</button>
                </div>
            </div>
        </div>
    </div>
    </c:if>


<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
    listAdministrators();
    loadRoles();
});

function listAdministrators(){
    var data = {type: "list"};
    
    $.ajax({
        type: 'POST',
        contentType: "application/json",
        url: '<%= request.getContextPath() %>/AdministradorServlet',
        data: JSON.stringify(data),
        success: function(result) {
            var admins = $.parseJSON(result);
            var tblData = "";
            
            for(var i=0; i<admins.length; i++){
                tblData += "<tr>"+
                "<td>"+admins[i].idUsuario+"</td>"+
                "<td>"+admins[i].nombre+"</td>"+
                "<td>"+admins[i].apellido+"</td>"+
                "<td>"+admins[i].correo+"</td>"+
                "<td>"+admins[i].url+"</td>"+
                "<td>"+admins[i].fechaRegistro+"</td>"+
                "<td>"+admins[i].rolNombre+"</td>"+
                "<td>";

                // Solo muestra los botones de actualizar/eliminar si el rol es OWNER
                <% if (session.getAttribute("rol").equals("OWNER")) { %>
                    tblData += "<button class='btn btn-warning' onclick='openDialogUpdateDelete("+admins[i].idUsuario+")'>Actualizar</button>";
                    tblData += "<button class='btn btn-danger' onclick='deleteAdministrator("+admins[i].idUsuario+")'>Eliminar</button>";
                <% } %>

                tblData += "</td></tr>";
            }
            $('#tbody').html(tblData);
        },
        error: function(){
            alert('Error al listar los administradores');
        }
    });
}

function loadRoles(){
    var data = {type: "list"};
    
    $.ajax({
        type: 'POST',
        contentType: "application/json",
        url: '<%= request.getContextPath() %>/RolServlet',
        data: JSON.stringify(data),
        success: function(result) {
            var roles = $.parseJSON(result);
            var options = "<option selected>Seleccione el rol</option>";
            
            for(var i=0; i<roles.length; i++){
                options += "<option value='"+roles[i].idRol+"'>"+roles[i].nombre+"</option>";
            }
            $('#inputRol').html(options);
            $('#updateRol').html(options);
        },
        error: function(){
            alert('Error al cargar los roles');
        }
    });
}

function openDialog(){
    $('#modalForm').modal('show');
}

function registerAdministrator(){
    var nombre = $('#inputNombre').val();
    var apellido = $('#inputApellido').val();
    var correo = $('#inputCorreo').val();
    var contrasena = $('#inputContrasena').val();
    var url = $('#inputUrl').val();
    var idRol = $('#inputRol').val();

    var data = {
        type: "register",
        nombre: nombre,
        apellido: apellido,
        correo: correo,
        contrasena: contrasena,
        url: url,
        idRol: idRol
    };

    $.ajax({
        type: 'POST',
        contentType: "application/json",
        url: '<%= request.getContextPath() %>/AdministradorServlet',
        data: JSON.stringify(data),
        success: function(result) {
            var response = JSON.parse(result);
            alert(response.message);
            $('#modalForm').modal('hide');
            listAdministrators();
        },
        error: function(){
            alert('Error al registrar el administrador');
        }
    });
}

function openDialogUpdateDelete(id){
    var data = {type: "get", idUsuario: id};
    
    $.ajax({
        type: 'POST',
        contentType: "application/json",
        url: '<%= request.getContextPath() %>/AdministradorServlet',
        data: JSON.stringify(data),
        success: function(result) {
            var admin = $.parseJSON(result);
            $('#inputIdUsuario').val(admin.idUsuario);
            $('#updateNombre').val(admin.nombre);
            $('#updateApellido').val(admin.apellido);
            $('#updateCorreo').val(admin.correo);
            $('#updateContrasena').val(admin.contrasena);
            $('#updateUrl').val(admin.url);
            $('#updateRol').val(admin.idRol);
            $('#modalFormUpdateDelete').modal('show');
        },
        error: function(){
            alert('Error al obtener los datos del administrador');
        }
    });
}

function updateAdministrator(){
    var id = $('#inputIdUsuario').val();
    var nombre = $('#updateNombre').val();
    var apellido = $('#updateApellido').val();
    var correo = $('#updateCorreo').val();
    var contrasena = $('#updateContrasena').val();
    var url = $('#updateUrl').val();
    var idRol = $('#updateRol').val();

    var data = {
        type: "update",
        idUsuario: id,
        nombre: nombre,
        apellido: apellido,
        correo: correo,
        contrasena: contrasena,
        url: url,
        idRol: idRol
    };

    $.ajax({
        type: 'POST',
        contentType: "application/json",
        url: '<%= request.getContextPath() %>/AdministradorServlet',
        data: JSON.stringify(data),
        success: function(result) {
            var response = JSON.parse(result);
            alert(response.message);
            $('#modalFormUpdateDelete').modal('hide');
            listAdministrators();
        },
        error: function(){
            alert('Error al actualizar el administrador');
        }
    });
}

function deleteAdministrator(id){
    var data = {type: "delete", idUsuario: id};

    if(confirm('¿Estás seguro de eliminar este administrador?')){
        $.ajax({
            type: 'POST',
            contentType: "application/json",
            url: '<%= request.getContextPath() %>/AdministradorServlet',
            data: JSON.stringify(data),
            success: function(result) {
                var response = JSON.parse(result);
                alert(response.message);
                $('#modalFormUpdateDelete').modal('hide');
                listAdministrators();
            },
            error: function(){
                alert('Error al eliminar el administrador');
            }
        });
    }
}
</script>

</body>
</html>
