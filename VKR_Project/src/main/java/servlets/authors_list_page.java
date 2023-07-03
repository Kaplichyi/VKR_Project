package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import classes.Author;
import classes.User;

//@WebServlet("/authors")
public class authors_list_page extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con;
	Statement stmt;

	public authors_list_page() {
		super();
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		ArrayList<Author> authors = new ArrayList<Author>();

		try {
			con = DBConnectionServlet.DBConnection();
			String searchreq = req.getParameter("searchreq");
			if (searchreq != null & searchreq != "")
				authors = DBToolsServlet.GetAuthors(con, searchreq);
			else
				authors = DBToolsServlet.AllAuthors(con);
			
			req.setAttribute("authors", authors);
			req.setAttribute("populauthorslist", DBToolsServlet.GettingPopularAuthors(con));
			req.setAttribute("recentpostslist", DBToolsServlet.RecentPosts(con));
			con.close();
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/authors_list.jsp");
		requestDispatcher.forward(req, resp);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		if (req.getParameter("nickname") != null & req.getParameter("nickname") != "") {
			HttpSession session = req.getSession();
			session.setAttribute("author_nickname", req.getParameter("nickname"));
			System.out.println("author_list_page: Ник автора получен");

			String path = req.getContextPath() + "/author";
			resp.sendRedirect(path);
		} else {
			Cookie c_error = new Cookie("author_list_error", "1");
			System.out.println("author_list_page: Ник автора не получен");
			c_error.setMaxAge(10);
			resp.addCookie(c_error);
			String path = req.getContextPath() + "/authors";
			resp.sendRedirect(path);
		}
	}

}
