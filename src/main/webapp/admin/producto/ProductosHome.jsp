<%@page import="entidades.Categoria"%>
<%@ page import="entidades.Producto"%>
<%@ page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Mantenimiento de Productos</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css">
    <style>
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

    #layoutSidenav {
        display: flex;
        flex-direction: row;
        width: 100%;
    }

    #layoutSidenav_content {
        flex: 1;
        padding: 20px;
        margin-left: 250px;
    }

    .content {
        margin-left: 250px; 
        padding: 20px;
    }
    	
	    .table-bordered th, .table-bordered td {
	        border: 0.5px solid #dee2e6 !important;
	    }
	    input[type="search"]::-webkit-search-cancel-button {
	        -webkit-appearance: none;   
	</style>
</head>

<body class="sb-nav-fixed">

<div class="d-flex">
	<nav class="sidebar d-flex flex-column p-3">
        <h4 class="text-center mb-4">Admin</h4>
        <ul class="nav flex-column">
            <li class="nav-item mb-2">
                <a class="nav-link" href="admin/inicio.jsp">
                    <i class="bi bi-house-door-fill"></i> Inicio
                </a>
            </li>
            <li class="nav-item mb-2">
                <a class="nav-link" href="admin/categorias/CategoriaHome.jsp">
                    <i class="bi bi-people-fill"></i> Categorias
                </a>
            </li>
            <li class="nav-item mb-2">
                <a class="nav-link active" href="#">
                    <i class="bi bi-box-seam"></i> Productos
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="admin/administradores/AdministradorHome.jsp">
                    <i class="bi bi-person-fill"></i> Administradores
                </a>
            </li>
        </ul>
    </nav>

    <div id="layoutSidenav">
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-3">
                	<br>
                    <h3>Productos</h3>
                    <button class="btn btn-primary" 
                    		onclick="openDialogAddProducts()">
                    		Agregar Producto
                	</button>
                    
                    <hr>

                    <table id="tablaProductos" class="table table-bordered table-hover">
						<thead>
						    <tr>
						        <th>Nombre</th>
						        <th>Precio</th>
						        <th>Stock</th>
						        <th>Imagen</th>
						        <th>Categoría</th>
						        <th style="width: 5%" data-sortable="false"></th>
						        <th style="width: 5%" data-sortable="false"></th>
						    </tr>
						</thead>
						<tbody>
					        <c:forEach var="producto" items="${listProducto}">
					            <tr>
					                <td>${producto.nombre}</td>
					                <td>${producto.precio}</td>
					                <td>${producto.stock}</td>
					                <td><img src="${producto.imagen}" alt="" style="width: 50px;"></td>
					                <td>${producto.nombreCategoria}</td>
					                <td>
										<button type="button" class="btn btn-warning btn-sm"
										        onclick="openDialogEditProducts(${producto.id})">
										    <i class="bi bi-pencil"></i> Editar
										</button>									
					                </td>
					                <td>
					                    <button type="button" class="btn btn-danger btn-sm" 
					                            onclick="openDialogClearProducts(${producto.id}, '${producto.nombre}')">
					                        <i class="bi bi-trash"></i> Eliminar
					                    </button>
					                </td>
					            </tr>
					        </c:forEach>
						</tbody>
                    </table>
                    
                    <hr>
                    
					<div id="mensajeExito" class="alert alert-success" style="display: none;"></div>
					<div id="mensajeError" class="alert alert-danger" style="display: none;"></div>

                </div>
            </main>
                       
	        
		    <!-- Modal para agregar productos -->
	        <div class="modal fade" id="modalAgregarProducto" tabindex="-1" aria-hidden="true" role="dialog">
	            <div class="modal-dialog">
	                <div class="modal-content">
	                    <div class="modal-header">
	                        <h5 class="modal-title">Agregar Producto</h5>
	                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                    </div>
                        <div class="modal-body">
		                    <form role="form">
	                            <div class="form-group">
	                                <label for="agregarNombre" class="form-label">Nombre</label>
	                                <input id="agregarNombre" type="text" class="form-control" required>
	                            </div>
	                            <div class="form-group">
	                                <label for="agregarPrecio" class="form-label">Precio</label>
	                                <input id="agregarPrecio" type="number" class="form-control" value="0" required>
	                            </div>
	                            <div class="form-group">
	                                <label for="agregarStock" class="form-label">Stock</label>
	                                <input id="agregarStock" type="number" class="form-control" value="0" required >
	                            </div>
	                            <div class="form-group">
	                                <label for="agregarImagen" class="form-label">Imagen URL</label>
	                                <input id="agregarImagen" type="text" class="form-control" required>
	                            </div>
	                            
	                            <div class="form-group">
	                                <label for="agregarCategoria" class="form-label">Categoría</label>
	                                <select id="agregarCategoria" class="form-select" required>
                           				
                           				<option value="" >Seleccionar categoria</option>
			                            <c:forEach var="itemCategoria" items="${categorias}">
			                                <option value="${itemCategoria.idCategoria}">${itemCategoria.nombre}</option>
			                            </c:forEach>
			                            
	                                </select>
	                            </div>
		                    </form>
                        </div>
	                    <div class="modal-footer">
	                        <button type="button" class="btn btn-primary submitBtn" onclick="agregarProducto()">Agregar</button>
	                    </div>
	                </div>
	            </div>
	        </div>
		    
	        <div class="modal fade" id="modalEditarProducto" tabindex="-1" aria-hidden="true" role="dialog">
	            <div class="modal-dialog">
	                <div class="modal-content">
	                    <div class="modal-header">
	                        <h5 class="modal-title" >Editar Producto</h5>
	                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                    </div>
					    <div class="modal-body">
							<form role="form">
							        <input type="hidden" id="actualizarId">
							        <div class="form-group">
							            <label for="actualizarNombre" class="form-label">Nombre</label>
							            <input id="actualizarNombre" type="text" class="form-control" required>
							        </div>
							        <div class="form-group">
							            <label for="actualizarPrecio" class="form-label">Precio</label>
							            <input id="actualizarPrecio" type="number" class="form-control" required>
							        </div>
							        <div class="form-group">
							            <label for="actualizarStock" class="form-label">Stock</label>
							            <input id="actualizarStock" type="number" class="form-control" required>
							        </div>
							        <div class="form-group">
							            <label for="actualizarImagen" class="form-label">Imagen URL</label>
							            <input id="actualizarImagen" type="text" class="form-control" required>
							        </div>
		                            <div class="form-group">
		                                <label for="actualizarCategoria" class="form-label">Categoría</label>
		                                <select id="actualizarCategoria" class="form-select" required>
											<c:forEach var="categoria" items="${categorias}">
											    <option value="${categoria.idCategoria}">${categoria.nombre}</option>
											</c:forEach>
		                                </select>
		                            </div>
							</form>
					    </div>
					    <div class="modal-footer">
					    	<button type="button" class="btn btn-primary" onclick="modificarProducto()">Guardar Cambios</button>
					    </div>
	                </div>
	            </div>
        	</div>
        	
	        <div class="modal fade" id="modalBorrarProducto" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" role="dialog" aria-hidden="true">
	            <div class="modal-dialog modal-sm" role="document">
	                <div class="modal-content">
	                    <div class="modal-header">
	                        <h5 class="modal-title" id="modalTitleId">Alerta</h5>
	                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                    </div>
	                    <div class="modal-body">
	                        <form role="form">
	                            <input type="hidden" name="id" id="borrarId">
	       		            	<div class="form-group">
				                    <div class="form-label">¿Desea eliminar este producto?</div>
				                    <p><strong class="form-label" id="borrarNombreLabel"></strong></p>
			                    </div>
			                    <div class="form-group">
	               				    <label for="borrarNombreConfirmacion" class="form-label">Confirmar borrado:</label>
				                    <input type="text" id="borrarNombreConfirmacion" class="form-control" placeholder="Ingresar nombre del producto." required>
			                    </div>
	
	                        </form>
						</div>
	                    <div class="modal-footer">
                            <button type="button" class="btn btn-danger" onclick="borrarProducto()">Eliminar</button>
	                    </div>
	                </div>
	            </div>
	        </div>
    </div>
	
</div>
 
    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-latest.js"></script>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

	<script type="text/javascript">
	
	    (function configureDataTables() {
	        const datatablesSimple = document.getElementById('tablaProductos');
	        if (datatablesSimple) {
	            new simpleDatatables.DataTable(datatablesSimple, {
	                searchable: true,
	                perPage: 5,
	                labels: {
	                    placeholder: "Buscar...",
	                    searchTitle: "Buscar dentro de la tabla",
	                    pageTitle: "Página {page}",
	                    perPage: "registros por página",
	                    noRows: "No se encontraron registros",
	                    info: "Mostrando {start} a {end} de {rows} registros",
	                    noResults: "Ningún resultado coincide con su consulta de búsqueda",
	                }
	            });
	        }
	    })();
		
		function openDialogAddProducts(){
		    document.getElementById('agregarNombre').value = ''; 
		    document.getElementById('agregarPrecio').value = '0'; 
		    document.getElementById('agregarStock').value = '0'; 
		    document.getElementById('agregarImagen').value = ''; 
		    document.getElementById('agregarCategoria').value = ''; 
			
			$('#modalAgregarProducto').modal('show');
		}
		
		function openDialogEditProducts(id) {
		    $.ajax({
		        url: 'ProductoServlet',
		        method: 'GET',
		        data: { action: 'detalleService', id: id },
		        success: function (response) {
		            $('#actualizarId').val(response.id);
		            $('#actualizarNombre').val(response.nombre);
		            $('#actualizarPrecio').val(response.precio);
		            $('#actualizarStock').val(response.stock);
		            $('#actualizarImagen').val(response.imagen);
		            $('#actualizarCategoria').val(response.idCategoria);

		            $('#modalEditarProducto').modal('show');
		        },
		        error: function () {
		            mostrarMensajeError('Error al obtener los detalles del producto.');
		        }
		    });
		}
		
		function openDialogClearProducts(id, nombre) {
		    document.getElementById('borrarId').value = id;
		    document.getElementById('borrarNombreLabel').textContent = nombre;
		    document.getElementById('borrarNombreConfirmacion').value = '';

		    $('#modalBorrarProducto').modal('show');
		}
			    		
		function agregarProducto() {
		    
			const nombre = document.getElementById('agregarNombre').value.trim();
		    const precio = parseFloat(document.getElementById('agregarPrecio').value);
		    const stock = parseInt(document.getElementById('agregarStock').value, 10);
		    const imagen = document.getElementById('agregarImagen').value.trim();
		    const categoria = document.getElementById('agregarCategoria').value;

		    if (nombre === '' || nombre.length < 5) {
		        alert('El nombre debe tener al menos 5 caracteres.');
		        return;
		    }
		    if (isNaN(precio) || precio <= 0) {
		        alert('El precio debe ser un número mayor a 0.');
		        return;
		    }
		    if (isNaN(precio) || precio <= 0) {
		        alert('El precio debe ser un número mayor a 0.');
		        return;
		    }
		    if (!/^https?:\/\/.+\.(jpg|jpeg|png|webp|gif)$/i.test(imagen)) {
		        alert('La imagen debe ser una URL válida.');
		        return;
		    }
		    if (categoria === '') {
		        alert('Debe seleccionar una categoría.');
		        return;
		    }
		    
			const data = {
		        action: 'agregarService',
		        requestName: $('#agregarNombre').val(),
		        requestPrice: $('#agregarPrecio').val(),
		        requestStock: $('#agregarStock').val(),
		        requestImage: $('#agregarImagen').val(),
		        requestCategory: $('#agregarCategoria').val()
		    };

		    $.ajax({
		        url: 'ProductoServlet',
		        method: 'POST',
		        data: data,
		        success: function (response) {
		        	$('#modalAgregarProducto').modal('hide');
		        	if (response.status === 'success') {
		            	mostrarMensajeExito(response.message);
		                location.reload();
		            } else {
		            	mostrarMensajeError(response.message);
		            }
		        },
		        error: function () {
		            mostrarMensajeError('Error al agregar el producto.');
		        }
		    });
		}
		
		function modificarProducto() {
		    const id = document.getElementById('actualizarId').value;
		    const nombre = document.getElementById('actualizarNombre').value.trim();
		    const precio = parseFloat(document.getElementById('actualizarPrecio').value);
		    const stock = parseInt(document.getElementById('actualizarStock').value, 10);
		    const imagen = document.getElementById('actualizarImagen').value.trim();
		    const categoria = document.getElementById('actualizarCategoria').value;

		    if (nombre === '' || nombre.length < 5) {
		        alert('El nombre debe tener al menos 5 caracteres.');
		        return;
		    }
		    if (isNaN(precio) || precio <= 0) {
		        alert('El precio debe ser un número mayor a 0.');
		        return;
		    }
		    if (isNaN(stock) || stock < 0) {
		        alert('El stock debe ser un número mayor o igual a 0.');
		        return;
		    }
		    if (!/^https?:\/\/.+\.(jpg|jpeg|png|webp|gif)$/i.test(imagen)) {
		        alert('La imagen debe ser una URL válida.');
		        return;
		    }
		    if (categoria === '') {
		        alert('Debe seleccionar una categoría.');
		        return;
		    }
			
			const data = {
		        action: 'modificarService',
		        requestId: $('#actualizarId').val(),
		        requestName: $('#actualizarNombre').val(),
		        requestPrice: $('#actualizarPrecio').val(),
		        requestStock: $('#actualizarStock').val(),
		        requestImage: $('#actualizarImagen').val(),
		        requestCategory: $('#actualizarCategoria').val(),
		    };

		    $.ajax({
		        url: 'ProductoServlet',
		        method: 'POST',
		        data: data,
		        success: function (response) {
		        	document.activeElement.blur();
		        	$('#modalEditarProducto').modal('hide');
		            if (response.status === 'success') {
		                mostrarMensajeExito(response.message);
		                location.reload();
		            } else {
		                mostrarMensajeError(response.message);
		            }
		        },
		        error: function () {
		            mostrarMensajeError('Error al modificar el producto.');
		        },
		    });
		}		
		
		function borrarProducto() {
		    const nombreProducto = document.getElementById('borrarNombreLabel').textContent;
		    const nombreIngresado = document.getElementById('borrarNombreConfirmacion').value.trim();
			
		    if (nombreIngresado !== nombreProducto) {
		    	alert('El nombre ingresado no coincide con el producto.');
		        return;
		    }
		    
			const data = {
		        action: 'borrarService',
		        requestId: $('#borrarId').val(),
		    };
		    
		    $.ajax({
		        url: 'ProductoServlet',
		        method: 'POST',
		        data: data,
		        success: function (response) {
		            $('#modalBorrarProducto').modal('hide'); 
		            if (response.status === 'success') {
		                mostrarMensajeExito(response.message); 
		                location.reload();
		            } else {
		                mostrarMensajeError(response.message);
		            }
		        },
		        error: function () {
		            mostrarMensajeError('Error al eliminar el producto.'); 
		        }
		    });
		}
	
	    function mostrarMensajeExito(mensaje) {
	        const mensajeDiv = $('#mensajeExito');
	        mensajeDiv.text(mensaje).show();
	        setTimeout(() => {
	            mensajeDiv.fadeOut();
	        }, 3000);
	    }

	    function mostrarMensajeError(mensaje) {
	        const mensajeDiv = $('#mensajeError');
	        mensajeDiv.text(mensaje).show();
	        setTimeout(() => {
	            mensajeDiv.fadeOut();
	        }, 3000);
	    }


	</script>	
	
</body>
</html>