package com.sinensia.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class BaseDao {
	static {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public Connection getconnection() throws SQLException {
		Connection connection = null;
		try {
			connection = DriverManager.getConnection(
					"jdbc:mysql://eu-cdbr-west-01.cleardb.com/heroku_0cfc546621a0fc3",
					"b4867549279eb6", "c2e5e0e2");
		}catch(SQLException e) {
			e.printStackTrace();
			throw e;
		}
		return connection;
	}
}
