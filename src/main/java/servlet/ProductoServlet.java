package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
            } else if (action.equals("editar")) {
            	editarProducto(request, response);
            } else if (action.equals("eliminar")) {
            	eliminarProducto(request, response);
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

    private void editarProducto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int idCategoria = Integer.parseInt(request.getParameter("id_categoria"));

        Categoria categoria = productoadminDAO.obtenerCategorias().stream()
                .filter(cat -> cat.getIdCategoria() == idCategoria)
                .findFirst()
                .orElse(null);

        if (categoria == null) {
            enviarError(response, "Categoría no encontrada");
            return;
        }

        Producto producto = new Producto(
            Integer.parseInt(request.getParameter("id")), 
            request.getParameter("nombre"),               
            Double.parseDouble(request.getParameter("precio")), 
            Integer.parseInt(request.getParameter("stock")), 
            request.getParameter("imagen"),               
            categoria
        );

        boolean success = productoadminDAO.actualizarProducto(producto);

        request.getSession().setAttribute(success ? "mensajeExito" : "mensajeError",
                success ? "Producto actualizado exitosamente."
                        : "Error al procesar el producto.");

        response.sendRedirect(request.getContextPath() + "/ProductoServlet?action=mostrar");
    }

    private void agregarProducto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Producto producto = consturirProductoDesdePeticion(request);
        boolean success = productoadminDAO.agregarProducto(producto);

        request.getSession().setAttribute(success ? "mensajeExito" : "mensajeError",
                success ? "Producto agregado exitosamente."
                        : "Error al agregar el producto.");

        response.sendRedirect(request.getContextPath() + "/ProductoServlet?action=mostrar");
    }

    private void eliminarProducto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        boolean success = productoadminDAO.eliminarProducto(id);

        request.getSession().setAttribute(success ? "mensajeExito" : "mensajeError",
                success ? "Producto eliminado correctamente."
                        : "Error al eliminar el producto.");

        response.sendRedirect(request.getContextPath() + "/ProductoServlet?action=mostrar");
    }

    private void enviarError(HttpServletResponse response, String mensaje) throws IOException {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, mensaje);
    }
    
    private Producto consturirProductoDesdePeticion(HttpServletRequest request) {
    	String test = request.getParameter("agregarCategoria"); 
        Categoria categoria = productoadminDAO.obtenerCategorias().stream()
                .filter(cat -> cat.getIdCategoria() == Integer.parseInt(request.getParameter("agregarCategoria")))
                .findFirst()
                .orElse(null);
        
    	Producto producto = new Producto();
        producto.setNombre(request.getParameter("requestName"));
        producto.setPrecio(request.getParameter("requestPrice") != null ? Double.parseDouble(request.getParameter("requestPrice")) : 0.0);
        producto.setStock(request.getParameter("requestStock") != null ? Integer.parseInt(request.getParameter("requestStock")) : 0);
        producto.setImagen(request.getParameter("requestImage"));
        producto.setCategoria(categoria);

        return producto;
    }
}