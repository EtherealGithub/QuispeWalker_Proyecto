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

@WebServlet("/AdministradorServlet")
public class AdministradorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.isEmpty()) {
            mostrarAdministradores(request, response); // Acción por defecto
        } else {
            switch (action) {
                case "mostrar":
                case "listar":
                    mostrarAdministradores(request, response);
                    break;
                case "filterByName":
                    filtrarPorNombre(request, response);
                    break;
                case "eliminar":
                    eliminarAdministrador(request, response);
                    break;
                case "guardar":
                    mostrarFormularioGuardar(request, response);
                    break;
                case "modificar":
                    mostrarFormularioModificar(request, response);
                    break;
                default:
                    mostrarAdministradores(request, response);
                    break;
            }
        }
    }

    private void mostrarAdministradores(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AdministradorModelo model = new AdministradorModeloImpl();
        List<Administrador> administradores = model.listAdministradores();
        request.setAttribute("listAdministradores", administradores);
        request.getRequestDispatcher("/admin/administradores/mostrarAdministradores.jsp").forward(request, response);
    }

    private void filtrarPorNombre(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombres = request.getParameter("nombres");
        AdministradorModelo model = new AdministradorModeloImpl();
        List<Administrador> administradores = model.searchAdministradores(nombres);
        request.setAttribute("listAdministradores", administradores);
        request.getRequestDispatcher("/admin/administradores/mostrarAdministradores.jsp").forward(request, response);
    }

    private void eliminarAdministrador(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dni = request.getParameter("dni");
        AdministradorModelo model = new AdministradorModeloImpl();

        if (dni != null && !dni.isEmpty()) {
            model.deleteAdministrador(dni);
        }

        // Cargar la lista de administradores actualizada
        List<Administrador> administradores = model.listAdministradores();
        request.setAttribute("listAdministradores", administradores);
        request.getRequestDispatcher("/admin/administradores/EliminarAdministrador.jsp").forward(request, response);
    }

   
    protected void mostrarFormularioGuardar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AdministradorModelo model = new AdministradorModeloImpl();
        List<Administrador> administradores = model.listAdministradores();
        request.setAttribute("listAdministradores", administradores);
        request.getRequestDispatcher("/admin/administradores/GuardarAdministrador.jsp").forward(request, response);
    }

    private void mostrarFormularioModificar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dni = request.getParameter("dni");
        if (dni != null && !dni.isEmpty()) {
            AdministradorModelo model = new AdministradorModeloImpl();
            Administrador admin = model.getAdministradorByDni(dni);
            request.setAttribute("adminSeleccionado", admin);
            List<Administrador> administradores = model.listAdministradores();
            request.setAttribute("listAdministradores", administradores);
            request.getRequestDispatcher("/admin/administradores/ModificarAdministrador.jsp").forward(request, response);
        } else {
            response.sendRedirect("/admin/administradores/ModificarAdministrador.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("guardar".equals(action)) {
            guardarAdministrador(request, response);
        } else if ("modificar".equals(action)) {
            modificarAdministrador(request, response);
        } else {
            mostrarAdministradores(request, response);
        }
    }

    private void guardarAdministrador(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String dni = request.getParameter("dni");
            String nombres = request.getParameter("nombres");
            String apellidos = request.getParameter("apellidos");
            String correo = request.getParameter("correo");

            if (dni == null || nombres == null || apellidos == null || correo == null ||
                nombres.isEmpty() || apellidos.isEmpty() || correo.isEmpty()) {
                request.setAttribute("error", "Todos los campos son obligatorios.");
                request.getRequestDispatcher("/admin/administradores/GuardarAdministrador.jsp").forward(request, response);
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
                request.setAttribute("error", "El administrador con el DNI proporcionado ya existe.");
                request.getRequestDispatcher("/admin/administradores/GuardarAdministrador.jsp").forward(request, response);
            } else {
                model.createAdministrador(admin);
                List<Administrador> administradores = model.listAdministradores();
                request.setAttribute("listAdministradores", administradores);
                request.getRequestDispatcher("/admin/administradores/GuardarAdministrador.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Ocurrió un error al guardar el administrador.");
            request.getRequestDispatcher("/admin/administradores/GuardarAdministrador.jsp").forward(request, response);
        }
    }


    private void modificarAdministrador(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
            
            List<Administrador> administradores = model.listAdministradores();
            request.setAttribute("listAdministradores", administradores);
            request.setAttribute("adminSeleccionado", admin);
            
            request.getRequestDispatcher("/admin/administradores/ModificarAdministrador.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Ocurrió un error al modificar el administrador.");
            request.getRequestDispatcher("/admin/administradores/ModificarAdministrador.jsp").forward(request, response);
        }
    }
}
