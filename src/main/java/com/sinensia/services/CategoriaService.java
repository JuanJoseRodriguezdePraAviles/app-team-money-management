package com.sinensia.services;

import java.sql.SQLException;
import java.util.List;


import com.sinensia.contracts.IDao;
import com.sinensia.dao.CategoriaDao;
import com.sinensia.model.Categoria;


public class CategoriaService  implements IDao<Categoria>{

	IDao<Categoria> categoriaDao = new CategoriaDao();
	@Override
	public int add(Categoria categoria, boolean configuracion) throws SQLException {
		if(configuracion)
			return categoriaDao.add(categoria);
		else
			return categoriaDao.agregar(categoria);
	}

	@Override
	public int modify(Categoria modelo) throws SQLException {
		return 0;
	}

	@Override
	public List<Categoria> get(boolean configuracion) throws SQLException {
		if(configuracion)
			return categoriaDao.get();
		else
			return categoriaDao.obtener();
	}

	@Override
	public Categoria getById(int id) throws SQLException {
		return categoriaDao.getById(id);
	}

	@Override
	public int remove(int id) throws SQLException {
		return 0;
	}

	@Override
	public int add(Categoria modelo) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Categoria> get() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int agregar(Categoria modelo) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Categoria> obtener() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}
	
}