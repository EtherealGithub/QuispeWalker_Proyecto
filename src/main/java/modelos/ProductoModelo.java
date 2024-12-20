package modelos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entidades.Categoria;
import entidades.Producto;
import interfaces.ProductoInterface;
import util.MySqlConexion;

public class ProductoModelo implements ProductoInterface {

    private static final String INSERTAR_PRODUCTO = "INSERT INTO productos (nombre, precio, stock, imagen, id_categoria) VALUES (?, ?, ?, ?, ?)";
    private static final String ACTUALIZAR_PRODUCTO = "UPDATE productos SET nombre = ?, precio = ?, stock = ?, imagen = ?, id_categoria = ? WHERE id = ?";
    private static final String ELIMINAR_PRODUCTO = "DELETE FROM productos WHERE id = ?";
    private static final String OBTENER_PRODUCTOS = "SELECT p.id, p.nombre, p.precio, p.stock, p.imagen, c.id_categoria, c.nombre AS categoria_nombre " +
                                                    "FROM productos p INNER JOIN categorias c ON p.id_categoria = c.id_categoria";
    private static final String OBTENER_PRODUCTO_POR_ID = "SELECT p.id, p.nombre, p.precio, p.stock, p.imagen, c.id_categoria, c.nombre AS categoria_nombre " +
                                                          "FROM productos p INNER JOIN categorias c ON p.id_categoria = c.id_categoria WHERE p.id = ?";
    private static final String INSERTAR_CATEGORIA = "INSERT INTO categorias (nombre) VALUES (?)";
    private static final String OBTENER_CATEGORIAS = "SELECT id_categoria, nombre FROM categorias";

    @Override
    public boolean agregarProducto(Producto producto) {
        try (Connection conn = MySqlConexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(INSERTAR_PRODUCTO)) {

            ps.setString(1, producto.getNombre());
            ps.setDouble(2, producto.getPrecio());
            ps.setInt(3, producto.getStock());
            ps.setString(4, producto.getImagen());
            ps.setInt(5, producto.getIdCategoria());

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
            ps.setDouble(2, producto.getPrecio());
            ps.setInt(3, producto.getStock());
            ps.setString(4, producto.getImagen());

            ps.setInt(5, producto.getIdCategoria());
            ps.setInt(6, producto.getId());

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

    private Producto mapearProducto(ResultSet rs) throws SQLException {
        Producto producto = new Producto();
        producto.setId(rs.getInt("id"));
        producto.setNombre(rs.getString("nombre"));
        producto.setPrecio(rs.getDouble("precio"));
        producto.setStock(rs.getInt("stock"));
        producto.setImagen(rs.getString("imagen"));
        producto.setIdCategoria(rs.getInt("id_categoria"));
        producto.setNombreCategoria(rs.getString("categoria_nombre"));
        return producto;
    }

    @Override
    public boolean agregarCategoria(Categoria categoria) {
        try (Connection conn = MySqlConexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(INSERTAR_CATEGORIA)) {

            ps.setString(1, categoria.getNombre());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<Categoria> obtenerCategorias() {
        List<Categoria> categorias = new ArrayList<>();
        try (Connection conn = MySqlConexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(OBTENER_CATEGORIAS);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                categorias.add(new Categoria(
                    rs.getInt("id_categoria"),
                    rs.getString("nombre")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categorias;
    }
}
