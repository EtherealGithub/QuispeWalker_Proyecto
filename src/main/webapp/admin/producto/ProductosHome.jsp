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

                    <table id="datatablesSimple" class="table table-bordered table-hover">
						<thead>
						    <tr>
						        <th>Nombre</th>
						        <th>Precio</th>
						        <th>Stock</th>
						        <th>Imagen</th>
						        <th>Categoría</th> <!-- Nueva columna -->
						        <th style="width: 5%" data-sortable="false"></th>
						        <th style="width: 5%" data-sortable="false"></th>
						    </tr>
						</thead>
						<tbody>
						    <% 
						        List<Producto> productos = (List<Producto>) request.getAttribute("listProducto");
						        if (productos != null) {
						            for (Producto producto : productos) {
						    %>
						            <tr>
						                <td><%= producto.getNombre() %></td>
						                <td><%= producto.getPrecio() %></td>
						                <td><%= producto.getStock() %></td>
						                <td><img src="<%= producto.getImagen() %>" alt="Imagen del Producto" style="width: 50px;"></td>
						                <td><%= producto.getCategoria().getNombre() %></td>
						                <td>
						                    <button type="button" class="btn btn-warning btn-sm" 
						                            data-bs-toggle="modal" 
						                            data-bs-target="#editarProductoModal"
						                            data-bs-id="<%= producto.getId() %>"
						                            data-bs-nombre="<%= producto.getNombre() %>"
						                            data-bs-precio="<%= producto.getPrecio() %>"
						                            data-bs-stock="<%= producto.getStock() %>"
						                            data-bs-imagen="<%= producto.getImagen() %>"
						                            data-bs-id-categoria="<%= producto.getCategoria().getIdCategoria() %>">
						                        <i class="bi bi-pencil"></i> Editar
						                    </button>
						                </td>
						                <td>
						                    <button type="button" 
						                            class="btn btn-danger btn-sm" 
						                            data-bs-toggle="modal" 
						                            data-bs-target="#eliminaModal" 
						                            data-bs-id="<%= producto.getId() %>">
						                        <i class="bi bi-trash"></i> Eliminar
						                    </button>
						                </td>
						            </tr>
						    <% 
						            }
						        }
						    %>
						</tbody>
                    </table>
                    
                    <hr>
                    
   						<% 
						    String mensajeExito = (String) request.getAttribute("mensajeExito");
						    if (mensajeExito != null) {
						%>
						    <div class="alert alert-success" role="alert" id="mensajeExito">
						        <%= mensajeExito %>
						    </div>
						<% 
						    }
						
						    String mensajeError = (String) request.getAttribute("mensajeError");
						    if (mensajeError != null) {
						%>
						    <div class="alert alert-danger" role="alert" id="mensajeError">
						        <%= mensajeError %>
						    </div>
						<% 
						    }
						%>
                </div>
            </main>
            
            <%
            	List<Categoria> categorias = (List<Categoria>) request.getAttribute("categorias");
			%>
            

	        <!-- Modal de confirmación de eliminación -->
	        <div class="modal fade" id="eliminaModal" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" role="dialog" aria-labelledby="modalTitleId" aria-hidden="true">
	            <div class="modal-dialog modal-sm" role="document">
	                <div class="modal-content">
	                    <div class="modal-header">
	                        <h5 class="modal-title" id="modalTitleId">Alerta</h5>
	                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                    </div>
	                    <div class="modal-body">¿Desea eliminar este producto?</div>
	                    <div class="modal-footer">
	                        <form action="ProductoServlet?action=eliminar" method="post">
	                            <input type="hidden" name="id" id="productoId">
	                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
	                            <button type="submit" class="btn btn-danger">Eliminar</button>
	                        </form>
	                    </div>
	                </div>
	            </div>
	        </div>
	        
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
		                                <label for="nombre" class="form-label">Nombre</label>
		                                <input id="agregarNombre" name="nombre" type="text" class="form-control" required>
		                            </div>
		                            <div class="form-group">
		                                <label for="precio" class="form-label">Precio</label>
		                                <input id="agregarPrecio" name="precio" type="number" class="form-control" required>
		                            </div>
		                            <div class="form-group">
		                                <label for="stock" class="form-label">Stock</label>
		                                <input id="agregarStock" name="stock" type="number" class="form-control" required >
		                            </div>
		                            <div class="form-group">
		                                <label for="imagen" class="form-label">Imagen URL</label>
		                                <input id="agregarImagen" name="imagen" type="text" class="form-control" required>
		                            </div>
		                            <div class="form-group">
		                                <label for="categoria">Categoría</label>
		                                <select id="agregarCategoria" name="id_categoria" class="form-select" required>
	                           				
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
		    
			<!-- Modal para editar producto -->
	        <div class="modal fade" id="editarProductoModal" tabindex="-1" aria-labelledby="editarProductoModalLabel" aria-hidden="true">
	            <div class="modal-dialog">
	                <div class="modal-content">
	                    <div class="modal-header">
	                        <h5 class="modal-title" id="editarProductoModalLabel">Editar Producto</h5>
	                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                    </div>
						<form action="ProductoServlet?action=editar" method="POST">
						    <div class="modal-body">
						        <input type="hidden" id="idProducto" name="id">
						        <div class="form-group">
						            <label for="nombreProducto" class="form-label">Nombre</label>
						            <input type="text" class="form-control" id="nombreProducto" name="nombre" required>
						        </div>
						        <div class="form-group">
						            <label for="precioProducto" class="form-label">Precio</label>
						            <input type="number" class="form-control" id="precioProducto" name="precio" required>
						        </div>
						        <div class="form-group">
						            <label for="stockProducto" class="form-label">Stock</label>
						            <input type="number" class="form-control" id="stockProducto" name="stock" required>
						        </div>
						        <div class="form-group">
						            <label for="imagenProducto" class="form-label">Imagen URL</label>
						            <input type="text" class="form-control" id="imagenProducto" name="imagen">
						        </div>
	                            <div class="form-group">
	                                <label for="categoriaEditar">Categoría</label>
	                                <select class="form-select" id="categoriaEditar" name="id_categoria" required>
	                                    <option value=""> </option>
	                                    <% 
	                                        for (Categoria categoria : categorias) {
	                                    %>
	                                    <option value="<%= categoria.getIdCategoria() %>"><%= categoria.getNombre() %></option>
	                                    <% 
	                                        }
	                                    %>
	                                </select>
	                            </div>
						    </div>
						    <div class="modal-footer">
						        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
						        <button type="submit" class="btn btn-primary">Guardar Cambios</button>
						    </div>
						</form>

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
	    // Configuracion de DataTables
		function openDialogAddProducts(){
			$('#modalAgregarProducto').modal('show');
		}
	    
		function agregarProducto() {
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
				success: function () {
					location.reload();
				},
				error: function () {
					console.error('Error al registrar el producto.');
				}
			});
		}
		
	    (function configureDataTables() {
	        const datatablesSimple = document.getElementById('datatablesSimple');
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
	    	
	    // Configuracion del modal de eliminacion
	    (function configureDeleteModal() {
	        const eliminaModal = document.getElementById('eliminaModal');
	        if (eliminaModal) {
	            eliminaModal.addEventListener('show.bs.modal', function(event) {
	                const button = event.relatedTarget;
	                const id = button.getAttribute('data-bs-id');
	                eliminaModal.querySelector('#productoId').value = id;
	            });
	        }
	    })();
	
	    // Ocultar mensajes
	    (function autoHideMessages() {
	        setTimeout(() => {
	            ['mensajeExito', 'mensajeError'].forEach(id => {
	                const element = document.getElementById(id);
	                if (element) element.style.display = 'none';
	            });
	        }, 2000);
	    })();
	

	</script>
	
	<script>
		let editarProductoModal = document.getElementById('editarProductoModal');
		editarProductoModal.addEventListener('show.bs.modal', function(event) {
		    let button = event.relatedTarget;
	
		    let id = button.getAttribute('data-bs-id');
		    let nombre = button.getAttribute('data-bs-nombre');
		    let precio = button.getAttribute('data-bs-precio');
		    let stock = button.getAttribute('data-bs-stock');
		    let imagen = button.getAttribute('data-bs-imagen');
		    let categoriaId = button.getAttribute('data-bs-id-categoria');
	
		    editarProductoModal.querySelector('#idProducto').value = id;
		    editarProductoModal.querySelector('#nombreProducto').value = nombre;
		    editarProductoModal.querySelector('#precioProducto').value = precio;
		    editarProductoModal.querySelector('#stockProducto').value = stock;
		    editarProductoModal.querySelector('#imagenProducto').value = imagen;
		    editarProductoModal.querySelector('#categoriaEditar').value = categoriaId;
		});

	</script>

</body>
</html>
