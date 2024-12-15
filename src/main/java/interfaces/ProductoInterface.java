package interfaces;

import java.util.List;

import entidades.Productos.Categoria;
import entidades.Productos.Producto;

public interface ProductoInterface {
    boolean agregarProducto(Producto producto);
    boolean actualizarProducto(Producto producto);
    boolean eliminarProducto(int id);
    List<Producto> obtenerProductos();
    Producto obtenerProductoPorId(int id);
    
    boolean agregarCategoria(Categoria categoria);
    List<Categoria> obtenerCategorias();
}
