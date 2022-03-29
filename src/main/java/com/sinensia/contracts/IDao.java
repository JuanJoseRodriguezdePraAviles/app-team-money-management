package com.sinensia.contracts;

import java.sql.SQLException;
import java.util.List;

public interface IDao<T> {
	
	public int add(T modelo) throws SQLException;
	
	public int modify(T modelo) throws SQLException;
	
	public List<T> get() throws SQLException;
	
	public T getById(int id) throws SQLException;
	
	public int remove(int id) throws SQLException;

	public int agregar(T modelo) throws SQLException;

	public int add(T modelo, boolean configuracion) throws SQLException;

	public List<T> get(boolean configuracion) throws SQLException;

	public List<T> obtener() throws SQLException;
}
