package se.chalmers.dm;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class JDBCTestDriver {
    // DB connection configuration
    private static String DRIVER_CLASS = "org.postgresql.Driver";
    private static String DB_USER = "postgres";
    private static String DB_PASSWORD = "";
    private static String DB_URL = "jdbc:postgresql://localhost:5432/mydb";
    private static int EXIT_FAILURE = 1;

    public static void main(String[] args) {
    	Connection c = null;
    	Statement stmt = null;
    	try {
	    	Class.forName(DRIVER_CLASS);
	    	c = DriverManager
	    	.getConnection(DB_URL,DB_USER, DB_PASSWORD);
	    	stmt = c.createStatement();
	    	String sql = "SELECT 7 AS test;";
	    	ResultSet rs = stmt.executeQuery(sql);
	    	while(rs.next()) {
	    		String ssn = rs.getString("test");
	    		System.out.println(ssn);
	    	}
	    	rs.close();
	    	stmt.close();
	    	c.close();
    	} 
    	catch ( Exception e ) {
	    	System.err.println("Error "+e.getMessage());
	    	System.exit(EXIT_FAILURE);
    	}
    }
}
