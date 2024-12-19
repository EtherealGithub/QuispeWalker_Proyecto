package interfaces;

import java.util.List;
import entidades.Rol;

public interface RolInterface {
    List<Rol> listRoles();
    Rol getRoleById(int id);
}
