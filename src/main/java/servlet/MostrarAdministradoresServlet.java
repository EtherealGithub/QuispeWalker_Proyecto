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

@WebServlet("/MostrarAdministradoresServlet")
public class MostrarAdministradoresServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AdministradorModelo model = new AdministradorModeloImpl();
        List<Administrador> administradores = model.listAdministradores();
        request.setAttribute("listAdministradores", administradores);
        request.getRequestDispatcher("GuardarAdministrador.jsp").forward(request, response);
    }
   
}
