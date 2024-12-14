package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MySqlConexion {
	public static Connection getConexion() {
	Connection con = null;
	 try {
		Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
		String url = "jdbc:mysql://mysql-489a09e-fabrizio-83b5.g.aivencloud.com:20113/dbproyectojq?useSSL=false&useTimezone=true&serverTimezone=UTC&allowPublicKeyRetrieval=true";
		String usr = "avnadmin";
		String encodedKey = "QVZOU19MZmlfZnRKYWFVLTJMS1ZUTlYz";
		String psw = new String(java.util.Base64.getDecoder().decode(encodedKey));
		con = DriverManager.getConnection(url,usr,psw);
	} catch (ClassNotFoundException e) {
		// TODO: handle exception
		System.out.println("Error >> Driver no Instalado!!"+e.getMessage());
	}catch (SQLException e) {
		// TODO: handle exception
		System.out.println("Error >> de conexión con la BD"+e.getMessage());
	}catch (Exception e) {
		// TODO: handle exception
		System.out.println("Error >> general: "+ e.getMessage());
	}
	 return con;
	}
}
