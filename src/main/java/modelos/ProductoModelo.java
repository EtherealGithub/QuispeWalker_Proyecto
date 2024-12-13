package modelos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entidades.Producto;
import interfaces.ProductoInterface;
import util.MySqlConexion;

public class ProductoModelo implements ProductoInterface {

    private static final String INSERTAR_PRODUCTO = "INSERT INTO productos (nombre, precio, stock, imagen) VALUES (?, ?, ?, ?)";
    private static final String ACTUALIZAR_PRODUCTO = "UPDATE productos SET nombre = ?, precio = ?, stock = ?, imagen = ? WHERE id = ?";
    private static final String ELIMINAR_PRODUCTO = "DELETE FROM productos WHERE id = ?";
    private static final String OBTENER_PRODUCTOS = "SELECT * FROM productos";
    private static final String OBTENER_PRODUCTO_POR_ID = "SELECT * FROM productos WHERE id = ?";

    @Override
    public boolean agregarProducto(Producto producto) {
        try (Connection conn = MySqlConexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(INSERTAR_PRODUCTO)) {

            ps.setString(1, producto.getNombre());
            ps.setString(2, producto.getPrecio());
            ps.setString(3, producto.getStock());
            ps.setString(4, producto.getImagen());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean actualizarProducto(Producto producto) {
        try (Connection conn = MySqlConexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(ACTUALIZAR_PRODUCTO)) {

            ps.setString(1, producto.getNombre());
            ps.setString(2, producto.getPrecio());
            ps.setString(3, producto.getStock());
            ps.setString(4, producto.getImagen());
            ps.setString(5, producto.getId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean eliminarProducto(int id) {
        try (Connection conn = MySqlConexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(ELIMINAR_PRODUCTO)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<Producto> obtenerProductos() {
        List<Producto> productos = new ArrayList<>();
        try (Connection conn = MySqlConexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(OBTENER_PRODUCTOS);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                productos.add(mapearProducto(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productos;
    }

    @Override
    public Producto obtenerProductoPorId(int id) {
        Producto producto = null;
        try (Connection conn = MySqlConexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(OBTENER_PRODUCTO_POR_ID)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    producto = mapearProducto(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return producto;
    }

    // Mapear ResultSet a Producto
    private Producto mapearProducto(ResultSet rs) throws SQLException {
        return new Producto(
            rs.getString("id"),
            rs.getString("nombre"),
            rs.getString("precio"),
            rs.getString("stock"),
            rs.getString("imagen")
        );
    }
}