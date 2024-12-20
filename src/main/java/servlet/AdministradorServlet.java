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
import entidades.Administrador;
import interfaces.AdministradorInterface;

@WebServlet("/AdministradorServlet")
public class AdministradorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        JsonObject data = new Gson().fromJson(request.getReader(), JsonObject.class);
        String type = data.get("type").getAsString();

        DAOFactory daoFactory = DAOFactory.getDaoFactory(DAOFactory.MYSQL);
        AdministradorInterface adminDao = daoFactory.getAdministrador();

        switch (type) {
            case "list":
                listAdministrators(response, adminDao);
                break;
            case "register":
                registerAdministrator(data, response, adminDao);
                break;
            case "update":
                updateAdministrator(data, response, adminDao);
                break;
            case "delete":
                deleteAdministrator(data, response, adminDao);
                break;
            case "get":
                getAdministrator(data, response, adminDao);
                break;
        }
    }

    private void listAdministrators(HttpServletResponse response, AdministradorInterface adminDao) throws IOException {
        List<Administrador> list = adminDao.listAdministrators();
        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(list));
        out.flush();
    }

    private void registerAdministrator(JsonObject data, HttpServletResponse response, AdministradorInterface adminDao) throws IOException {
        Administrador admin = new Administrador();
        admin.setNombre(data.get("nombre").getAsString());
        admin.setApellido(data.get("apellido").getAsString());
        admin.setCorreo(data.get("correo").getAsString());
        admin.setContrasena(data.get("contrasena").getAsString());
        admin.setUrl(data.get("url").getAsString());
        admin.setIdRol(data.get("idRol").getAsInt());

        Administrador registeredAdmin = adminDao.registerAdministrator(admin);
        PrintWriter out = response.getWriter();
        if (registeredAdmin != null) {
            out.print("Registro exitoso");
        } else {
            out.print("Error en el registro");
        }
        out.flush();
    }

    private void updateAdministrator(JsonObject data, HttpServletResponse response, AdministradorInterface adminDao) throws IOException {
        Administrador admin = new Administrador();
        admin.setIdUsuario(data.get("idUsuario").getAsInt());
        admin.setNombre(data.get("nombre").getAsString());
        admin.setApellido(data.get("apellido").getAsString());
        admin.setCorreo(data.get("correo").getAsString());
        admin.setContrasena(data.get("contrasena").getAsString());
        admin.setUrl(data.get("url").getAsString());
        admin.setIdRol(data.get("idRol").getAsInt());

        Administrador updatedAdmin = adminDao.updateAdministrator(admin);
        PrintWriter out = response.getWriter();
        if (updatedAdmin != null) {
            out.print("Actualización exitosa");
        } else {
            out.print("Error en la actualización");
        }
        out.flush();
    }

    private void deleteAdministrator(JsonObject data, HttpServletResponse response, AdministradorInterface adminDao) throws IOException {
        int idUsuario = data.get("idUsuario").getAsInt();

        Administrador deletedAdmin = adminDao.deleteAdministrator(idUsuario);
        PrintWriter out = response.getWriter();
        if (deletedAdmin != null) {
            out.print("Eliminación exitosa");
        } else {
            out.print("Error en la eliminación");
        }
        out.flush();
    }

    private void getAdministrator(JsonObject data, HttpServletResponse response, AdministradorInterface adminDao) throws IOException {
        int idUsuario = data.get("idUsuario").getAsInt();
        Administrador admin = adminDao.getAdministratorById(idUsuario);
        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(admin));
        out.flush();
    }
}
