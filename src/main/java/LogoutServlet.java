import java.io.IOException;

import com.helper.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();

		User user = (User) session.getAttribute("loggedInUser");

		if (user != null) {
			user.setUserId(-1);
			user.setName(null);
			user.setSurname(null);
			user.setMailAddress(null);
			user.setPhoneNumber(null);
			user.setLoginStatus(false);
		}

		session.invalidate();

		response.sendRedirect("loginRevised.jsp");
	}
}
