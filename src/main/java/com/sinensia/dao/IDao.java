package com.sinensia.dao;

import java.sql.SQLException;
import java.util.List;

public interface IDao<T> {
	
	public int add(T modelo) throws SQLException;
	
	public int modify(T modelo) throws SQLException;
	
	public List<T> get() throws SQLException;
	
	public T getById(int id) throws SQLException;
	
	public int remove(int id) throws SQLException;
}
