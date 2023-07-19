package com.helper;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class updatePayment {
	private static final String DB_URL = "jdbc:mysql://localhost:3306/reservationsystem";
	private static final String DB_USER = "root";
	private static final String DB_PASSWORD = "mypass123";

	public static void updatePaymentStatus(String pnrNo) {
		try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
			String updateSql = "UPDATE reservations SET payment = 'paid' WHERE pnr = ?";
			PreparedStatement updateStatement = connection.prepareStatement(updateSql);
			updateStatement.setString(1, pnrNo);
			int rowsUpdated = updateStatement.executeUpdate();
			if (rowsUpdated > 0) {
				System.out.println("Payment status updated to 'paid' for PNR: " + pnrNo);
			} else {
				System.out.println("Failed to update payment status for PNR: " + pnrNo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public static void cancelPayment(String pnrNo) {
		try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
			String updateSql = "UPDATE reservations SET payment = 'canceled' WHERE pnr = ?";
			PreparedStatement updateStatement = connection.prepareStatement(updateSql);
			updateStatement.setString(1, pnrNo);
			int rowsUpdated = updateStatement.executeUpdate();
			if (rowsUpdated > 0) {
				System.out.println("Payment status updated to 'canceled' for PNR: " + pnrNo);
			} else {
				System.out.println("Failed to update payment status for PNR: " + pnrNo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static String getPayment(String pnrNo) {
		try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
			String selectSql = "SELECT payment FROM reservations WHERE pnr = ?";
			PreparedStatement selectStatement = connection.prepareStatement(selectSql);
			selectStatement.setString(1, pnrNo);
			ResultSet resultSet = selectStatement.executeQuery();

			if (resultSet.next()) {
				return resultSet.getString("payment");

			} else {
				return "Reservation with PNR: " + pnrNo + " not found.";
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

}
