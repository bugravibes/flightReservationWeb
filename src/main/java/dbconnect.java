import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class dbconnect {

	public static void main(String[] args) {
		try {
			@SuppressWarnings("unused")
			Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/reservationsystem", "root",
					"mypass123");
			System.out.println("Connected With the database successfully");
		} catch (SQLException e) {
			System.out.println("Error while connecting to the database");
		}
	}

}