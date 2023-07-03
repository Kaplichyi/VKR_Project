package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import classes.Author;
import classes.Post_u;
import classes.User;

//@WebServlet("/author")
public class author_page extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con;
	Statement stmt;

	public author_page() {
		super();
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		try {
			con = DBConnectionServlet.DBConnection();

			HttpSession session = req.getSession();

			String author_nickname = (String)req.getParameter("author_nickname");
			if(author_nickname == null)
				author_nickname = (String)session.getAttribute("author_nickname");
			else
				session.setAttribute("author_nickname", author_nickname);
			System.out.println("author_page: " + author_nickname);
			
			User curruser = (User)session.getAttribute("user");
			
			String topic = null;
			
			if (author_nickname != null && author_nickname != "") {
				// Загрузка информации об авторе
				req.setAttribute("author_info", DBToolsServlet.GetAuthor(con, author_nickname));
				
				// Загрузка списка тем
				req.setAttribute("topics", DBToolsServlet.GetAllTopics(con, author_nickname));
				
				// Загрузка списка постов
				ArrayList<Post_u> posts = new ArrayList<Post_u>();
				
				topic = req.getParameter("topicreq");
				if(topic != null)
					posts = DBToolsServlet.GetAuthorPosts(con, author_nickname, topic);
				else
					posts = DBToolsServlet.GetAuthorPosts(con, author_nickname);

				// Загрузка списка типов подписки на автора
				req.setAttribute("subtypes_info", DBToolsServlet.GetSubTypes(con, DBToolsServlet.GetUserID(con, author_nickname)));
				
				// Проверка лайков пользователя на посты
				if(curruser != null) {
					String readernickname = curruser.getNickname();
					posts = DBToolsServlet.LikeCheck(con, posts, readernickname);
					
				// Проверка наличия подписки текущего пользователя на автора страницы
					req.setAttribute("subscription", DBToolsServlet.SubCheck(con, readernickname, author_nickname));
				}
				
				req.setAttribute("posts", posts);
				
				con.close();
				
				RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/author.jsp");
				requestDispatcher.forward(req, resp);
			} else {
				String path = req.getContextPath() + "/authors";
				resp.sendRedirect(path);
			}

		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doGet(req, resp);
	}
}
