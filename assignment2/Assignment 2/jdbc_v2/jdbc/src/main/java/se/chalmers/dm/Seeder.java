package se.chalmers.dm;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Random;
import com.github.javafaker.Faker;

public class Seeder {
	Faker faker = null;
	Random random = null;
	Connection connection = null;
	
	public Seeder(Faker faker, Connection connection2,Random random ) {
		this.connection =  connection2;
		this.faker = faker;
		this.random = random;
	}
	 
	public void createUserTable() {
		try {
			Statement stmt = connection.createStatement();
			stmt.executeUpdate(QueryHelper.sqlQuery("create_user_table.sql"));
			stmt.close();
		}
		catch ( Exception e ) {
			System.err.println("Error " +e.getMessage());
			System.exit(0);
		}
	}
	
	public void insertFakeUsers(int count) {
		try {
			
			for(int i = 0; i < count; i++ ) {
				String ssn =  faker.idNumber().ssnValid();
				String name =  faker.name().fullName() ;
				String email = faker.internet().emailAddress();
				boolean isActive = faker.random().nextBoolean();
				try {
					connection.setAutoCommit(false);
					PreparedStatement stmt2 = connection.prepareStatement(QueryHelper.sqlQuery("insert_user.sql"));
					stmt2.setString(1,ssn);
					stmt2.setString(2,name);
					stmt2.setString(3,email);
					stmt2.setBoolean(4,isActive);
					stmt2.executeUpdate();
					connection.commit();
					stmt2.close();
				}catch(Exception e) {
					connection.rollback();
				}
			}
			
		}catch ( Exception e ) {
			System.err.println("Error " +e.getMessage());
			System.exit(0);
		}
	}
	
	public void createWebPageTable() {
		try {
			Statement stmt = connection.createStatement();
			stmt.executeUpdate(QueryHelper.sqlQuery("create_webpage_table.sql"));
			stmt.close();
		}
		catch ( Exception e ) {
			System.err.println("Error " +e.getMessage());
			System.exit(0);
		}
	}
	
	public void insertFakeUsersWithWebPage(int x) {
		try {
			for(int i = 0; i < x; i++) {
				String ssn = faker.idNumber().ssnValid();
				String name = faker.name().fullName();
				String email = faker.internet().emailAddress();
				boolean isActive = faker.random().nextBoolean();
				try {
					connection.setAutoCommit(false);
					PreparedStatement stmt2 = connection.prepareStatement(QueryHelper.sqlQuery("insert_user.sql"));
					stmt2.setString(1,ssn);
					stmt2.setString(2,name);
					stmt2.setString(3,email);
					stmt2.setBoolean(4,isActive);
					stmt2.executeUpdate();
					connection.commit();
					stmt2.close();
				}catch(Exception e) {
					connection.rollback();
				}
				String url = faker.internet().url();
				String author = ssn;
				String content = faker.chuckNorris().fact();
				int pop = random.nextInt(100);
				try {
					connection.setAutoCommit(false);
					PreparedStatement stmt2 = connection.prepareStatement(QueryHelper.sqlQuery("insert_webpage.sql"));
					stmt2.setString(1,url);
					stmt2.setString(2,author);
					stmt2.setString(3,content);
					stmt2.setInt(4,pop);
					stmt2.executeUpdate();
					connection.commit();
					stmt2.close();
				}catch(Exception e) {
					connection.rollback();
				}
			}
		}
		catch ( Exception e ) {
			System.err.println("Error " +e.getMessage());
			System.exit(0);
		}
	}
}


