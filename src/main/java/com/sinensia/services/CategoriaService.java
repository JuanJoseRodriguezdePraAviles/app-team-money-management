package com.sinensia.services;

import java.sql.SQLException;
import java.util.List;


import com.sinensia.contracts.IDao;
import com.sinensia.dao.CategoriaDao;
import com.sinensia.model.Categoria;


public class CategoriaService implements IDao<Categoria>{

	private CategoriaDao categoriaDao;
	@Override
	public int add(Categoria categoria) throws SQLException {
		return categoriaDao.add(categoria);
	}

	@Override
	public int modify(Categoria modelo) throws SQLException {
		return 0;
	}

	@Override
	public List<Categoria> get() throws SQLException {
		IDao<Categoria> categoriaDao = new CategoriaDao();
		return categoriaDao.get();
	}

	@Override
	public Categoria getById(int id) throws SQLException {
		return categoriaDao.getById(id);
	}

	@Override
	public int remove(int id) throws SQLException {
		return 0;
	}
	
}