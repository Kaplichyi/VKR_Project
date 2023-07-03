package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import classes.Subscription;
import classes.User;

//@WebServlet("/account")
public class account_page extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con;
	Statement stmt;

	public account_page() {
		super();
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		req.setCharacterEncoding("UTF-8");
		User curruser = (User) session.getAttribute("user");
		if (curruser != null) {
			if(curruser.getRole().equals("admin")) {
				System.out.println("Вход админа.");
				String path = req.getContextPath() + "/admin";
				resp.sendRedirect(path);
			}
			else {
				try {
					con = DBConnectionServlet.DBConnection();
					req.setAttribute("subslist", DBToolsServlet.GetSubsList(con, curruser.getNickname()));
				} catch (ClassNotFoundException | SQLException e) {
					e.printStackTrace();
				}
				RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/personal_account.jsp");
				requestDispatcher.forward(req, resp);
			}
		} else {
			String path = req.getContextPath() + "/signin";
			resp.sendRedirect(path);
		}
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		try {
			HttpSession session = req.getSession();
			con = DBConnectionServlet.DBConnection();

			User curruser = (User) session.getAttribute("user");
			
			Cookie upd_result = new Cookie("upd_result", "0");
			String Login = curruser.getLogin();
			String Password = req.getParameter("password");
			if(DBToolsServlet.VerifyUser(con, Login, Password) != null)
			{
				String NewNickname = req.getParameter("newnickname");
				String NewEMail = req.getParameter("newemail");
				String NewRole = req.getParameter("newrole");
				String NewAbout = req.getParameter("newabout");
				
				int rows = 0;
				rows = DBToolsServlet.EditUser(con, curruser.getId(), null, null, NewNickname, NewAbout, NewRole, NewEMail);
				if (rows > 0) { 
					upd_result = new Cookie("upd_result", "1");
					curruser = DBToolsServlet.VerifyUser(con, Login, Password);
				}
				else {
					System.out.println("Данные пользователя с ID = " + curruser.getId() + " не были изменены.");
					upd_result = new Cookie("upd_result", "-1");
				}
			}
			else
				throw new Exception("Пароль введен неверно.");
			upd_result.setMaxAge(10);
			resp.addCookie(upd_result);
			
			con.close();

			session.setAttribute("user", curruser);
		} catch (Exception e) {
			Cookie error = new Cookie("account_error", "1");
			error.setMaxAge(10);
			resp.addCookie(error);
			e.printStackTrace();
		}
		
		String path = req.getContextPath() + "/account";
		resp.sendRedirect(path);
	}

}
