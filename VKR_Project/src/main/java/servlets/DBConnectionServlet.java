package servlets;

import java.sql.*;

public class DBConnectionServlet {

	public static Connection DBConnection() throws SQLException, ClassNotFoundException {
		Class.forName("org.postgresql.Driver");
		String url = "jdbc:postgresql://localhost:5432/projectdb";
		String user = "postgres";
		String password = "postgresql";
		Connection connection = DriverManager.getConnection(url, user, password);
		/*
		* try { connection = DriverManager.getConnection(url, user, password); } catch
		* (SQLException e) { System.out.println("Ошибка подключения");
		* e.printStackTrace(); }
		*/
		return connection;
	}

	public static Statement getStatement(Connection con) throws SQLException {
		return con.createStatement();
	}

}
