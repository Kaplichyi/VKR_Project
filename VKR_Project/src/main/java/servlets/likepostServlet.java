package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import classes.User;

//@WebServlet("/like")
public class likepostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con;
	Statement stmt;
       
    public likepostServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		try {
			con = DBConnectionServlet.DBConnection();

			HttpSession session = req.getSession();

			User curruser = (User) session.getAttribute("user");
			if(curruser != null) {
				String postid = req.getParameter("postid");
				String usernickname = curruser.getNickname();
				
				int rows;
				
				if ((usernickname != null || usernickname != "") && (postid != null || postid != "")) {
					if(DBToolsServlet.LikeCheck(con, postid, usernickname) != null) {
						rows = DBToolsServlet.CancelLike(con, postid, usernickname);
						if(rows > 0)
							System.out.println("Лайк отменен.");
					} else {
						rows = DBToolsServlet.LikePost(con, postid, usernickname);
						if(rows > 0)
							System.out.println("Лайк поставлен.");
					}
				}
				con.close();
				
				String ref = null;
				String[] words = req.getHeader("referer").split("/");
		        for (String word : words) {
		            ref = word;
		        }
				
				String path = req.getContextPath() + "/" + ref;
				
				//String path = req.getContextPath() + "/author";
				resp.sendRedirect(path);
			}
			else {
				String path = req.getContextPath() + "/signin";
				resp.sendRedirect(path);
			}

		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

}
