package interfaces;
import java.util.List;

import entidades.Usuario;
public interface UsuarioInterface {
	public int createUsuario(Usuario usuario);
	public List<Usuario> listUsuario();
	public List<Usuario> filterUsuarios(int id);
	public int deleteUsuario(int id);
	public int updateUsuario(Usuario usuario);
}
