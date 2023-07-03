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

//@WebServlet("/admin")
public class admin_page extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con;
	Statement stmt;

	public admin_page() {
		super();
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		try {
			HttpSession session = req.getSession();
			
			User curruser = (User) session.getAttribute("user");
			
			if(curruser != null) {
				if(curruser.getRole().equals("admin")) {
					String req_table = req.getParameter("table_name");
					String table_name = (String) session.getAttribute("table_name");
					
					if(req_table != null && req_table != "" && req_table != "null") {
						table_name = req_table;
						session.setAttribute("table_name", req_table);
					}
					
					if(table_name != null && table_name != "" && table_name != "null") {
						con = DBConnectionServlet.DBConnection();
						req.setAttribute("table_name", table_name);
						req.setAttribute("table_headers", DBToolsServlet.GetTableHeaders(con, table_name));
						if(table_name.equals("s_user"))
							req.setAttribute("users_list", DBToolsServlet.AllUsers(con));
						
						else if(table_name.equals("post")) {
							req.setAttribute("posts_list", DBToolsServlet.AllPosts(con));
							req.setAttribute("post_topics_list", DBToolsServlet.AllTopics(con));
						}
						
						else if(table_name.equals("comment"))
							req.setAttribute("comments_list", DBToolsServlet.AllComments(con));
						
						else if(table_name.equals("subscription")) {
							req.setAttribute("subtypes_list", DBToolsServlet.AllSubTypes(con));
							req.setAttribute("subs_list", DBToolsServlet.AllSubs(con));
						}
						
						else if(table_name.equals("content_topic"))
							req.setAttribute("topics_list", DBToolsServlet.AllTopics(con));
						
						else if(table_name.equals("sub_type"))
							req.setAttribute("sub_types_list", DBToolsServlet.AllSubTypes(con));
						
						con.close();
					}
					RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/admin.jsp");
					requestDispatcher.forward(req, resp);
				}
				else {
					String path = req.getContextPath() + "/signin";
					resp.sendRedirect(path);
				}
			}
			else {
				String path = req.getContextPath() + "/signin";
				resp.sendRedirect(path);
			}
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		try {
			HttpSession session = req.getSession();
			con = DBConnectionServlet.DBConnection();
			
			String table_name = req.getParameter("table_name");
			String req_method = req.getParameter("req_method");
			Integer rows = 0;
			
			System.out.println("Таблица " + table_name);
			if(req_method.equals("add")) {
				System.out.println("Запрос adminAdd");
				if(table_name.equals("s_user")) {
					if(req.getParameter("user_id") == null || req.getParameter("user_id") == "" || req.getParameter("user_id") == "null") {
						String Login = req.getParameter("user_login");
						String Password = req.getParameter("user_password");
						String Nickname = req.getParameter("user_nickname");
						String About = req.getParameter("user_about");
						String Role = req.getParameter("user_role");
						String EMail = req.getParameter("user_email");
						System.out.println("Данные запроса: " + Login + " " + Password + " " + Nickname + " " + About + " " + Role + " " + EMail);
						
						rows = DBToolsServlet.AddUser(con, Login, Password, Nickname, About, Role, EMail);
					}
					else
						throw new Exception("Ошибка данных.");
				}
			}
			else if(req_method.equals("edit")) {
				System.out.println("Запрос adminEdit");
				if(table_name.equals("s_user")) {
					if(req.getParameter("user_id") != null) {
						String Id = req.getParameter("user_id");
						String Login = req.getParameter("user_login");
						String Password = req.getParameter("user_password");
						String Nickname = req.getParameter("user_nickname");
						String About = req.getParameter("user_about");
						String Role = req.getParameter("user_role");
						String EMail = req.getParameter("user_email");
						System.out.println("Данные запроса: " + Id + " " + Login + " " + Password + " " + Nickname + " " + About + " " + Role + " " + EMail);
						
						rows = DBToolsServlet.EditUser(con, Id, Login, Password, Nickname, About, Role, EMail);
					}
					else
						throw new Exception("Ошибка данных.");
				}
				else if (table_name.equals("sub_type")) {
					if(req.getParameter("subtype_id") != null) {
						String Id = req.getParameter("subtype_id");
						String NewName = req.getParameter("subtype_name");
						String NewDesription = req.getParameter("subtype_description");
						String NewPrice = req.getParameter("subtype_price");
						System.out.println("Данные запроса: " + NewName);
						
						rows = DBToolsServlet.EditSubType(con, Id, NewName, NewDesription, NewPrice);
					}
					else
						throw new Exception("Ошибка данных.");
				}
				else if (table_name.equals("content_topic")) {
					if(req.getParameter("topic_id") != null) {
						String Id = req.getParameter("topic_id");
						String NewName = req.getParameter("topic_name");
						System.out.println("Данные запроса: " + NewName);
						
						rows = DBToolsServlet.EditTopic(con, Id, NewName);
					}
					else
						throw new Exception("Ошибка данных.");
				}
			}
			else if(req_method.equals("delete")) {
				System.out.println("Запрос adminDelete");
				if(table_name.equals("s_user")) {
					if(req.getParameter("user_id") != null & !req.getParameter("user_role").equals("admin")) {
						String Id = req.getParameter("user_id");
						System.out.println("Данные запроса: " + Id);

						rows = DBToolsServlet.DelUser(con, Id);
					}
					else
						throw new Exception("Ошибка данных.");
				} else if (table_name.equals("post")) {
					if(req.getParameter("post_id") != null) {
						String Id = req.getParameter("post_id");
						System.out.println("Данные запроса: " + Id);

						rows = DBToolsServlet.DelPost(con, Id);
					}
					else
						throw new Exception("Ошибка данных.");
				} else if (table_name.equals("comment")) {
					if(req.getParameter("comment_id") != null) {
						String Id = req.getParameter("comment_id");
						System.out.println("Данные запроса: " + Id);

						rows = DBToolsServlet.DelComment(con, Id);
					}
					else
						throw new Exception("Ошибка данных.");
				} else if (table_name.equals("subscription")) {
					if(req.getParameter("sub_reader_id") != null && req.getParameter("sub_author_id") != null) {
						String reader = DBToolsServlet.GetUserNickname(con, req.getParameter("sub_reader_id"));
						String author = DBToolsServlet.GetUserNickname(con, req.getParameter("sub_author_id"));
						System.out.println("Данные запроса: подписчик - " + reader + ", автор - " + author);

						rows = DBToolsServlet.CancelSub(con, reader, author);
					}
					else
						throw new Exception("Ошибка данных.");
				} else if (table_name.equals("sub_type")) {
					if(req.getParameter("subtype_id") != null) {
						String Id = req.getParameter("subtype_id");
						System.out.println("Данные запроса: " + Id);
						
						rows = DBToolsServlet.DelSubType(con, Id);
					}
					else
						throw new Exception("Ошибка данных.");
				}
				else if (table_name.equals("content_topic")) {
					if(req.getParameter("topic_id") != null) {
						String Id = req.getParameter("topic_id");
						System.out.println("Данные запроса: " + Id);
						
						rows = DBToolsServlet.DelTopic(con, Id);
					}
					else
						throw new Exception("Ошибка данных.");
				}
			}
			if(rows <= 0) {
				System.out.println("Запрос отклонен.");
			}
			
			Cookie res = new Cookie("admin_page_res", Integer.toString(rows));
			res.setMaxAge(10);
			resp.addCookie(res);
			
			session.setAttribute("table_name", table_name);
			con.close();
		} catch (Exception e) {
			Cookie error = new Cookie("admin_page_error", "1");
			error.setMaxAge(10);
			resp.addCookie(error);
			e.printStackTrace();
		}
		
		String path = req.getContextPath() + "/admin";
		resp.sendRedirect(path);
	}
}
