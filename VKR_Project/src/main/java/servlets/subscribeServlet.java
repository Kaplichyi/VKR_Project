package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import classes.User;

//@WebServlet("/subscription")
	public class subscribeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con;
	Statement stmt;
    
    public subscribeServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		try {
			HttpSession session = req.getSession();
			
			User curruser = (User)session.getAttribute("user");
			if(curruser != null) {
				String readernickname = curruser.getNickname();
				String authornickname = (String) session.getAttribute("author_nickname");
				
				int rows = 0;
				
				if ((readernickname != null || readernickname != "") && (authornickname != null || authornickname != "")) {
					con = DBConnectionServlet.DBConnection();
					if(DBToolsServlet.SubCheck(con, readernickname, authornickname) != null) {
						rows += DBToolsServlet.CancelSub(con, readernickname, authornickname);
						if(rows > 0)
							System.out.println("Подписка была отменена.");
					} else {
						String subtype = req.getParameter("subtype_id");
						rows += DBToolsServlet.NewSub(con, readernickname, authornickname, subtype);
						if(rows > 0)
							System.out.println("Подписка была успешно оформлена.");
					}
				}
				con.close();
				
				String path = req.getContextPath() + "/author";
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
