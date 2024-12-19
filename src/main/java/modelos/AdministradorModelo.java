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
                admin.setRolNombre(rs.getString("rolNombre")); // Obtener el nombre del rol
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
        int value = 0;
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

            value = psm.executeUpdate();
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

        return value > 0 ? admin : null;
    }

    @Override
    public Administrador updateAdministrator(Administrador admin) {
        int value = 0;
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

            value = psm.executeUpdate();
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

        return value > 0 ? admin : null;
    }

    @Override
    public Administrador deleteAdministrator(int idUsuario) {
        int value = 0;
        Connection cn = null;
        PreparedStatement psm = null;

        try {
            cn = MySqlConexion.getConexion();
            String sql = "CALL sp_deleteAdministrator(?)";
            psm = cn.prepareStatement(sql);
            psm.setInt(1, idUsuario);

            value = psm.executeUpdate();
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

        return value > 0 ? new Administrador() : null;
    }

    @Override
    public Administrador getAdministratorById(int idUsuario) {
        Administrador admin = null;
        Connection cn = null;
        PreparedStatement psm = null;
        ResultSet rs = null;

        try {
            cn = MySqlConexion.getConexion();
            String sql = "CALL sp_getAdministratorById(?)"; // Necesitas crear este procedimiento si no existe
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
