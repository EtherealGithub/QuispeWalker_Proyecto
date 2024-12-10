package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelos.AdministradorModelo;
import modelos.AdministradorModeloImpl;
import entidades.Administrador;

@WebServlet("/GuardarAdministradorServlet")
public class GuardarAdministradorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("GuardarAdministrador.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String dni = request.getParameter("dni");
            String nombres = request.getParameter("nombres");
            String apellidos = request.getParameter("apellidos");
            String correo = request.getParameter("correo");

            if (dni == null || nombres == null || apellidos == null || correo == null ||
                nombres.isEmpty() || apellidos.isEmpty() || correo.isEmpty()) {
                request.setAttribute("error", "Todos los campos son obligatorios.");
                request.getRequestDispatcher("GuardarAdministrador.jsp").forward(request, response);
                return;
            }

            Administrador admin = new Administrador();
            admin.setDni(dni);
            admin.setNombre(nombres);
            admin.setApellido(apellidos);
            admin.setCorreo(correo);

            AdministradorModelo model = new AdministradorModeloImpl();
            Administrador existente = model.getAdministradorByDni(dni);

            if (existente != null) {
                // Si el administrador ya existe, mostrar un error
                request.setAttribute("error", "El administrador con el DNI proporcionado ya existe.");
                request.getRequestDispatcher("GuardarAdministrador.jsp").forward(request, response);
            } else {
                // Si no existe, crear el nuevo administrador
                model.createAdministrador(admin);
                response.sendRedirect("MostrarAdministradoresServlet");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Ocurrió un error al guardar el administrador.");
            request.getRequestDispatcher("GuardarAdministrador.jsp").forward(request, response);
        }
    }
}
