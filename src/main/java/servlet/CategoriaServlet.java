package servlet;

import java.io.IOException;
import java.io.PrintWriter;
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
import interfaces.CategoriaInterface;

/**
 * Servlet implementation class CategoriaServlet
 */
@WebServlet("/CategoriaServlet")
public class CategoriaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CategoriaServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		JsonObject data = new Gson().fromJson(request.getReader(), JsonObject.class);
		
		String type = data.get("type").getAsString();
		
		if(type.equals("list")) {
			
			DAOFactory daoFactory = DAOFactory.getDaoFactory(DAOFactory.MYSQL);
			CategoriaInterface categoria = daoFactory.getCategoria();
			List<Categoria> listCategoria = categoria.listCategoria();
			
			Gson gson = new Gson();
			PrintWriter out = response.getWriter();
			out.print(gson.toJson(listCategoria));
			out.flush();
			
		}else if(type.equals("register")) {
			String nombre = data.get("nombre").getAsString();
			System.out.println(nombre);
			Categoria categoria = new Categoria();
			categoria.setNombre(nombre);

			DAOFactory daoFactory = DAOFactory.getDaoFactory(DAOFactory.MYSQL);
			CategoriaInterface dao = daoFactory.getCategoria();
			
			int value = dao.createCategoria(categoria);
			String mensaje = "";
			
			if(value ==1) {
				mensaje = "Registro correcto";
			}else {
				mensaje ="Registro incorrecto";
			}
			
			PrintWriter out = response.getWriter();
			out.print(mensaje);
			out.flush();
			out.close();
		}else if (type.equals("update")) {
		    int id = data.get("id").getAsInt();
		    String nombre = data.get("nombre").getAsString();

		    Categoria categoria = new Categoria();
		    categoria.setIdCategoria(id);
		    categoria.setNombre(nombre);

		    DAOFactory daoFactory = DAOFactory.getDaoFactory(DAOFactory.MYSQL);
		    CategoriaInterface dao = daoFactory.getCategoria();

		    int value = dao.updateCategoria(categoria);
		    String mensaje = (value == 1) ? "Actualización correcta" : "Actualizacion incorrecta";

		    PrintWriter out = response.getWriter();
		    out.print(mensaje);
		    out.flush();
		    out.close();
		} else if (type.equals("delete")) {
		    int id = data.get("id").getAsInt();

		    DAOFactory daoFactory = DAOFactory.getDaoFactory(DAOFactory.MYSQL);
		    CategoriaInterface dao = daoFactory.getCategoria();

		    int value = dao.deleteCategoria(id);
		    String mensaje = (value == 1) ? "Eliminación correcta" : "Eliminacion incorrecta";

		    PrintWriter out = response.getWriter();
		    out.print(mensaje);
		    out.flush();
		    out.close();
		}
	}

}
