<%@ page import="entidades.Producto"%>
<%@ page import="java.util.List"%>

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
	    .table-bordered th, .table-bordered td {
	        border: 0.5px solid #dee2e6 !important;
	    }
	    input[type="search"]::-webkit-search-cancel-button {
	        -webkit-appearance: none;   
	</style>
</head>

<body class="sb-nav-fixed">
<nav class="navbar navbar-expand-lg" style="background-color: #002855;">
    <div class="container-fluid">
        <a class="navbar-brand text-white" href="#">Admin</a>
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
            
                <li class="nav-item">
                    <a class="nav-link text-white active" aria-current="page" href="admin/inicio.jsp">Inicio</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link text-white" href="admin/usuario/UsuarioHome.jsp">Usuarios</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link text-white" href="">Productos</a>
                </li>
   
                <li class="nav-item">
                    <a class="nav-link text-white" href="administradores.jsp">Administradores</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

    <div id="layoutSidenav">
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-3">
                	<br>
                    <h3>Productos</h3>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#agregarProductoModal">Agregar</button>
                    
                    <hr>

                    <table id="datatablesSimple" class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>Nombre</th>
                                <th>Precio</th>
                                <th>Stock</th>
                                <th>Imagen</th>
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
							            <td><%= producto.getImagen() %></td>
							            <td>
										    <button type="button" class="btn btn-warning btn-sm" 
										            data-bs-toggle="modal" 
										            data-bs-target="#editarProductoModal"
										            data-bs-id="<%= producto.getId() %>"
										            data-bs-nombre="<%= producto.getNombre() %>"
										            data-bs-precio="<%= producto.getPrecio() %>"
										            data-bs-stock="<%= producto.getStock() %>"
										            data-bs-imagen="<%= producto.getImagen() %>">
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
	        
		    <!-- Modal para agregar un producto -->
		    <div class="modal fade" id="agregarProductoModal" tabindex="-1" aria-labelledby="agregarProductoModalLabel" aria-hidden="true">
		        <div class="modal-dialog">
		            <div class="modal-content">
		                <div class="modal-header">
		                    <h5 class="modal-title" id="agregarProductoModalLabel">Agregar Producto</h5>
		                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		                </div>
	                    <form action="ProductoServlet?action=agregar" method="POST">
		                    <div class="modal-body">
		                        <div class="form-group">
		                            <label for="nombre" class="form-label">Nombre</label>
		                            <input type="text" class="form-control" id="nombre" name="nombre" required>
		                        </div>
		                        <div class="form-group">
		                            <label for="precio" class="form-label">Precio</label>
		                            <input type="number" class="form-control" id="precio" name="precio" required>
		                        </div>
		                        <div class="form-group">
		                            <label for="stock" class="form-label">Stock</label>
		                            <input type="number" class="form-control" id="stock" name="stock" required>
		                        </div>
		                        <div class="form-group">
								    <label for="imagen" class="form-label">Imagen URL</label>
								    <input type="text" class="form-control" id="imagen" name="imagen">
								</div>
		                        
	                        </div>
   			                <div class="modal-footer">
			                    <button type="submit" class="btn btn-success">Guardar</button>
			                </div>

	                    </form>
		            </div>
		        </div>
		    </div>
		    
			<!-- Modal para editar producto -->
			<div class="modal fade" id="editarProductoModal" tabindex="-1" role="dialog" aria-labelledby="editarProductoModalLabel" aria-hidden="true">
			    <div class="modal-dialog" role="document">
			        <div class="modal-content">
			            <div class="modal-header">
			                <h5 class="modal-title" id="editarProductoModalLabel">Editar Producto</h5>
			                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
			            </div>
			            <form action="ProductoServlet" method="POST">
			                <div class="modal-body">
			                    <input type="hidden" id="id" name="id">
			
			                    <div class="form-group">
			                        <label for="nombre">Nombre del Producto</label>
			                        <input type="text" class="form-control" id="nombre" name="nombre" required>
			                    </div>
			
			                    <div class="form-group">
			                        <label for="precio">Precio</label>
			                        <input type="number" class="form-control" id="precio" name="precio" required>
			                    </div>
			
			                    <div class="form-group">
			                        <label for="stock">Stock</label>
			                        <input type="number" class="form-control" id="stock" name="stock" required>
			                    </div>
			                    <div class="form-group">
								    <label for="imagen" class="form-label">Imagen URL</label>
								    <input type="text" class="form-control" id="imagen" name="imagen">
								</div>
			                </div>
			                <div class="modal-footer">
			                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
			                    <button type="submit" name="action" value="actualizar" class="btn btn-primary">Guardar Cambios</button>
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
    <script src="js/scripts.js"></script>

	<script>
	    // Configuracion de DataTables
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
	
	        let modalInputId = editarProductoModal.querySelector('#id');
	        let modalInputNombre = editarProductoModal.querySelector('#nombre');
	        let modalInputPrecio = editarProductoModal.querySelector('#precio');
	        let modalInputStock = editarProductoModal.querySelector('#stock');
	        let modalInputImagen = editarProductoModal.querySelector('#imagen');
	
	        modalInputId.value = id;
	        modalInputNombre.value = nombre;
	        modalInputPrecio.value = precio;
	        modalInputStock.value = stock;
	        modalInputImagen.value = imagen;
	    });
	</script>

</body>
</html>
