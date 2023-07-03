package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import classes.Post_u;
import classes.User;

//@WebServlet("/post")
public class post_page extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con;
	Statement stmt;
	
    public post_page() {
        super();
    }
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		try {
			HttpSession session = req.getSession();
			
			String req_postid = (String)req.getParameter("postid");
			if(req_postid != null & req_postid != "" || session.getAttribute("postid") != null & session.getAttribute("postid") != "") {
				if(req_postid == null)
					req_postid = (String)session.getAttribute("postid");
				else
					session.setAttribute("postid", req_postid);
				
				con = DBConnectionServlet.DBConnection();
				
				String author_nickname = (String)req.getParameter("author_nickname");
				if(author_nickname == null)
					author_nickname = (String)session.getAttribute("author_nickname");
				else
					session.setAttribute("author_nickname", author_nickname);
				System.out.println("post_page: " + author_nickname);
				
				Post_u post = DBToolsServlet.GetPost(con, req_postid);
				User curruser = (User)session.getAttribute("user");
				
				// Проверка лайка пользователя на пост
				if(curruser != null) {
					String readernickname = curruser.getNickname();
					if(DBToolsServlet.LikeCheck(con, post.getId(), readernickname) != null)
						post.setIsLiked(true);
				}
				
				req.setAttribute("post_info", post);
				System.out.println("post_page: Пост получен.");
				
				req.setAttribute("author_info", DBToolsServlet.GetAuthor(con, author_nickname));
				System.out.println("post_page: Информация об авторе получена.");
				
				req.setAttribute("comments", DBToolsServlet.GetPostComments(con, req_postid));
				System.out.println("post_page: Комментарии получены.");
				
				con.close();
				
				RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/post.jsp");
				requestDispatcher.forward(req, resp);
			}
			else {
				String path = req.getContextPath() + "/author";
				resp.sendRedirect(path);
			}
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		try {
			HttpSession session = req.getSession();
			con = DBConnectionServlet.DBConnection();

			User curruser = (User) session.getAttribute("user");
			
			String postid = req.getParameter("post_id");
			String content = req.getParameter("content");
				
			DBToolsServlet.AddComment(con, postid, curruser.getId(), content);
			
			con.close();
		} catch (ClassNotFoundException | SQLException e) {
			Cookie error = new Cookie("comment_error", "1");
			error.setMaxAge(10);
			resp.addCookie(error);
			e.printStackTrace();
		}
		
		String path = req.getContextPath() + "/post";
		resp.sendRedirect(path);
	}

}
