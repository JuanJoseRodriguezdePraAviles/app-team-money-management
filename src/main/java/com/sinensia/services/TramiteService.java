package com.sinensia.services;

import java.sql.SQLException;
import java.util.List;

import com.sinensia.contracts.IDao;
import com.sinensia.dao.TramiteDao;
import com.sinensia.model.Tramite;

public class TramiteService implements IDao<Tramite> {
	IDao<Tramite>tramiteDao = new TramiteDao();

	@Override
	public int add(Tramite tramite) throws SQLException {
		 return tramiteDao.add(tramite);
	}

	@Override
	public int modify(Tramite modelo) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Tramite> get() throws SQLException {
		return tramiteDao.get();
	}

	@Override
	public Tramite getById(int id) throws SQLException {
		return tramiteDao.getById(id);
	}

	@Override
	public int remove(int id) throws SQLException {
		return tramiteDao.remove(id);
	}

}