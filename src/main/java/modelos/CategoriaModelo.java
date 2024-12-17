package modelos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import entidades.Categoria;
import interfaces.CategoriaInterface; 
import util.MySqlConexion;

public class CategoriaModelo implements CategoriaInterface {

    @Override
    public int createCategoria(Categoria categoria) {
        int value = 0;
        Connection cn = null;
        PreparedStatement psm = null;

        try {
            cn = MySqlConexion.getConexion();
            String sql = "INSERT INTO categorias (nombre) VALUES (?)";
            psm = cn.prepareStatement(sql);
            psm.setString(1, categoria.getNombre());

            value = psm.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(cn, psm);
        }

        return value;
    }

    @Override
    public List<Categoria> listCategoria() {
        List<Categoria> listCategoria = new ArrayList<>();
        Connection cn = null;
        PreparedStatement psm = null;
        ResultSet rs = null;

        try {
            cn = MySqlConexion.getConexion();
            String sql = "SELECT * FROM categorias";
            psm = cn.prepareStatement(sql);
            rs = psm.executeQuery();

            while (rs.next()) {
                Categoria c = new Categoria(rs.getInt("id_categoria"), rs.getString("nombre"));
                listCategoria.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(cn, psm, rs);
        }

        return listCategoria;
    }

    @Override
    public int deleteCategoria(int id) {
        int value = 0;
        Connection cn = null;
        PreparedStatement psm = null;

        try {
            cn = MySqlConexion.getConexion();
            String sql = "DELETE FROM categorias WHERE id_categoria=?";
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
    public int updateCategoria(Categoria categoria) {
        int value = 0;
        Connection cn = null;
        PreparedStatement psm = null;

        try {
            cn = MySqlConexion.getConexion();
            String sql = "UPDATE categorias SET nombre = ? WHERE id_categoria = ?";
            psm = cn.prepareStatement(sql);

            psm.setString(1, categoria.getNombre());
            psm.setInt(2, categoria.getIdCategoria());

            value = psm.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(cn, psm);
        }

        return value;
    }

    
    // Método para cerrar recursos
    public static void closeResources(Connection cn, PreparedStatement psm, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (psm != null) psm.close();
            if (cn != null) cn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void closeResources(Connection cn, PreparedStatement psm) {
        closeResources(cn, psm, null);
    }
}
