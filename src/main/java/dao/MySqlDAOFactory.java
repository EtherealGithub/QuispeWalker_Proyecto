package dao;

import interfaces.CategoriaInterface;
import modelos.CategoriaModelo;

public class MySqlDAOFactory extends DAOFactory {

	@Override
	public CategoriaInterface getCategoria() {
		// TODO Auto-generated method stub
		return new CategoriaModelo();
	}
	
}
