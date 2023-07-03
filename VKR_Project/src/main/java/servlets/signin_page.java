package servlets;

import java.io.*;
import java.sql.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import classes.User;

//@WebServlet("/signin")
public class signin_page extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con;
	Statement stmt;

	public signin_page() {
		super();
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		req.setCharacterEncoding("UTF-8");
		User curruser = (User) session.getAttribute("user");
		if (curruser != null) {
			String path = req.getContextPath() + "/account";
			resp.sendRedirect(path);
		} else {
			RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/signin.jsp");
			requestDispatcher.forward(req, resp);
		}
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		try {
			con = DBConnectionServlet.DBConnection();
			stmt = DBConnectionServlet.getStatement(con);

			String Login, Password;
			Login = req.getParameter("login");
			Password = req.getParameter("password");
			
			User curruser = DBToolsServlet.VerifyUser(con, Login, Password);
			if(curruser == null) {
				throw new Exception("Данные логина или пароля введены неверно.");
			}
			con.close();
			
			HttpSession session = req.getSession();
			session.setAttribute("user", curruser);
	        
			if(curruser.getRole().equals("admin")) {
				String path = req.getContextPath() + "/admin";
				resp.sendRedirect(path);
			} else {
				String path = req.getContextPath() + "/account";
				resp.sendRedirect(path);
			}
		} catch (Exception e) {
			Cookie error = new Cookie("signin_error", "1");
			error.setMaxAge(10);
			resp.addCookie(error);
			e.printStackTrace();
			
			String path = req.getContextPath() + "/signin";
			resp.sendRedirect(path);
		}
	}

}
