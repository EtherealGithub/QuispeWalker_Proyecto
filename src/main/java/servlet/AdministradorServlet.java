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

    public AdministradorServlet() {
        super();
    }

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
                default:
                    mostrarAdministradores(request, response); // Manejar acción por defecto
                    break;
            }
        }
    }

    private void mostrarAdministradores(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AdministradorModelo model = new AdministradorModeloImpl();
        List<Administrador> administradores = model.listAdministradores();
        request.setAttribute("listAdministradores", administradores);
        request.getRequestDispatcher("mostrarAdministradores.jsp").forward(request, response);
    }

    private void filtrarPorNombre(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombres = request.getParameter("nombres");
        AdministradorModelo model = new AdministradorModeloImpl();
        List<Administrador> administradores = model.searchAdministradores( nombres);
        request.setAttribute("listAdministradores", administradores);
        request.getRequestDispatcher("mostrarAdministradores.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // No se espera que este servlet maneje solicitudes POST en esta configuración simplificada
        mostrarAdministradores(request, response);
    }
}
