package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entidades.Productos.Producto;
import modelos.ProductoModelo;

/**
 * Servlet implementation class ProductoClienteServlet
 */
@WebServlet("/ProductoClienteServlet")
public class ProductoClienteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ProductoModelo productoModelo = new ProductoModelo();
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		verProductosCliente(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
    private void verProductosCliente(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Producto> productos = productoModelo.obtenerProductos();
        request.setAttribute("listProducto", productos);
        request.getRequestDispatcher("cliente/productos.jsp").forward(request, response);
    }

}
