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
import entidades.Rol;
import interfaces.RolInterface;

@WebServlet("/RolServlet")
public class RolServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        JsonObject data = new Gson().fromJson(request.getReader(), JsonObject.class);
        String type = data.get("type").getAsString();

        DAOFactory daoFactory = DAOFactory.getDaoFactory(DAOFactory.MYSQL);
        RolInterface rolDao = daoFactory.getRol();

        switch (type) {
            case "list":
                listRoles(response, rolDao);
                break;
            case "get":
                getRole(data, response, rolDao);
                break;
        }
    }

    private void listRoles(HttpServletResponse response, RolInterface rolDao) throws IOException {
        List<Rol> list = rolDao.listRoles();
        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(list));
        out.flush();
    }

    private void getRole(JsonObject data, HttpServletResponse response, RolInterface rolDao) throws IOException {
        int idRol = data.get("idRol").getAsInt();
        Rol rol = rolDao.getRoleById(idRol);
        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(rol));
        out.flush();
    }
}
