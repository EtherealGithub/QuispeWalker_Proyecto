<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mantenimiento de Categorias</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
<style>
    body, html {
        height: 100%;
        margin: 0;
    }

    .wrapper {
        display: flex;
        min-height: 100vh;
    }

    .sidebar {
        background-color: #002855;
        color: white;
        min-height: 100vh;
        width: 250px;
        position: fixed;
    }

    .sidebar .nav-link {
        color: white;
        font-weight: 500;
        padding: 10px;
    }

    .sidebar .nav-link:hover {
        background-color: #003366;
        border-radius: 5px;
        color: #fff;
    }

    .sidebar .nav-link.active {
        background-color: #004080;
        border-radius: 5px;
    }

    .content {
        margin-left: 250px; 
        flex: 1;
        padding: 20px;
    }
</style>
</head>
<body onload="listCategoria();">
<div class="wrapper">
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
                <a class="nav-link" href="../administradores/AdministradorHome.jsp">
                    <i class="bi bi-person-fill"></i> Administradores
                </a>
            </li>
        </ul>
    </nav>

    <!-- Main Content -->
    <div class="content">
        <div class="row">
            <div class="col-12 text-center mb-3">
                <h3>Mantenimiento de Categorias</h3>
            </div>
            <div class="col-12 mb-3">
                <button type="button" class="btn btn-success btn-lg" onclick="openDialog()">Registrar</button>
            </div>
            <div class="col-12">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Id</th>
                            <th>Categoria</th>
                            <th>Opciones</th>
                        </tr>
                    </thead>
                    <tbody id="tbody"></tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="modalForm" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">Registrar/Actualizar Categoria</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="CategoriaServlet" role="form">
                    <input type="hidden" id="inputType" value="register">
                    <input type="hidden" id="inputId"> <!-- ID para actualizar -->
                    <div class="form-group">
                        <label>Nombre</label>
                        <input class="form-control" type="text" id="inputName">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-primary submitBtn" onclick="registrarCategoria()">Guardar</button>
            </div>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
function listCategoria(){
    var data = {type:"list"};
    $.ajax({
        type: 'POST',
        contentType: "application/json",
        url: "/JQ.zip/CategoriaServlet",
        data: JSON.stringify(data),
        success: function(result){ 
            var categoria = $.parseJSON(result);
            var tblData = "";

            for (var i = 0; i < categoria.length; i++) {
                tblData += "<tr> <td>" + categoria[i].idCategoria + "</td>" +
                    "<td>" + categoria[i].nombre + "</td> " +
                    "<td>" +
                    "<button class='btn btn-warning btn-sm me-2' onclick=\"openUpdateDialog(" + categoria[i].idCategoria + ", '" + categoria[i].nombre + "')\">Editar</button>" +
                    "<button class='btn btn-danger btn-sm' onclick=\"eliminarCategoria(" + categoria[i].idCategoria + ")\">Eliminar</button>" +
                    "</td></tr>";
            }
            $('#tbody').html(tblData);
        },
        error: function(){
            console.log("Error al cargar los datos.");
        }
    });
}

function openDialog(){
    $('#inputType').val("register");
    $('#inputId').val("");
    $('#inputName').val("");
    $('#modalForm').modal('show');
}

function openUpdateDialog(id, nombre) {
    $('#inputType').val("update");
    $('#inputId').val(id);
    $('#inputName').val(nombre);
    $('#modalForm').modal('show');
}

function registrarCategoria(){
    var idVar = $('#inputId').val();
    var nameVar = $('#inputName').val();
    var typeVar = $('#inputType').val();
    
    var data = {type: typeVar, id: idVar, nombre: nameVar};
    
    $.ajax({
        type: 'POST',
        contentType: "application/json",
        url: "/JQ.zip/CategoriaServlet",
        data: JSON.stringify(data),
        success: function(result){ 
            alert(result);
            listCategoria();
            $('#modalForm').modal('hide');
        },
        error: function(){
            console.log("Error al guardar los datos.");
        }
    });
}

function eliminarCategoria(id) {
    if(confirm("¿Seguro que deseas eliminar esta categoria?")) {
        var data = {type: "delete", id: id};

        $.ajax({
            type: 'POST',
            contentType: "application/json",
            url: "/JQ.zip/CategoriaServlet",
            data: JSON.stringify(data),
            success: function(result){ 
                alert(result);
                listCategoria();
            },
            error: function(){
                console.log("Error al eliminar los datos.");
            }
        });
    }
}
</script>
</body>
</html>
