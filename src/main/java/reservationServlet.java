import java.io.IOException;

import com.helper.Flight;
import com.helper.fetchFlights;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class reservationServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int adultCount = Integer.parseInt(request.getParameter("adultCount"));
		int childCount = Integer.parseInt(request.getParameter("childCount"));
		int infantCount = Integer.parseInt(request.getParameter("infantCount"));

		String flightIndex = request.getParameter("flightIndex");
		String classValue = request.getParameter("classValue" + flightIndex);
		/*
		 * List<Flight> flights =
		 * fetchFlights.getFlights(request.getParameter("fromPort"),
		 * request.getParameter("toPort"), request.getParameter("flightDate"), 1, 1, 1);
		 * Flight selectedFlight = flights.get(Integer.parseInt(flightIndex));
		 */
		int flightId = Integer.parseInt(request.getParameter("flightId"));
		Flight selectedFlight = fetchFlights.getFlightById(flightId);
		request.setAttribute("classValue", classValue);
		request.setAttribute("flightId", flightId);
		request.setAttribute("adultCount", adultCount);
		request.setAttribute("childCount", childCount);
		request.setAttribute("infantCount", infantCount);
		request.setAttribute("company", selectedFlight.getCompany());
		request.setAttribute("fromPortCode", selectedFlight.getFromPortCode());
		request.setAttribute("toPortCode", selectedFlight.getToPortCode());
		request.setAttribute("fromPort", selectedFlight.getFromPortCode());
		request.setAttribute("toPort", selectedFlight.getToPortCode());
		request.setAttribute("flightDate", selectedFlight.getFlightDate());
		request.setAttribute("flightTime", selectedFlight.getFlightTime());
		request.setAttribute("adultCount", adultCount);
		request.setAttribute("childCount", childCount);
		request.setAttribute("infantCount", infantCount);
		RequestDispatcher dispatcher = request.getRequestDispatcher("getPassengerInfo.jsp");
		dispatcher.forward(request, response);
	}
}
