package com.sinensia.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.sinensia.contracts.IDao;
import com.sinensia.model.Categoria;

public class CategoriaDao extends BaseDao implements IDao<Categoria>{
	private Connection connect;
	
	@Override
	public int add(Categoria categoria) throws SQLException {
		int idCategoria = 0;
		PreparedStatement preparedStatement = null;
		ResultSet rsKey = null;
		
		try {
			connect = super.getconnection();
			preparedStatement = connect.prepareStatement(
					"INSERT INTO categoria(categoriaId, nombre, esIngreso) VALUE (?,?,?)", Statement.RETURN_GENERATED_KEYS);
			preparedStatement.setInt(1, categoria.getCategoriaId());
			preparedStatement.setString(2, categoria.getNombre());
			preparedStatement.setBoolean(3, categoria.isEsIngreso());
			
			preparedStatement.executeUpdate();
			rsKey = preparedStatement.getGeneratedKeys();
			rsKey.next();
			idCategoria = rsKey.getInt(1);
		} catch(SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if(preparedStatement != null) {
				preparedStatement.close();
			}
			if(rsKey != null) {
				rsKey.close();
			}
			if(connect != null) {
				connect.close();
			}
		}
		
		return idCategoria;
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
		int filasAfectadas = 0;
		PreparedStatement preparedStatement = null;
		
		try {
			connect = super.getconnection();
			preparedStatement = connect.prepareStatement("DELETE FROM categoria WHERE categoriaId = ?;");
			preparedStatement.setInt(1, id);

			filasAfectadas = preparedStatement.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if (preparedStatement != null) {
				preparedStatement.close();
			}
			if (connect != null) {
				connect.close();
			}
		}
		return filasAfectadas;
	}

}