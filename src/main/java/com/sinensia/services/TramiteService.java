package com.sinensia.services;

import java.sql.SQLException;
import java.util.List;

import com.sinensia.contracts.IDao;
import com.sinensia.dao.TramiteDao;
import com.sinensia.model.Tramite;

public class TramiteService implements IDao<Tramite> {
	IDao<Tramite>tramiteDao = new TramiteDao();
	
	@Override
	public int add(Tramite tramite, boolean configuracion) throws SQLException {
		if(configuracion)
			return tramiteDao.add(tramite);
		else
			return tramiteDao.agregar(tramite);
			
	}

	@Override
	public int modify(Tramite modelo) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	public List<Tramite> get(boolean configuracion) throws SQLException {
		if(configuracion)
			return tramiteDao.get();
		else
			return tramiteDao.obtener();
	}

	@Override
	public Tramite getById(int id) throws SQLException {
		return tramiteDao.getById(id);
	}

	@Override
	public int remove(int id) throws SQLException {
		return tramiteDao.remove(id);
	}

	@Override
	public int add(Tramite modelo) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Tramite> get() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int agregar(Tramite tramite) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Tramite> obtener() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

}