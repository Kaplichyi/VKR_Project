package servlets;

import java.io.IOException;
import java.sql.Connection;
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

import classes.Author;
import classes.SubType;
import classes.User;

//@WebServlet("/my_subtypes")
public class subtypes_page extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con;
	Statement stmt;
       
    public subtypes_page() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		try {
			HttpSession session = req.getSession();
			
			User curruser = (User)session.getAttribute("user");
			if(curruser != null && curruser.getRole().equals("author"))
			{
				con = DBConnectionServlet.DBConnection();
				
				// Загрузка информации об авторе
				req.setAttribute("author_info", DBToolsServlet.GetAuthor(con, curruser.getNickname()));
				
				// Загрузка списка типов подписки на автора
				req.setAttribute("subtypes_info", DBToolsServlet.GetSubTypes(con, curruser.getId()));
				con.close();
				
				RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/subtypes.jsp");
				requestDispatcher.forward(req, resp);
			}
			else
				throw new Exception("Ошибка подтверждения автора. Страница недоступна. Повторите попытку позднее.");
			
		} catch (Exception e) {
			Cookie error = new Cookie("subtypes_page_error", "1");
			error.setMaxAge(10);
			resp.addCookie(error);
			e.printStackTrace();
			
			String path = req.getContextPath() + "/account";
			resp.sendRedirect(path);
		}
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		try {
			HttpSession session = req.getSession();
			User curruser = (User)session.getAttribute("user");
			int rows = 0;
			Cookie result = new Cookie("subtypes_result", "0");
			if(curruser != null && curruser.getRole().equals("author")) {
				con = DBConnectionServlet.DBConnection();
				if(req.getParameter("req_method").equals("add")) {
					String Name = req.getParameter("name");
					String Description = req.getParameter("description");
					String Price = req.getParameter("price");
					if(!Name.trim().isEmpty())
						rows = DBToolsServlet.AddSubType(con, Name, curruser.getId(), Description, Price);
					else
						throw new Exception("Тема не может содержать только пробелы");
				} else if(req.getParameter("req_method").equals("edit")) {
					String Id = req.getParameter("type_id");
					String NewName = req.getParameter("name");
					String NewDescription = req.getParameter("description");
					String NewPrice = req.getParameter("price");
					
					if(Id != null && !NewName.trim().isEmpty())
						rows = DBToolsServlet.EditSubType(con, Id, NewName, NewDescription, NewPrice);
					else
						throw new Exception("Тема не может содержать только пробелы");
				}
				con.close();
			}
			else {
				String path = req.getContextPath() + "/account";
				resp.sendRedirect(path);
			}
			
			if (rows > 0) { result = new Cookie("subtypes_result", "1"); }
			
			result.setMaxAge(10);
			resp.addCookie(result);

			String path = req.getContextPath() + "/my_subtypes";
			resp.sendRedirect(path);
		} catch (Exception e) {
			Cookie error = new Cookie("subtypes_page_error", "1");
			error.setMaxAge(10);
			resp.addCookie(error);
			e.printStackTrace();
			
			String path = req.getContextPath() + "/my_subtypes";
			resp.sendRedirect(path);
		}
	}

}
