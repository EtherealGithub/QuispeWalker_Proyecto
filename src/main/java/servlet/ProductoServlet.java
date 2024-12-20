package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import dao.DAOFactory;
import entidades.Categoria;
import entidades.Producto;
import interfaces.ProductoInterface;

/**
 * Servlet implementation class ProductoServlet
 */
@WebServlet("/ProductoServlet")
public class ProductoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
	DAOFactory daoFactory = DAOFactory.getDaoFactory(DAOFactory.MYSQL);
	ProductoInterface productoadminDAO = daoFactory.getProductoAdmin();

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
        String action = request.getParameter("action");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            if (action == null || action.equals("mostrar")) {
            	mostrarProductos(request, response);
            } else if (action.equals("agregarService")) {
            	agregarProducto(request, response);
            } else if (action.equals("modificarService")) {
            	editarProducto(request, response);
            } else if (action.equals("borrarService")) {
            	eliminarProducto(request, response);
            } else if (action.equals("detalleService")) {
            	detallarProducto(request, response);
            } else {
                response.getWriter().write("{\"status\":\"error\", \"message\":\"error de accion.\"}");
            }
        } catch (Exception e) {
            response.getWriter().write("{\"status\":\"error\", \"message\":\"" + e.getMessage() + "\"}");
        }
    }
	
    private void mostrarProductos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Producto> productos = productoadminDAO.obtenerProductos();
        List<Categoria> categorias = productoadminDAO.obtenerCategorias();

        request.setAttribute("listProducto", productos);
        request.setAttribute("categorias", categorias);
        request.getRequestDispatcher("admin/producto/ProductosHome.jsp").forward(request, response);
                
    }
    
    private void detallarProducto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));

            Producto producto = productoadminDAO.obtenerProductoPorId(id);

            if (producto != null) {
                Gson gson = new Gson();
                String jsonProducto = gson.toJson(producto);

                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(jsonProducto);
            } else {
                enviarRespuesta(response, false, null, "El producto no existe.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            enviarRespuesta(response, false, null, "Error al obtener los detalles del producto: " + e.getMessage());
        }
    }

    private void editarProducto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	 	try {
	        Producto producto = consturirProductoDesdePeticion(request);
	        boolean success = productoadminDAO.actualizarProducto(producto);
	        enviarRespuesta(response, success, "Producto actualizado exitosamente.", "Error al actualizar el producto.");
	    } catch (Exception e) {
	        e.printStackTrace();    	        
	        enviarRespuesta(response, false, null, "Ocurrió un error: " + e.getMessage());
	    }
    }
    
    private void agregarProducto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	 	try {
	        Producto producto = consturirProductoDesdePeticion(request);
	        boolean success = productoadminDAO.agregarProducto(producto);		
	        enviarRespuesta(response, success, "Producto agregado exitosamente.", "Error al agregar el producto.");
	    } catch (Exception e) {
	        e.printStackTrace();    	        
	        enviarRespuesta(response, false, null, "Ocurrió un error: " + e.getMessage());
	    }
    }

    private void eliminarProducto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	 	try {
	 		int id = Integer.parseInt(request.getParameter("requestId"));
	 		
	 		Producto producto = productoadminDAO.obtenerProductoPorId(id);
            
	 		if (producto != null) {
	 			boolean success = productoadminDAO.eliminarProducto(producto.getId());
	 			enviarRespuesta(response, success, "Producto '" + producto.getNombre() + "' eliminado correctamente.", "Error al borrar el producto.");
            } else {
                enviarRespuesta(response, false, null, "El producto ya no existe.");
            }
	 		
	    } catch (Exception e) {
	        e.printStackTrace();    	        
	        enviarRespuesta(response, false, null, "Ocurrió un error: " + e.getMessage());
	    }
    }

    
    private Producto consturirProductoDesdePeticion(HttpServletRequest request) {
        
    	Producto producto = new Producto();
    	producto.setId(request.getParameter("requestId") != null ? Integer.parseInt(request.getParameter("requestId")) : null);
    	producto.setNombre(request.getParameter("requestName"));
        producto.setPrecio(request.getParameter("requestPrice") != null ? Double.parseDouble(request.getParameter("requestPrice")) : 0.0);
        producto.setStock(request.getParameter("requestStock") != null ? Integer.parseInt(request.getParameter("requestStock")) : 0);
        producto.setImagen(request.getParameter("requestImage"));
        producto.setIdCategoria(request.getParameter("requestCategory") != null ? Integer.parseInt(request.getParameter("requestCategory")) : 0);

        return producto;
    }
    
    private void enviarRespuesta(HttpServletResponse response, boolean success, String successMessage, String errorMessage) throws IOException {
        JsonObject jsonResponse = new JsonObject();
        if (success) {
            jsonResponse.addProperty("status", "success");
            jsonResponse.addProperty("message", successMessage);
        } else {
            jsonResponse.addProperty("status", "error");
            jsonResponse.addProperty("message", errorMessage);
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString());
    }
}