package modelos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import entidades.Usuario;
import interfaces.UsuarioInterface;
import util.MySqlConexion;

public class UsuarioModelo implements UsuarioInterface {

    @Override
    public int createUsuario(Usuario usuario) {
        int value = 0;
        Connection cn = null;
        PreparedStatement psm = null;

        try {
            cn = MySqlConexion.getConexion();
            String sql = "INSERT INTO usuarios (nombre, apellido, correo, contraseña, imagen_url) VALUES (?,?,?,?,?)";
            psm = cn.prepareStatement(sql);
            psm.setString(1, usuario.getNombre());
            psm.setString(2, usuario.getApellido());
            psm.setString(3, usuario.getCorreo());
            psm.setString(4, usuario.getContraseña());
            psm.setString(5, usuario.getImgUrl());

            value = psm.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(cn, psm);
        }

        return value;
    }

    @Override
    public List<Usuario> listUsuario() {
        List<Usuario> listUsuario = new ArrayList<>();
        Connection cn = null;
        PreparedStatement psm = null;
        ResultSet rs = null;

        try {
            cn = MySqlConexion.getConexion();
            String sql = "SELECT * FROM usuarios";
            psm = cn.prepareStatement(sql);
            rs = psm.executeQuery();

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setIdUsuario(rs.getInt("id_usuario"));
                u.setNombre(rs.getString("nombre"));
                u.setApellido(rs.getString("apellido"));
                u.setCorreo(rs.getString("correo"));
                u.setContraseña(rs.getString("contraseña"));
                u.setImgUrl(rs.getString("imagen_url"));
                
                Timestamp timestamp = rs.getTimestamp("fecha_creacion");
                if (timestamp != null) {
                    u.setFechaCreacion(timestamp.toLocalDateTime());
                }

                listUsuario.add(u);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(cn, psm, rs);
        }

        return listUsuario;
    }

    @Override
    public int deleteUsuario(int id) {
        int value = 0;
        Connection cn = null;
        PreparedStatement psm = null;

        try {
            cn = MySqlConexion.getConexion();
            String sql = "DELETE FROM usuarios WHERE id_usuario=?";
            psm = cn.prepareStatement(sql);
            psm.setInt(1, id);

            value = psm.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(cn, psm);
        }

        return value;
    }

    @Override
    public int updateUsuario(Usuario usuario) {
        int value = 0;
        Connection cn = null;
        PreparedStatement psm = null;

        try {
            cn = MySqlConexion.getConexion();
            String sql = "UPDATE usuarios SET nombre = ?, apellido = ?, correo = ?, contraseña = ?, imagen_url = ?, fecha_creacion = ? WHERE id_usuario = ?";
            psm = cn.prepareStatement(sql);

            psm.setString(1, usuario.getNombre());
            psm.setString(2, usuario.getApellido());
            psm.setString(3, usuario.getCorreo());
            psm.setString(4, usuario.getContraseña());
            psm.setString(5, usuario.getImgUrl());
            psm.setTimestamp(6, Timestamp.valueOf(usuario.getFechaCreacion()));  
            psm.setInt(7, usuario.getIdUsuario());

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
            if (rs != null)
                rs.close();
            if (psm != null)
                psm.close();
            if (cn != null)
                cn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void closeResources(Connection cn, PreparedStatement psm) {
        closeResources(cn, psm, null);
    }
}
