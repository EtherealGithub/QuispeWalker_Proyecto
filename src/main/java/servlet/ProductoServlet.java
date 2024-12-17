package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entidades.Categoria;
import entidades.Producto;
import modelos.ProductoModelo;

/**
 * Servlet implementation class ProductoServlet
 */
@WebServlet("/ProductoServlet")
public class ProductoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductoModelo productoModelo = new ProductoModelo();

    public ProductoServlet() {
        super();
    }

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
                    agregarProducto(request, response);
                    break;
                case "eliminar":
                    eliminarProducto(request, response);
                    break;
                case "editar": 
                    editarProducto(request, response);
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
        List<Categoria> categorias = productoModelo.obtenerCategorias();

        request.setAttribute("listProducto", productos);
        request.setAttribute("categorias", categorias);
        request.getRequestDispatcher("admin/producto/ProductosHome.jsp").forward(request, response);
    }

    private void editarProducto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int idCategoria = Integer.parseInt(request.getParameter("id_categoria"));

        Categoria categoria = productoModelo.obtenerCategorias().stream()
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

        boolean success = productoModelo.actualizarProducto(producto);

        request.getSession().setAttribute(success ? "mensajeExito" : "mensajeError",
                success ? "Producto actualizado exitosamente."
                        : "Error al procesar el producto.");

        response.sendRedirect(request.getContextPath() + "/ProductoServlet?action=mostrar");
    }

    private void agregarProducto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String precioStr = request.getParameter("precio");
        String stockStr = request.getParameter("stock");
        String imagen = request.getParameter("imagen");
        String idCategoriaStr = request.getParameter("id_categoria");

        int idCategoria = Integer.parseInt(idCategoriaStr);

        Categoria categoria = productoModelo.obtenerCategorias().stream()
                .filter(cat -> cat.getIdCategoria() == idCategoria)
                .findFirst()
                .orElse(null);

        if (categoria == null) {
            enviarError(response, "Categoría no encontrada");
            return;
        }

        double precio = Double.parseDouble(precioStr);
        int stock = Integer.parseInt(stockStr);

        Producto producto = new Producto(nombre, precio, stock, imagen, categoria);

        boolean success = productoModelo.agregarProducto(producto);

        request.getSession().setAttribute(success ? "mensajeExito" : "mensajeError",
                success ? "Producto agregado exitosamente."
                        : "Error al agregar el producto.");

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
