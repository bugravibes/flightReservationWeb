package com.helper;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class fetchFlights {
	private static final String DB_URL = "jdbc:mysql://localhost:3306/reservationsystem";
	private static final String USERNAME = "root";
	private static final String PASSWORD = "mypass123";

	public static List<Flight> getFlights(String fromPort, String toPort, String flightDate, int adultCount,
			int childCount, int infantCount) {
		List<Flight> flights = new ArrayList<>();
		int totalCount = adultCount + childCount;

		try (Connection connection = DriverManager.getConnection(DB_URL, USERNAME, PASSWORD)) {
			String query = "SELECT * FROM flights WHERE fromPort = ? AND toPort = ? AND flightDate = ? AND (? <= businessCapacity OR ? <= economyCapacity)";
			PreparedStatement statement = connection.prepareStatement(query);
			statement.setString(1, fromPort);
			statement.setString(2, toPort);
			statement.setString(3, flightDate);
			statement.setInt(4, totalCount);
			statement.setInt(5, totalCount);
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
				flight.setArrivalTime(resultSet.getString("arrivalTime"));
				flight.setFromPortCode(resultSet.getString("fromPortCode"));
				flight.setToPortCode(resultSet.getString("toPortCode"));
				flight.setAdultCount(adultCount);
				flight.setChildCount(childCount);
				flight.setInfantCount(infantCount);
				flight.setFlightId(resultSet.getInt("flightId"));

				flights.add(flight);
			}

			resultSet.close();
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("Flight1 adultCount:" + flights.get(0).getAdultCount() + ", and childCount is: "
				+ flights.get(0).getChildCount());
		return flights;
	}

	public static Flight getFlightById(int flightId) {
		Flight flight = null;

		try (Connection connection = DriverManager.getConnection(DB_URL, USERNAME, PASSWORD)) {
			String query = "SELECT * FROM flights WHERE flightId = ?";
			PreparedStatement statement = connection.prepareStatement(query);
			statement.setInt(1, flightId);
			ResultSet resultSet = statement.executeQuery();

			if (resultSet.next()) {
				flight = new Flight();
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
				flight.setArrivalTime(resultSet.getString("arrivalTime"));
				flight.setFromPortCode(resultSet.getString("fromPortCode"));
				flight.setToPortCode(resultSet.getString("toPortCode"));
				flight.setFlightId(resultSet.getInt("flightId"));
			}

			resultSet.close();
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return flight;
	}
}
