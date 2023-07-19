import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.helper.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String mail = request.getParameter("mail");
		String password = request.getParameter("password");
		String url = "jdbc:mysql://localhost:3306/reservationsystem";
		String dbUsername = "root";
		String dbPassword = "mypass123";
		String sql = "SELECT * FROM User WHERE mailAddress = ? AND password = ?";

		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;

		try {
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection(url, dbUsername, dbPassword);
			statement = connection.prepareStatement(sql);
			statement.setString(1, mail);
			statement.setString(2, password);
			resultSet = statement.executeQuery();

			if (resultSet.next()) {
				User user = new User();
				user.setUserId(resultSet.getInt("userId"));
				user.setName(resultSet.getString("name"));
				user.setSurname(resultSet.getString("surname"));
				user.setMailAddress(resultSet.getString("mailAddress"));
				user.setPhoneNumber(resultSet.getString("phoneNumber"));

				user.setLoginStatus(true);

				request.getSession().setAttribute("loggedInUser", user);
				request.setAttribute("activePage", "reservation");
				response.sendRedirect("selectPorts.jsp");
				return;

			} else {
				request.getSession().setAttribute("loginResult", "Login Failed");
				request.setAttribute("activePage", "login");
				response.sendRedirect("loginRevised.jsp");
				return;
			}

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			request.setAttribute("resultMessage", "An error occurred");
		} catch (SQLException e) {
			e.printStackTrace();
			request.setAttribute("resultMessage", "An error occurred");
		} finally {
			if (resultSet != null) {
				try {
					resultSet.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

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
}
