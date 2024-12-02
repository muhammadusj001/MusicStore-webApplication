package com.letslearn.DBcon;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.SQLException;

public class DbCon {
	private static Connection connection = null;

	public static final String DB_URL = "jdbc:mysql://localhost:3306/musicx";
	public static final String DB_USERNAME = "root";
	public static final String DB_PASSWORD = "1234";

	public static Connection getConnection() throws ClassNotFoundException, SQLException {
		if (connection == null) {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
			System.out.print("connected");
		}
		return connection;
	}
}
