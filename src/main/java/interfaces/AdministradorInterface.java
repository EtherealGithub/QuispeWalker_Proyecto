package interfaces;

import java.util.List;
import entidades.Administrador;

public interface AdministradorInterface {
    List<Administrador> listAdministrators();
    Administrador registerAdministrator(Administrador admin);
    Administrador updateAdministrator(Administrador admin);
    Administrador deleteAdministrator(int idUsuario);
    Administrador getAdministratorById(int idUsuario);
    Administrador authenticate(String correo, String contrasena);
}
