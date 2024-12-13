package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entidades.Producto;
import modelos.ProductoModelo;

/**
 * Servlet implementation class ProductoServlet
 */
@WebServlet("/ProductoServlet")
public class ProductoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ProductoModelo productoModelo = new ProductoModelo();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	procesarSolicitud(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	procesarSolicitud(request, response);
    }
    
    private void procesarSolicitud(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            switch (action != null ? action : "mostrar") {
                case "mostrar":
                    mostrarProductos(request, response);
                    break;
                case "agregar":
                    agregarOActualizarProducto(request, response, false);
                    break;
                case "actualizar":
                    agregarOActualizarProducto(request, response, true);
                    break;
                case "eliminar":
                    eliminarProducto(request, response);
                    break;
                default:
                    enviarError(response, "Acción no soportada");
            }
        } catch (Exception e) {
            enviarError(response, "Error procesando la solicitud: " + e.getMessage());
        }
    }

    private void mostrarProductos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Producto> productos = productoModelo.obtenerProductos();

        String mensajeExito = (String) request.getSession().getAttribute("mensajeExito");
        String mensajeError = (String) request.getSession().getAttribute("mensajeError");
        request.setAttribute("mensajeExito", mensajeExito);
        request.setAttribute("mensajeError", mensajeError);
        request.getSession().removeAttribute("mensajeExito");
        request.getSession().removeAttribute("mensajeError");

        request.setAttribute("listProducto", productos);
        request.getRequestDispatcher("admin/producto/ProductosHome.jsp").forward(request, response);
    }

    private void agregarOActualizarProducto(HttpServletRequest request, HttpServletResponse response, boolean esActualizacion) throws ServletException, IOException {
        Producto producto = new Producto(
            esActualizacion ? request.getParameter("id") : null,
            request.getParameter("nombre"),
            request.getParameter("precio"),
            request.getParameter("stock"),
            request.getParameter("imagen")
        );

        boolean success = esActualizacion ? productoModelo.actualizarProducto(producto) : productoModelo.agregarProducto(producto);

        request.getSession().setAttribute(success ? "mensajeExito" : "mensajeError",
                success ? "Producto " + (esActualizacion ? "actualizado" : "agregado") + " exitosamente."
                        : "Error al procesar el producto.");

        response.sendRedirect(request.getContextPath() + "/ProductoServlet?action=mostrar");
    }

    private void eliminarProducto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        boolean success = productoModelo.eliminarProducto(id);

        request.getSession().setAttribute(success ? "mensajeExito" : "mensajeError",
                success ? "Producto eliminado correctamente."
                        : "Error al eliminar el producto.");

        response.sendRedirect(request.getContextPath() + "/ProductoServlet?action=mostrar");
    }

    private void enviarError(HttpServletResponse response, String mensaje) throws IOException {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, mensaje);
    }


}
