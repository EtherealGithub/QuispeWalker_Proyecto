package dao;

import interfaces.AdministradorInterface;
import interfaces.RolInterface;
import interfaces.CategoriaInterface;
import interfaces.ProductoInterface;
import modelos.AdministradorModelo;
import modelos.RolModelo;
import modelos.CategoriaModelo;
import modelos.ProductoModelo;  

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
    
    @Override
    public ProductoInterface getProductoAdmin() {  
        return new ProductoModelo();  
    }
}
