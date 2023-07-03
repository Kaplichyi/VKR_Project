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

import classes.User;

//@WebServlet("/newpost")
public class newpost_page extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con;
	Statement stmt;
       
    public newpost_page() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		try {
			HttpSession session = req.getSession();
			
			User curruser = (User)session.getAttribute("user");
			if(curruser.getRole().equals("author")) {
				con = DBConnectionServlet.DBConnection();
				
				// Загрузка информации об авторе
				req.setAttribute("author_info", DBToolsServlet.GetAuthor(con, curruser.getNickname()));
				
				// Загрузка списка тем
				req.setAttribute("topics", DBToolsServlet.GetAllTopics(con, curruser.getNickname()));
				
				// Загрузка списка типов подписки на автора
				req.setAttribute("subtypes_list", DBToolsServlet.GetSubTypes(con, curruser.getId()));
				con.close();
				
				RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/newpost.jsp");
				requestDispatcher.forward(req, resp);
			}
			else
				throw new Exception("Ошибка подтверждения автора. Страница недоступна. Повторите попытку позднее.");
			
		} catch (Exception e) {
			Cookie error = new Cookie("publish_page_error", "1");
			error.setMaxAge(10);
			resp.addCookie(error);
			e.printStackTrace();
			
			String path = req.getContextPath() + "/signin";
			resp.sendRedirect(path);
		}
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		try {
			HttpSession session = req.getSession();
			User curruser = (User)session.getAttribute("user");
			
			con = DBConnectionServlet.DBConnection();
			
			Cookie publish_result = new Cookie("publish_result", "0");
			
			String Content = req.getParameter("content");
			
			String Topic = req.getParameter("new_topic");
			String Heading = req.getParameter("pheading");
			if(Topic == null) {
				Topic = req.getParameter("topic");
				System.out.println("newpost_page: Выбрана существующая тема");}
			else if(Topic != null && Heading != null) {
				if(Topic.trim().isEmpty() || Heading.trim().isEmpty())
					throw new Exception("Тема/Заголовок не может содержать только пробелы");
				else
					DBToolsServlet.AddTopic(con, Topic, curruser.getNickname());
			}
			else
				throw new Exception("Тема/Заголовок не может содержать только пробелы");
			
			// Запись требуемых типов подписок
			String Sub_Require = "";
					
			String[] getrequire = req.getParameterValues("subtype_require");
			int count = 0;
			if(getrequire != null) {
				for(String type : getrequire) {
					count++;
					if(type != null && !type.equals("null")) {
						if(count == 1)
							Sub_Require = type;
						else
							Sub_Require += "," + type;
					}
				}
			}
					
			if(count == 0)
					Sub_Require = "1";
			String Nickname = (String)curruser.getNickname();
			System.out.println("Newpost: Автор - " + Nickname + " Содержание - " + Content + " Тема - " + Topic + " Требования к подписке - " + Sub_Require);
					
			int rows = 0;
			rows = DBToolsServlet.AddPost(con, Nickname, Heading, Topic, Content, Sub_Require);
			if (rows > 0) { publish_result = new Cookie("publish_result", "1"); }
					
			publish_result.setMaxAge(10);
		
			resp.addCookie(publish_result);
			con.close();
		
			String path = req.getContextPath() + "/author";
			resp.sendRedirect(path);
		} catch (Exception e) {
			e.printStackTrace();
			Cookie error = new Cookie("publish_error", "1");
			error.setMaxAge(10);
			resp.addCookie(error);
			
			String path = req.getContextPath() + "/newpost";
			resp.sendRedirect(path);
		}
	}

}
