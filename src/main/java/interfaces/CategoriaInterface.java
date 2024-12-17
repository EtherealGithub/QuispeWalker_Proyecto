package interfaces;
import java.util.List;

import entidades.Categoria;

public interface CategoriaInterface {
	public int createCategoria(Categoria categoria);
	public List<Categoria> listCategoria();
	public int deleteCategoria(int id);
	public int updateCategoria(Categoria categoria);
}
