package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import modelos.UsuarioModelo;
import entidades.*;
/**
 * Servlet implementation class UsuarioServlet
 */
@WebServlet("/UsuarioServlet")
public class UsuarioServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UsuarioServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		
		switch (action) {
		case "mostrar": mostrarUsuarios(request, response); break;
		case "guardar": mostrarUsuariosGuardar(request, response); break;
		case "modificar":mostrarUsuariosModificar(request, response); break;
		case "eliminar":mostrarUsuariosEliminar(request, response); break;
		}
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		
		switch (action) {
		case "guardar": guardarUsuarios(request, response); break;
		case "modificar":modificarUsuarios(request, response); break;
		case "eliminar":eliminarUsuarios(request, response); break;
		}
	}
	
	//Mostrar general, es lo que llamo al inicio
	private void mostrarUsuarios(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UsuarioModelo model = new UsuarioModelo();
		List<Usuario> usuarios =model.listUsuario();
		request.setAttribute("listUsuario", usuarios);
		request.getRequestDispatcher("mostrarUsuarios.jsp").forward(request, response);
	}
	
	// Guardar 
	private void guardarUsuarios(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nombres = request.getParameter("nombres");
		String apellidos = request.getParameter("apellidos");
		String correo = request.getParameter("correo");
		String contra = request.getParameter("contra");
		String img = request.getParameter("img");		
		
		Usuario u = new Usuario();
		u.setNombre(nombres);
		u.setApellido(apellidos);
		u.setCorreo(correo);
		u.setContraseña(contra);
		u.setImgUrl(img);
		
		UsuarioModelo model = new UsuarioModelo();
		model.createUsuario(u);
		mostrarUsuariosGuardar(request, response);
	}
		
	private void mostrarUsuariosGuardar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UsuarioModelo model = new UsuarioModelo();
		List<Usuario> usuarios =model.listUsuario();		
		request.setAttribute("listUsuario", usuarios);
		request.getRequestDispatcher("guardarUsuarios.jsp").forward(request, response);
	}
	
	// Modificar 
	private void modificarUsuarios(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		String nombres = request.getParameter("nombres");
		String apellidos = request.getParameter("apellidos");
		String correo = request.getParameter("correo");
		String contra = request.getParameter("contra");
		String img = request.getParameter("img");		
		
		Usuario u = new Usuario();
		u.setIdUsuario(id);
		u.setNombre(nombres);
		u.setApellido(apellidos);
		u.setCorreo(correo);
		u.setContraseña(contra);
		u.setImgUrl(img);
		
		UsuarioModelo model = new UsuarioModelo();
		model.updateUsuario(u);
		mostrarUsuariosModificar(request, response);
	}
	
	private void mostrarUsuariosModificar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UsuarioModelo model = new UsuarioModelo();
		List<Usuario> usuarios =model.listUsuario();
		
		request.setAttribute("listUsuario", usuarios);
		request.getRequestDispatcher("modificarUsuarios.jsp").forward(request, response);
	}

	// Eliminar 
	private void eliminarUsuarios(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		
		UsuarioModelo model = new UsuarioModelo();
		model.deleteUsuario(id);
		
		mostrarUsuariosEliminar(request, response);
	}
	
	private void mostrarUsuariosEliminar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UsuarioModelo model = new UsuarioModelo();
		List<Usuario> usuarios =model.listUsuario();
		request.setAttribute("listUsuario", usuarios);
		request.getRequestDispatcher("eliminarUsuarios.jsp").forward(request, response);
	}
	

}
