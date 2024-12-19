<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Gestión de Administradores</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body onload="listAdministrators(); loadRoles();">
<div class="container-fluid">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Sistema de Gestión</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarScroll" aria-controls="navbarScroll" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarScroll">
                <ul class="navbar-nav me-auto my-2 my-lg-0 navbar-nav-scroll" style="--bs-scroll-height: 100px;">
                    <li class="nav-item">
                        <a class="nav-link" href="#">Administradores</a>
                    </li>
                </ul>
                <form action="" class="d-flex">
                    <button class="btn btn-outline-light" type="submit">Cerrar Sesión</button>
                </form>
            </div>
        </div>
    </nav>

    <div class="row">
        <div class="col-12 text-center">
            <h3>Listado de Administradores</h3>
        </div>
        <div class="col-12">
            <button type="button" class="btn btn-primary btn-lg" onclick="openDialog()">Nuevo Administrador</button>
        </div>
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
</div>

<!-- Option 1: Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<!-- Option 2: Separate Popper and Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>

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
                "<td>"+
                "<button class='btn btn-primary' onclick='openDialogUpdateDelete("+admins[i].idUsuario+")'>Editar</button>"+
                "</td>"+
                "</tr>";
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
            alert(result);
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
            alert(result);
            $('#modalFormUpdateDelete').modal('hide');
            listAdministrators();
        },
        error: function(){
            alert('Error al actualizar el administrador');
        }
    });
}

function deleteAdministrator(){
    var id = $('#inputIdUsuario').val();

    var data = {type: "delete", idUsuario: id};

    if(confirm('¿Estás seguro de eliminar este administrador?')){
        $.ajax({
            type: 'POST',
            contentType: "application/json",
            url: '<%= request.getContextPath() %>/AdministradorServlet',
            data: JSON.stringify(data),
            success: function(result) {
                alert(result);
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
