package com.helper;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class fetchReservations {

	private static final String DB_URL = "jdbc:mysql://localhost:3306/reservationsystem";
	private static final String DB_USER = "root";
	private static final String DB_PASSWORD = "mypass123";

	public static List<Reservation> getReservationsByPNR(String pnr) {
		List<Reservation> reservations = new ArrayList<>();

		try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
			String sql = "SELECT * FROM reservations WHERE pnr = ?";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, pnr);

			ResultSet resultSet = statement.executeQuery();

			while (resultSet.next()) {
				int reservationId = resultSet.getInt("reservationId");
				int flightId = resultSet.getInt("flightId");
				String name = resultSet.getString("name");
				String surname = resultSet.getString("surname");
				java.sql.Date birthDate = resultSet.getDate("birthDate");
				String gender = resultSet.getString("gender");
				String category = resultSet.getString("category");
				String flightClass = resultSet.getString("class");
				java.sql.Date flightDate = resultSet.getDate("flightDate");
				java.sql.Time flightTime = resultSet.getTime("flightTime");
				String fromPort = resultSet.getString("fromPort");
				String toPort = resultSet.getString("toPort");
				String pnrValue = resultSet.getString("pnr");
				String passportNo = resultSet.getString("passportNo");
				java.math.BigDecimal price = resultSet.getBigDecimal("price");
				String payment = resultSet.getString("payment");
				String company = resultSet.getString("company");
				String flightNo = resultSet.getString("flightNo");

				Reservation reservation = new Reservation();
				reservation.setReservationId(reservationId);
				reservation.setFlightId(flightId);
				reservation.setName(name);
				reservation.setSurname(surname);
				reservation.setBirthDate(birthDate);
				reservation.setGender(gender);
				reservation.setCategory(category);
				reservation.setFlightClass(flightClass);
				reservation.setFlightDate(flightDate);
				reservation.setFlightTime(flightTime);
				reservation.setFromPort(fromPort);
				reservation.setToPort(toPort);
				reservation.setPnr(pnrValue);
				reservation.setPassportNo(passportNo);
				reservation.setPrice(price);
				reservation.setPayment(payment);
				reservation.setCompany(company);
				reservation.setFlightNo(flightNo);

				reservations.add(reservation);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return reservations;
	}
}
