package dao;

import interfaces.AdministradorInterface;
import interfaces.RolInterface;
import interfaces.CategoriaInterface;  
import modelos.AdministradorModelo;
import modelos.RolModelo;
import modelos.CategoriaModelo;  

public class MySqlDAOFactory extends DAOFactory {

    @Override
    public AdministradorInterface getAdministrador() {
        return new AdministradorModelo();
    }

    @Override
    public RolInterface getRol() {
        return new RolModelo();
    }
    
    @Override
    public CategoriaInterface getCategoria() {  
        return new CategoriaModelo();  
    }
}
