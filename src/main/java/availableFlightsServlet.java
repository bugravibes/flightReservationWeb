import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.helper.Flight;
import com.helper.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class availableFlightsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// public List<Flight> flights = new ArrayList<>();

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String fromPort = request.getParameter("fromPort");
		String toPort = request.getParameter("toPort");
		String flightDate = request.getParameter("flightDate");
		String adultCount = request.getParameter("adultCount");
		String childCount = request.getParameter("childCount");
		String infantCount = request.getParameter("infantCount");
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
			User user = (User) request.getSession().getAttribute("loggedInUser");
			request.getSession().setAttribute("loggedInUser", user);
			ResultSet resultSet = statement.executeQuery();

			if (resultSet.next()) {
				do {
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
					flight.setFlightId(resultSet.getInt("flightId"));

					flights.add(flight);
				} while (resultSet.next());

				System.out.println("Flight1 business capacity: " + flights.get(0).getBusinessCapacity()
						+ ", and price is: " + flights.get(0).getBusinessPriceAdult() + " dollars");

				request.getSession().setAttribute("flights", flights);
				request.setAttribute("activePage", "reservation");
				request.setAttribute("fromPort", fromPort);
				request.setAttribute("toPort", toPort);
				request.setAttribute("flightDate", flightDate);
				request.setAttribute("adultCount", adultCount);
				request.setAttribute("childCount", childCount);
				request.setAttribute("infantCount", infantCount);
				request.getRequestDispatcher("availableFlights.jsp").forward(request, response);
				resultSet.close();
				statement.close();
				return;
			} else {

				request.setAttribute("activePage", "reservation");
				request.setAttribute("error", "No flights available.");
				request.setAttribute("fromPort", fromPort);
				request.setAttribute("toPort", toPort);
				request.setAttribute("flightDate", flightDate);
				request.getRequestDispatcher("selectPorts.jsp").forward(request, response);
				return;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		request.setAttribute("flights", flights);
		request.setAttribute("activePage", "reservation");
		response.sendRedirect("availableFlights.jsp");
	}
}
