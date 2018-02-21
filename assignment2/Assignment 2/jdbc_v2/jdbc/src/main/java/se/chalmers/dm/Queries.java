package se.chalmers.dm;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class Queries {
	 public List<User> findActiveUsers(Connection connection) {
			List list = new ArrayList();
			Statement stmt = null;
		 try {
			stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery(QueryHelper.sqlQuery("find_active_users.sql"));
			while(rs.next()) {
				String ssn = rs.getString("ssn");
				String name = rs.getString("name");
				String email = rs.getString("email");
				Boolean isActive = rs.getBoolean("isActive");
				User user = new User(ssn,name,email,isActive);
				list.add(user);
			}
			rs.close();
	    	stmt.close();

		} catch (SQLException e) {
			System.err.println("Error "+e.getMessage());
			System.exit(0);
		}
		 
		 return list;
	 }
	 public List<String> findSpecialQuotes(Connection connection) {
			List list = new ArrayList();
			Statement stmt = null;
		 try {
				stmt = connection.createStatement();
				ResultSet rs = stmt.executeQuery(QueryHelper.sqlQuery("find_special_quotes.sql"));
				while(rs.next()) {
					String Quates = rs.getString("content");
					list.add(Quates);
				}
				rs.close();
		    	stmt.close();

			} catch (SQLException e) {
				System.err.println("Error "+e.getMessage());
				System.exit(0);
			}
			 
			 return list;
	 }
}
