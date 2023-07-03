package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import classes.User;

//@WebServlet("/signup")
public class signup_page extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con;
	Statement stmt;
	public signup_page() {
		super();
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		User curruser = (User) session.getAttribute("user");
		if (curruser != null) {
			String path = req.getContextPath() + "/account";
			resp.sendRedirect(path);
		} else {
			RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/signup.jsp");
			requestDispatcher.forward(req, resp);
		}
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		try {

			con = DBConnectionServlet.DBConnection();

			Cookie reg_result = new Cookie("reg_result", "0");
			String Login = req.getParameter("login");
			String Password = req.getParameter("password");
			String Nickname = req.getParameter("nickname");
			String EMail = req.getParameter("email");
			String Role = null;
			if(req.getParameter("is_author") == null)
				Role = "user";
			else if(req.getParameter("is_author").equals("on"))
				Role = "author";
			System.out.println("signup_page - doPost: " + Role);
			
			int rows = 0;
			rows = DBToolsServlet.AddUser(con, Login, Password, Nickname, null, Role, EMail);
			if (rows > 0) { reg_result = new Cookie("reg_result", "1"); }
			
			reg_result.setMaxAge(10);

			resp.addCookie(reg_result);
			con.close();

			String path = req.getContextPath() + "/signin";
			resp.sendRedirect(path);
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
			Cookie error = new Cookie("reg_error", "1");
			error.setMaxAge(10);
			resp.addCookie(error);
			
			String path = req.getContextPath() + "/signup";
			resp.sendRedirect(path);
		}
	}

}
