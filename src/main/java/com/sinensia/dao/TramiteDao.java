package com.sinensia.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import com.mysql.jdbc.Statement;
import com.sinensia.contracts.IDao;
import com.sinensia.model.Tramite;

public class TramiteDao extends BaseDao implements IDao<Tramite> {
	
	private Connection connect;

	@Override
	public int add(Tramite tramite) throws SQLException {
		
		int idTramite= 0;
		PreparedStatement preparedStatement= null;
		ResultSet rs= null;
		
		try {
			connect=super.getconnection();
			preparedStatement= connect.prepareStatement(
					"INSERT INTO tramite(tramiteId, valor, fecha, categoriaId, concepto)"
					+ "VALUE (?,?,?,?,?) ",Statement.RETURN_GENERATED_KEYS);
			
					preparedStatement.setInt(1, tramite.getTramiteId());
					preparedStatement.setDouble(2, tramite.getValor());
					preparedStatement.setInt(3, tramite.getCategoriaId());
					preparedStatement.setString(4, tramite.getConcepto());
					preparedStatement.setDate(5, Date.valueOf(tramite.getFecha()));
					//preparedStatement.setLocalDate()
					
			preparedStatement.executeUpdate();
			rs = preparedStatement.getGeneratedKeys();
			
			rs.next();
			idTramite = rs.getInt(idTramite);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			if (preparedStatement !=null)
				preparedStatement.close();
			if (rs != null)
				rs.close();
			if (connect != null)
				connect.close();
			
		}
	
		return idTramite;
	}

	@Override
	public List<Tramite> get() throws SQLException {
		
		List<Tramite> tramites = new ArrayList<Tramite>();
		PreparedStatement preparedStatement=null;
		try {
			connect=super.getconnection();
			preparedStatement=connect.prepareStatement("SELECT * From ");
			
			ResultSet rs=preparedStatement.executeQuery();
			
			while (rs.next()) {
				Tramite tramite= new Tramite();
				tramite.setTramiteId(rs.getInt("tramiteId"));
				tramite.setValor(rs.getDouble("valor"));
				tramite.setCategoriaId(rs.getInt("categoriaId"));
				tramite.setConcepto(rs.getString("concepto"));
				tramite.setFecha(rs.getDate("fecha").toLocalDate());
				
			} 
			
			} catch (Exception e) {
				e.printStackTrace();
				throw e;
			}
		
		return tramites;
	}

	@Override
	public Tramite getById(int id) throws SQLException {
		PreparedStatement preparedStatement = null;
		ResultSet rs = null;
		Tramite tramite = null;
		
		try {
			connect = super.getconnection();
			preparedStatement = connect.prepareStatement ("SELECT * FROM tramite WHERE tramiteId = ?;");
			preparedStatement.setInt(1,id);
			
			rs = preparedStatement.executeQuery();
			rs.next();
			
			tramite = new Tramite(rs.getInt("tramite"),rs.getDouble("valor"),rs.getDate("fecha").toLocalDate(), 
					rs.getInt("categoriaId"),rs.getString("concepto"));
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		
		return tramite;
	}

	@Override
	public int modify(Tramite modelo) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int remove(int id) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}
	
	

}