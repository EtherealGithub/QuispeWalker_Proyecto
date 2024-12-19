package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.DAOFactory;
import entidades.Administrador;
import interfaces.AdministradorInterface;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena");

        DAOFactory daoFactory = DAOFactory.getDaoFactory(DAOFactory.MYSQL);
        AdministradorInterface adminDao = daoFactory.getAdministrador();
        
        Administrador admin = adminDao.authenticate(correo, contrasena); 
        
        if (admin != null) {
            HttpSession session = request.getSession();
            session.setAttribute("admin", admin);
            response.sendRedirect("admin/inicio.jsp");
        } else {
            response.sendRedirect("admin/login.jsp?error=true");
        }
    }
}
