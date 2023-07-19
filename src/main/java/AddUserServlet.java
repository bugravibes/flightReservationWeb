import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddUserServlet")
public class AddUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = request.getParameter("mailAdress");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("password2");

		if (!isValidEmail(email)) {
			request.getSession().setAttribute("signupResult", "Invalid email format");
			response.sendRedirect("userManagement.jsp");
			return;
		}

		String passwordRegex = ".{8,}";
		if (!password.matches(passwordRegex)) {
			request.getSession().setAttribute("signupResult", "Password must be at least 8 characters long");
			response.sendRedirect("userManagement.jsp");
			return;
		}

		if (!password.equals(confirmPassword)) {
			request.getSession().setAttribute("signupResult", "Passwords do not match");
			response.sendRedirect("userManagement.jsp");
			return;
		}

		request.getSession().setAttribute("signupResult", "Registered Successfully");

		String url = "jdbc:mysql://localhost:3306/reservationsystem";
		String dbUsername = "root";
		String dbPassword = "mypass123";
		String sql = "INSERT INTO User (mailAddress, password) VALUES (?, ?)";

		Connection connection = null;
		PreparedStatement statement = null;

		try {
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection(url, dbUsername, dbPassword);
			statement = connection.prepareStatement(sql);
			statement.setString(1, email);
			statement.setString(2, password);
			statement.executeUpdate();

			response.sendRedirect("userManagement.jsp");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			response.sendRedirect("userManagement.jsp");
		} catch (SQLException e) {
			e.printStackTrace();
			response.sendRedirect("userManagement.jsp");
		} finally {
			if (statement != null) {
				try {
					statement.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (connection != null) {
				try {
					connection.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

	private boolean isValidEmail(String email) {
		String emailRegex = "^[A-Za-z0-9+_.-]+@mail[A-Za-z0-9.-]+$";
		return email.matches(emailRegex);
	}
}
