package modelos;

import entidades.Administrador;
import interfaces.AdministradorInterface;
import util.MySqlConexion;

import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class AdministradorModeloImpl extends AdministradorModelo implements AdministradorInterface {

    @Override
    public int createAdministrador(Administrador administrador) {
        return super.createAdministrador(administrador);  // Llamar al método de la clase abstracta
    }

    @Override
    public List<Administrador> listAdministradores() {
        return super.listAdministradores();  // Llamar al método de la clase abstracta
    }

    @Override
    public int deleteAdministrador(String dni) {
        return super.deleteAdministrador(dni);  // Llamar al método de la clase abstracta
    }

    @Override
    public int updateAdministrador(Administrador administrador) {
        return super.updateAdministrador(administrador);  // Llamar al método de la clase abstracta
    }

    @Override
    public List<Administrador> filterAdministradores(String dni) {
        List<Administrador> administradores = listAdministradores();  // Obtener la lista completa de administradores
        List<Administrador> filteredList = new ArrayList<>();

        // Filtrar los administradores que coinciden con el DNI
        for (Administrador admin : administradores) {
            if (admin.getDni().equals(dni)) {  // Compara el DNI de cada administrador
                filteredList.add(admin);
            }
        }

        return filteredList;  // Devuelve la lista de administradores que coinciden con el filtro
    }

    public Administrador getAdministradorByDni(String dni) {
        Administrador admin = null;
        String sql = "SELECT * FROM Administradores WHERE dni = ?";
        try (Connection conn = MySqlConexion.getConexion(); // Obtén la conexión correctamente
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, dni);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                admin = new Administrador();
                admin.setDni(rs.getString("dni"));
                admin.setNombre(rs.getString("nombres"));
                admin.setApellido(rs.getString("apellidos"));
                admin.setCorreo(rs.getString("correo"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return admin;
    }
    @Override
    public List<Administrador> searchAdministradores(String nombres) {
        List<Administrador> administradores = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = MySqlConexion.getConexion();
            String query = "SELECT * FROM Administradores WHERE nombres LIKE ?";
            ps = con.prepareStatement(query);
            ps.setString(1, "%" + nombres + "%");
            rs = ps.executeQuery();

            while (rs.next()) {
                Administrador admin = new Administrador();
                admin.setDni(rs.getString("dni"));
                admin.setNombre(rs.getString("nombres"));
                admin.setApellido(rs.getString("apellidos"));
                admin.setCorreo(rs.getString("correo"));
                admin.setFechaCreacion(rs.getTimestamp("fecha_creacion").toLocalDateTime());

                administradores.add(admin);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, rs);
        }

        return administradores;
    }
}