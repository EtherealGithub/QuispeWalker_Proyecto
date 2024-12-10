package modelos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entidades.Administrador;
import interfaces.AdministradorInterface;
import util.MySqlConexion;

public abstract class AdministradorModelo implements AdministradorInterface {

    @Override
    public int createAdministrador(Administrador administrador) {
        int value = 0;
        Connection cn = null;
        PreparedStatement psm = null;

        try {
            cn = MySqlConexion.getConexion();
            String sql = "INSERT INTO Administradores (dni, nombres, apellidos, correo) VALUES (?, ?, ?, ?)";
            psm = cn.prepareStatement(sql);
            psm.setString(1, administrador.getDni());
            psm.setString(2, administrador.getNombre());
            psm.setString(3, administrador.getApellido());
            psm.setString(4, administrador.getCorreo());

            value = psm.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(cn, psm);
        }

        return value;
    }

    @Override
    public List<Administrador> listAdministradores() {
        List<Administrador> administradores = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = MySqlConexion.getConexion();
            String query = "SELECT * FROM Administradores";
            ps = con.prepareStatement(query);
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

    @Override
    public int deleteAdministrador(String dni) {
        int value = 0;
        Connection cn = null;
        PreparedStatement psm = null;

        try {
            cn = MySqlConexion.getConexion();
            String sql = "DELETE FROM Administradores WHERE dni = ?";
            psm = cn.prepareStatement(sql);
            psm.setString(1, dni);

            value = psm.executeUpdate();
            System.out.println("Número de filas eliminadas en el modelo: " + value); // Depuración

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(cn, psm);
        }

        return value;
    }

    public Administrador buscarPorDni(String dni) throws Exception {
        Connection cn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Administrador admin = null;

        try {
            cn = MySqlConexion.getConexion();
            String sql = "SELECT * FROM Administradores WHERE dni = ?";
            stmt = cn.prepareStatement(sql);
            stmt.setString(1, dni);
            rs = stmt.executeQuery();

            if (rs.next()) {
                admin = new Administrador();
                admin.setDni(rs.getString("dni"));
                admin.setNombre(rs.getString("nombres"));
                admin.setApellido(rs.getString("apellidos"));
                admin.setCorreo(rs.getString("correo"));
            }
        } finally {
            closeResources(cn, stmt, rs);
        }
        return admin;
    }

    @Override
    public int updateAdministrador(Administrador administrador) {
        int value = 0;
        Connection cn = null;
        PreparedStatement psm = null;

        try {
            cn = MySqlConexion.getConexion();
            String sql = "UPDATE Administradores SET nombres = ?, apellidos = ?, correo = ? WHERE dni = ?";
            psm = cn.prepareStatement(sql);

            psm.setString(1, administrador.getNombre());
            psm.setString(2, administrador.getApellido());
            psm.setString(3, administrador.getCorreo());
            psm.setString(4, administrador.getDni());

            value = psm.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(cn, psm);
        }

        return value;
    }

    public static void closeResources(Connection cn, PreparedStatement psm, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (psm != null) psm.close();
            if (cn != null) cn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void closeResources(Connection cn, PreparedStatement psm) {
        try {
            if (psm != null) psm.close();
            if (cn != null) cn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Administrador getAdministradorByDni(String dni) {
        Administrador admin = null;
        String sql = "SELECT * FROM Administradores WHERE dni = ?";
        try (Connection conn = MySqlConexion.getConexion();
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

    
}