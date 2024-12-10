package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelos.AdministradorModelo;
import modelos.AdministradorModeloImpl;
import entidades.Administrador;
@WebServlet("/ModificarAdministradorServlet")
public class ModificarAdministradorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dni = request.getParameter("dni");
        if (dni != null && !dni.isEmpty()) {
            AdministradorModelo model = new AdministradorModeloImpl();
            Administrador admin = model.getAdministradorByDni(dni);
            request.setAttribute("adminSeleccionado", admin);
            List<Administrador> administradores = model.listAdministradores();
            request.setAttribute("listAdministradores", administradores);
            request.getRequestDispatcher("ModificarAdministrador.jsp").forward(request, response);
        } else {
            response.sendRedirect("MostrarAdministradoresServlet");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String dni = request.getParameter("dni");
            String nombres = request.getParameter("nombres");
            String apellidos = request.getParameter("apellidos");
            String correo = request.getParameter("correo");

            Administrador admin = new Administrador();
            admin.setDni(dni);
            admin.setNombre(nombres);
            admin.setApellido(apellidos);
            admin.setCorreo(correo);

            AdministradorModelo model = new AdministradorModeloImpl();
            model.updateAdministrador(admin);
            
            // Cargar la lista de administradores actualizada
            List<Administrador> administradores = model.listAdministradores();
            request.setAttribute("listAdministradores", administradores);
            request.setAttribute("adminSeleccionado", admin);  // Reestablecer el administrador seleccionado
            
            request.getRequestDispatcher("ModificarAdministrador.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Ocurrió un error al modificar el administrador.");
            request.getRequestDispatcher("ModificarAdministrador.jsp").forward(request, response);
        }
    }
}
