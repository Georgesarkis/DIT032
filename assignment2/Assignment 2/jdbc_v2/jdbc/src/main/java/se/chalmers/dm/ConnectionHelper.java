package se.chalmers.dm;

import java.sql.*;

public class ConnectionHelper {
	
 public static Connection createPostgresConnection() {
	 Connection c = null;
	 try {
	 Class.forName("org.postgresql.Driver");
	 c = DriverManager
	 .getConnection("jdbc:postgresql://localhost:5432/mydb",
	 "postgres", "");

	 }
	 catch ( Exception e ) {
		 System.err.println("Error" +e.getMessage());
		 System.exit(0);
		 }
	 return c;
 }
}
