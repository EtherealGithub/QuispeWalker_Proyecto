package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.DAOFactory;
import entidades.Producto;
import interfaces.ProductoInterface;
import modelos.ProductoModelo;

/**
 * Servlet implementation class ProductoClienteServlet
 */
@WebServlet("/ProductoClienteServlet")
public class ProductoClienteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	DAOFactory daoFactory = DAOFactory.getDaoFactory(DAOFactory.MYSQL);
	ProductoInterface productoclienteDAO = daoFactory.getProductoAdmin();
	
	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
        String action = request.getParameter("action");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            if (action.equals("catalogoPorCategoria")) {
            	mostrarProductosPorCategoria(request, response);
            } else {
                response.getWriter().write("{\"status\":\"error\", \"message\":\"Acción no válida.\"}");
            }
        } catch (Exception e) {
            response.getWriter().write("{\"status\":\"error\", \"message\":\"" + e.getMessage() + "\"}");
        }
    }
	
	
    private void mostrarProductosPorCategoria(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int idCategoria = Integer.parseInt(request.getParameter("idCategoria"));
        List<Producto> productos = productoclienteDAO.obtenerProductosEnStockPorCategoria(idCategoria);

        request.setAttribute("productos", productos);

        String destino;
        switch (idCategoria) {
            case 1:
                destino = "client/piscos.jsp";
                break;
            case 2:
                destino = "client/wiskys.jsp";
                break;
            case 3:
                destino = "client/vinos.jsp";
                break;
            default:
                destino = "client/index.jsp";
        }

        request.getRequestDispatcher(destino).forward(request, response);
    }

}
