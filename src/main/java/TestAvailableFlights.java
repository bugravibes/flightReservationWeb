import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.helper.Flight;

public class TestAvailableFlights {
	public static void main(String[] args) {
		String fromPort = "Istanbul";
		String toPort = "Frankfurt am Main";
		String flightDate = "2023-07-05";
		String dbUrl = "jdbc:mysql://localhost:3306/reservationsystem";
		String username = "root";
		String password = "mypass123";

		List<Flight> flights = new ArrayList<>();

		try (Connection connection = DriverManager.getConnection(dbUrl, username, password)) {
			String query = "SELECT * FROM flights WHERE fromPort = ? AND toPort = ? AND flightDate = ?";
			PreparedStatement statement = connection.prepareStatement(query);
			statement.setString(1, fromPort);
			statement.setString(2, toPort);
			statement.setString(3, flightDate);

			ResultSet resultSet = statement.executeQuery();

			while (resultSet.next()) {
				Flight flight = new Flight();
				flight.setBusinessCapacity(resultSet.getInt("businessCapacity"));
				flight.setBusinessPriceAdult(resultSet.getDouble("businessPriceAdult"));
				flight.setBusinessPriceChild(resultSet.getDouble("businessPriceChild"));
				flight.setBusinessPriceInfant(resultSet.getDouble("businessPriceInfant"));
				flight.setEconomyCapacity(resultSet.getInt("economyCapacity"));
				flight.setEconomyPriceAdult(resultSet.getDouble("economyPriceAdult"));
				flight.setEconomyPriceChild(resultSet.getDouble("economyPriceChild"));
				flight.setEconomyPriceInfant(resultSet.getDouble("economyPriceInfant"));
				flight.setPlane(resultSet.getString("plane"));
				flight.setCompany(resultSet.getString("company"));
				flight.setFromPort(resultSet.getString("fromPort"));
				flight.setToPort(resultSet.getString("toPort"));
				flight.setFlightDate(resultSet.getString("flightDate"));
				flight.setFlightTime(resultSet.getString("flightTime"));

				flights.add(flight);
			}

			resultSet.close();
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		for (Flight flight : flights) {
			System.out.println("Flight from " + flight.getFromPort() + " to " + flight.getToPort());
			System.out.println("Business Capacity: " + flight.getBusinessCapacity());
			System.out.println("Business Price (Adult): " + flight.getBusinessPriceAdult());
			System.out.println("Business Price (Child): " + flight.getBusinessPriceChild());
			System.out.println("Business Price (Infant): " + flight.getBusinessPriceInfant());
			System.out.println("Economy Capacity: " + flight.getEconomyCapacity());
			System.out.println("Economy Price (Adult): " + flight.getEconomyPriceAdult());
			System.out.println("Economy Price (Child): " + flight.getEconomyPriceChild());
			System.out.println("Economy Price (Infant): " + flight.getEconomyPriceInfant());
			System.out.println("Plane: " + flight.getPlane());
			System.out.println("Company: " + flight.getCompany());
			System.out.println("Flight Date: " + flight.getFlightDate());
			System.out.println("Flight Time: " + flight.getFlightTime());
			System.out.println();
		}
	}
}
