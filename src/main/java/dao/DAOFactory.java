package dao;

import interfaces.AdministradorInterface;
import interfaces.RolInterface;
import interfaces.CategoriaInterface;  

public abstract class DAOFactory {
    public static final int MYSQL = 1;
    public static final int SQLSERVER = 2;
    public static final int ORACLE = 3;
    
    public abstract AdministradorInterface getAdministrador();
    public abstract RolInterface getRol();
    public abstract CategoriaInterface getCategoria();  
    
    public static DAOFactory getDaoFactory(int tipo) {
        switch (tipo) {
        case MYSQL:
            return new MySqlDAOFactory();
        case SQLSERVER:
            return null;
        case ORACLE:
            return null;
        default:
            return null;
        }
    }
}
