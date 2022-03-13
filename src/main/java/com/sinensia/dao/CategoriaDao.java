package com.sinensia.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContextEvent;

import com.sinensia.contracts.IDao;
import com.sinensia.model.Categoria;

public class CategoriaDao extends BaseDao implements IDao<Categoria>{
	private Connection connect;
	
	@Override
	public int add(Categoria modelo) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int modify(Categoria modelo) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Categoria> get() throws SQLException {
		PreparedStatement preparedStatement = null;
		List<Categoria> categorias = new ArrayList<Categoria>();
		ResultSet rs = null;
		
		try {
			connect = super.getconnection();
			preparedStatement = connect.prepareStatement("SELECT * FROM categoria");
			
			rs = preparedStatement.executeQuery();
			
			while(rs.next()) {
				Categoria categoria = new Categoria(rs.getInt("categoriaId"), rs.getString("nombre"), rs.getBoolean("esIngreso"));
				categorias.add(categoria);
			}
		} catch(SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if(preparedStatement != null) {
				preparedStatement.close();
			}
			if(rs != null) {
				rs.close();
			}
			if(connect != null) {
				connect.close();
			}
		}
		
		return categorias;
	}

	@Override
	public Categoria getById(int id) throws SQLException {
		PreparedStatement preparedStatement = null;
		ResultSet rs = null;
		Categoria categoria = null;
		
		try {
			connect = super.getconnection();
			preparedStatement = connect.prepareStatement(
					"SELECT * FROM categoria WHERE categoriaId = ?");
			preparedStatement.setInt(1, id);
			
			rs = preparedStatement.executeQuery();
			rs.next();
			
			categoria = new Categoria(rs.getInt("categoriaId"), rs.getString("nombre"), rs.getBoolean("esIngreso"));
		} catch(SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if(preparedStatement != null) {
				preparedStatement.close();
			}
			if(rs != null) {
				rs.close();
			}
			if(connect != null) {
				connect.close();
			}
		}
		
		return categoria;
	}

	@Override
	public int remove(int id) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}


}