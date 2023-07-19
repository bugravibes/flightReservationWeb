import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SubmitPassengerInfoServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private static final String DB_URL = "jdbc:mysql://localhost:3306/reservationsystem";
	private static final String DB_USER = "root";
	private static final String DB_PASSWORD = "mypass123";

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String clazz = request.getParameter("classValue");
		Integer adultCountObj = Integer.parseInt(request.getParameter("adultCount"));
		Integer childCountObj = Integer.parseInt(request.getParameter("childCount"));
		Integer infantCountObj = Integer.parseInt(request.getParameter("infantCount"));

		System.out.println("Class Value: " + clazz);
		System.out.println("Adult Count: " + adultCountObj);
		System.out.println("Child Count: " + childCountObj);
		System.out.println("Infant Count: " + infantCountObj);

		int adultCount = (adultCountObj != null) ? adultCountObj : 0;
		int childCount = (childCountObj != null) ? childCountObj : 0;
		int infantCount = (infantCountObj != null) ? infantCountObj : 0;
		String PNR = generateRandomPNR.generateRandomPNR();

		String flightIdFetch = request.getParameter("flightId");
		int flightId = Integer.parseInt(flightIdFetch);

		for (int i = 1; i <= adultCount; i++) {
			String name = request.getParameter("nameAdult" + i);
			String surname = request.getParameter("surnameAdult" + i);
			String passportNo = request.getParameter("passportAdult" + i);
			String birthDate = request.getParameter("birthDateAdult" + i);
			String gender = request.getParameter("genderAdult" + i);

			System.out.println("Adult Passenger " + i + " - Name: " + name + ", Surname: " + surname + ", PassportNo: "
					+ passportNo + ", BirthDate: " + birthDate + ", Gender: " + gender);

			insertPassengerInfo(flightId, name, surname, birthDate, gender, "adult", clazz, PNR, passportNo);
		}

		for (int i = 1; i <= childCount; i++) {
			String name = request.getParameter("nameChild" + i);
			String surname = request.getParameter("surnameChild" + i);
			String passportNo = request.getParameter("passportChild" + i);
			String birthDate = request.getParameter("birthDateChild" + i);
			String gender = request.getParameter("genderChild" + i);

			insertPassengerInfo(flightId, name, surname, birthDate, gender, "child", clazz, PNR, passportNo);
		}

		for (int i = 1; i <= infantCount; i++) {
			String name = request.getParameter("nameInfant" + i);
			String surname = request.getParameter("surnameInfant" + i);
			String passportNo = request.getParameter("passportInfant" + i);
			String birthDate = request.getParameter("birthDateInfant" + i);
			String gender = request.getParameter("genderInfant" + i);

			insertPassengerInfo(flightId, name, surname, birthDate, gender, "infant", clazz, PNR, passportNo);
		}
		response.sendRedirect("totalPrice.jsp?PNR=" + PNR);
	}

	private void insertPassengerInfo(int flightId, String name, String surname, String birthDate, String gender,
			String category, String clazz, String pnr, String passportNo) {

		try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
			String sql = "INSERT INTO reservations (flightId, name, surname, birthDate, gender, category, class, pnr, passportNo) "
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

			try (PreparedStatement stmt = conn.prepareStatement(sql)) {
				stmt.setInt(1, flightId);
				stmt.setString(2, name);
				stmt.setString(3, surname);
				stmt.setString(4, birthDate);
				stmt.setString(5, gender);
				stmt.setString(6, category);
				stmt.setString(7, clazz);
				stmt.setString(8, pnr);
				stmt.setString(9, passportNo);

				stmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
