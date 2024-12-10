package interfaces;

import java.util.List;
import entidades.Administrador;

public interface AdministradorInterface {
    public int createAdministrador(Administrador administrador);

    public List<Administrador> listAdministradores();

    public List<Administrador> filterAdministradores(String dni);

    public int deleteAdministrador(String dni);

  public int updateAdministrador(Administrador administrador);

  	List<Administrador> searchAdministradores(String nombres);
    
}