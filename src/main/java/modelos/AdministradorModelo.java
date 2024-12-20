package modelos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import entidades.Administrador;
import interfaces.AdministradorInterface;
import util.MySqlConexion;

public class AdministradorModelo implements AdministradorInterface {

    @Override
    public Administrador authenticate(String correo, String contrasena) {
        Administrador admin = null;
        Connection cn = null;
        PreparedStatement psm = null;
        ResultSet rs = null;

        try {
            cn = MySqlConexion.getConexion();
            String sql = "SELECT a.*, r.nombre AS rolNombre " +
                         "FROM administrador a " +
                         "JOIN rol r ON a.idRol = r.idRol " +
                         "WHERE a.correo = ? AND a.contrasena = ?";
            psm = cn.prepareStatement(sql);
            psm.setString(1, correo);
            psm.setString(2, contrasena);
            rs = psm.executeQuery();

            if (rs.next()) {
                admin = new Administrador();
                admin.setIdUsuario(rs.getInt("idUsuario"));
                admin.setNombre(rs.getString("nombre"));
                admin.setApellido(rs.getString("apellido"));
                admin.setCorreo(rs.getString("correo"));
                admin.setContrasena(rs.getString("contrasena"));
                admin.setUrl(rs.getString("url"));
                admin.setFechaRegistro(rs.getTimestamp("fechaRegistro"));
                admin.setIdRol(rs.getInt("idRol"));
                admin.setRolNombre(rs.getString("rolNombre"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (psm != null) psm.close();
                if (cn != null) cn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return admin;
    }
	
	
	
    @Override
    public List<Administrador> listAdministrators() {
        List<Administrador> admins = new ArrayList<>();
        Connection cn = null;
        PreparedStatement psm = null;
        ResultSet rs = null;

        try {
            cn = MySqlConexion.getConexion();
            String sql = "CALL sp_listAdministrators()";
            psm = cn.prepareStatement(sql);
            rs = psm.executeQuery();

            while (rs.next()) {
                Administrador admin = new Administrador();
                admin.setIdUsuario(rs.getInt("idUsuario"));
                admin.setNombre(rs.getString("nombre"));
                admin.setApellido(rs.getString("apellido"));
                admin.setCorreo(rs.getString("correo"));
                admin.setUrl(rs.getString("url"));
                admin.setFechaRegistro(rs.getTimestamp("fechaRegistro"));
                admin.setRolNombre(rs.getString("rolNombre"));
                admins.add(admin);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (psm != null) psm.close();
                if (cn != null) cn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return admins;
    }
    

    @Override
    public Administrador registerAdministrator(Administrador admin) {
        Connection cn = null;
        PreparedStatement psm = null;

        try {
            cn = MySqlConexion.getConexion();
            String sql = "CALL sp_registerAdministrator(?, ?, ?, ?, ?, ?)";
            psm = cn.prepareStatement(sql);
            psm.setString(1, admin.getNombre());
            psm.setString(2, admin.getApellido());
            psm.setString(3, admin.getCorreo());
            psm.setString(4, admin.getContrasena());
            psm.setString(5, admin.getUrl());
            psm.setInt(6, admin.getIdRol());

            int result = psm.executeUpdate();
            if (result > 0) return admin;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (psm != null) psm.close();
                if (cn != null) cn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    @Override
    public Administrador updateAdministrator(Administrador admin) {
        Connection cn = null;
        PreparedStatement psm = null;

        try {
            cn = MySqlConexion.getConexion();
            String sql = "CALL sp_updateAdministrator(?, ?, ?, ?, ?, ?, ?)";
            psm = cn.prepareStatement(sql);
            psm.setInt(1, admin.getIdUsuario());
            psm.setString(2, admin.getNombre());
            psm.setString(3, admin.getApellido());
            psm.setString(4, admin.getCorreo());
            psm.setString(5, admin.getContrasena());
            psm.setString(6, admin.getUrl());
            psm.setInt(7, admin.getIdRol());

            int result = psm.executeUpdate();
            if (result > 0) return admin;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (psm != null) psm.close();
                if (cn != null) cn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    @Override
    public Administrador deleteAdministrator(int idUsuario) {
        Connection cn = null;
        PreparedStatement psm = null;

        try {
            cn = MySqlConexion.getConexion();
            String sql = "CALL sp_deleteAdministrator(?)";
            psm = cn.prepareStatement(sql);
            psm.setInt(1, idUsuario);

            int result = psm.executeUpdate();
            if (result > 0) return new Administrador();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (psm != null) psm.close();
                if (cn != null) cn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    @Override
    public Administrador getAdministratorById(int idUsuario) {
        Administrador admin = null;
        Connection cn = null;
        PreparedStatement psm = null;
        ResultSet rs = null;

        try {
            cn = MySqlConexion.getConexion();
            String sql = "CALL sp_getAdministratorById(?)";
            psm = cn.prepareStatement(sql);
            psm.setInt(1, idUsuario);
            rs = psm.executeQuery();

            if (rs.next()) {
                admin = new Administrador();
                admin.setIdUsuario(rs.getInt("idUsuario"));
                admin.setNombre(rs.getString("nombre"));
                admin.setApellido(rs.getString("apellido"));
                admin.setCorreo(rs.getString("correo"));
                admin.setUrl(rs.getString("url"));
                admin.setFechaRegistro(rs.getTimestamp("fechaRegistro"));
                admin.setIdRol(rs.getInt("idRol"));
                admin.setRolNombre(rs.getString("rolNombre"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (psm != null) psm.close();
                if (cn != null) cn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return admin;
    }
}
