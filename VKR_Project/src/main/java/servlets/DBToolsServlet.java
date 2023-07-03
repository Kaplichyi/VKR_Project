package servlets;

import java.sql.*;
import java.util.ArrayList;

import classes.Author;
import classes.Comment;
import classes.Like;
import classes.Post_adm;
import classes.Post_u;
import classes.SubType;
import classes.Subscription;
import classes.Subscription_adm;
import classes.Topic;
import classes.User;

public class DBToolsServlet {
	
	// --ДАННЫЕ СТРОК--
	
	public static String FixChars(String string) throws SQLException {
		String corrected_string = null;
		if(string != null & string != "" & string != "null") {
			corrected_string = string.replace("\\\"","\"");
			corrected_string = corrected_string.replace("''","'");
		}
		return corrected_string;
	}
	
	public static String SourceChars(String string) throws SQLException {
		String corrected_string = null;
		if(string != null & string != "" & string != "null") {
			corrected_string = string.replace("\\\"","\"");
			corrected_string = corrected_string.replace("''","'");
		}
		return corrected_string;
	}
	
	
	
	
	// --ДАННЫЕ ТАБЛИЦ--
	
	public static ArrayList<String> GetTableHeaders(Connection con, String table_name) throws SQLException {
		ArrayList<String> headers = new ArrayList<String>();

		Statement stmt = DBConnectionServlet.getStatement(con);
		ResultSet res = stmt.executeQuery("SELECT * FROM " + table_name);
		ResultSetMetaData rsmd = res.getMetaData();
		int columnCount = rsmd.getColumnCount();
		System.out.println("DBToolsServlet - GetTableHeaders: Таблица - " + table_name);
		for (int i = 1; i <= columnCount; i++ ) {
			headers.add(rsmd.getColumnName(i));
			System.out.println("				Столбец - " + rsmd.getColumnName(i));
		}
			
		stmt.close();

		return headers;
	}
	
	
	
	
	// --РАБОТА С АВТОРАМИ--
	
	public static ArrayList<Author> GetAuthors(Connection con, String searchreq) throws SQLException, ClassNotFoundException {
		ArrayList<Author> authors = new ArrayList<Author>();
		
		Statement stmt = DBConnectionServlet.getStatement(con);
		ResultSet res = stmt.executeQuery("SELECT user_id, user_nickname, user_about, user_subs_amount FROM s_user WHERE user_role LIKE 'author' AND user_nickname LIKE '%"
							+ searchreq + "%'");
		
		while (res.next()) {
			String id = Integer.toString(res.getInt("user_id"));
			String nickname = res.getString("user_nickname");
			String about = SourceChars(res.getString("user_about"));
			String subsamount = Integer.toString(res.getInt("user_subs_amount"));
			String postcount = Integer.toString(CountAuthorPosts(con, id));
			Author author = new Author(id, nickname, about, subsamount, postcount);
			authors.add(author);
		}
		stmt.close();
		
		return authors;
	}
	
	public static ArrayList<Author> GettingPopularAuthors(Connection con) throws SQLException, ClassNotFoundException {
		ArrayList<Author> authors = new ArrayList<Author>();
		
		Statement stmt = DBConnectionServlet.getStatement(con);
		ResultSet res = stmt.executeQuery("SELECT user_id, user_nickname, user_about, user_subs_amount FROM s_user WHERE user_role LIKE 'author' ORDER BY user_subs_amount DESC LIMIT 3");
		
		while (res.next()) {
			String id = Integer.toString(res.getInt("user_id"));
			String nickname = res.getString("user_nickname");
			String about = SourceChars(res.getString("user_about"));
			String subsamount = Integer.toString(res.getInt("user_subs_amount"));
			String postcount = Integer.toString(CountAuthorPosts(con, id));
			Author author = new Author(id, nickname, about, subsamount, postcount);
			authors.add(author);
		}
		stmt.close();
		
		return authors;
	}
	
	public static ArrayList<Author> AllAuthors(Connection con) throws SQLException, ClassNotFoundException {
		ArrayList<Author> authors = new ArrayList<Author>();
		
		Statement stmt = DBConnectionServlet.getStatement(con);
		ResultSet res = stmt.executeQuery("SELECT user_id, user_nickname, user_about, user_subs_amount FROM s_user WHERE user_role LIKE 'author'");

		while (res.next()) {
			String id = Integer.toString(res.getInt("user_id"));
			String nickname = res.getString("user_nickname");
			String about = SourceChars(res.getString("user_about"));
			String subsamount = Integer.toString(res.getInt("user_subs_amount"));
			String postcount = Integer.toString(CountAuthorPosts(con, id));
			Author author = new Author(id, nickname, about, subsamount, postcount);
			authors.add(author);
		}
		stmt.close();

		return authors;
	}
	
	public static Author GetAuthor(Connection con, String nickname) throws SQLException, ClassNotFoundException {
		Author author = null;
		Statement stmt = DBConnectionServlet.getStatement(con);
		
		System.out.println("DBToolsServlet - GetAuthor: Запрашиваемый автор имеет никнейм - " + nickname);
		
		ResultSet res = stmt.executeQuery("SELECT * FROM s_user WHERE user_nickname = '" + nickname + "'");
		
		if(res.next()) {
			String id = Integer.toString(res.getInt("user_id"));
			String postcount = Integer.toString(CountAuthorPosts(con, id));
			author = new Author(id, res.getString("user_nickname"), SourceChars(res.getString("user_about")), Integer.toString(res.getInt("user_subs_amount")), postcount);
		}
			
		stmt.close();

		return author;
	}
	
	public static int CountAuthorPosts(Connection con, String id) throws SQLException, ClassNotFoundException {
		Statement stmt = DBConnectionServlet.getStatement(con);
		
		
		System.out.println("DBToolsServlet - CountAuthorPosts: Запрашиваемый автор имеет никнейм - " + id);
		int count = 0;
				
		ResultSet postcount = stmt.executeQuery("SELECT count(*) as post_count FROM post WHERE post_author = '" + id + "'");;
        if(postcount.next())
        	count = postcount.getInt("post_count");
        stmt.close();

		return count;
	}
	
	
	
	
	// --РАБОТА С ПОЛЬЗОВАТЕЛЯМИ--
	
	public static int AddUser(Connection con, String Login, String Password, String Nickname, String About, String Role, String EMail) throws SQLException, ClassNotFoundException {
		Statement stmt = DBConnectionServlet.getStatement(con);

		int rows = 0;
		rows = stmt.executeUpdate("INSERT INTO s_user (user_login, user_password, user_nickname, user_about, user_role, user_email) values ('" + Login + "', '" + Password + "', '" + Nickname + "', '" + About + "', '" + Role + "', '" + EMail + "')");
		stmt.close();
		return rows;
	}
	
	public static User VerifyUser(Connection con, String Login, String Password) throws SQLException, ClassNotFoundException {
		User curruser = null;
		Statement stmt = DBConnectionServlet.getStatement(con);
			
		ResultSet res = stmt.executeQuery("SELECT * FROM s_user WHERE user_login = '" + Login + "' AND user_password = '" + Password + "'");
			
		if (res.next()) {
			curruser = new User(Integer.toString(res.getInt("user_id")), res.getString("user_login"),
			res.getString("user_password"), res.getString("user_nickname"), SourceChars(res.getString("user_about")),
			Integer.toString(res.getInt("user_subs_amount")), res.getString("user_role"), res.getString("user_email"));
		}
		
		stmt.close();

		return curruser;
	}
	
	public static String GetUserID(Connection con, String Nickname) throws SQLException, ClassNotFoundException {
		Statement stmt = DBConnectionServlet.getStatement(con);
		
		ResultSet res = stmt.executeQuery("SELECT user_id FROM s_user WHERE user_nickname = '" + Nickname + "'");
		
		String id = null;
		if (res.next()) {
			id = Integer.toString(res.getInt("user_id"));
			//System.out.println("DBToolsServlet - GetUserID: " + Nickname + " = " + id);
		}
		
		stmt.close();

		return id;
	}
	
	public static String GetUserNickname(Connection con, String ID) throws SQLException, ClassNotFoundException {
		Statement stmt = DBConnectionServlet.getStatement(con);
		
		ResultSet res = stmt.executeQuery("SELECT user_nickname FROM s_user WHERE user_id = '" + ID + "'");
			
		String nickname = null;
		if (res.next()) {
			nickname = res.getString("user_nickname");
			//System.out.println("DBToolsServlet - GetUserNickname: " + id + " = " + nickname);
		}
		
		stmt.close();

		return nickname;
	}
	
	public static int EditUser(Connection con, String Id, String NewLogin, String NewPassword, String NewNickname, String NewAbout, String NewRole, String NewEMail) throws SQLException, ClassNotFoundException {
		String sql_loginupdate = " user_login = '" + NewLogin + "'";
		String sql_passwordupdate = " user_password = '" + NewPassword + "'";
		String sql_nicknameupdate = " user_nickname = '" + NewNickname + "'";
		String sql_aboutupdate = " user_about = '" + FixChars(NewAbout) + "'";
		String sql_roleupdate = " user_role = '" + NewRole + "'";
		String sql_emailupdate = " user_email = '" + NewEMail + "'";
		int rowUpdated = 0;
		
		System.out.println("DBToolsServlet - EditUser: Запрос на обновление данных пользователя c ID = " + Id + "");
		System.out.println("						  " + sql_loginupdate);
		System.out.println("						  " + sql_passwordupdate);
		System.out.println("						  " + sql_nicknameupdate);
		System.out.println("						  " + sql_aboutupdate);
		System.out.println("						  " + sql_roleupdate);
		System.out.println("						  " + sql_emailupdate);
		
		if(NewLogin != null & NewLogin != "" & NewLogin != "null") {
			Statement stmt = DBConnectionServlet.getStatement(con);
			rowUpdated += stmt.executeUpdate("UPDATE s_user SET" + sql_loginupdate + " WHERE user_id = '" + Id + "'");
			stmt.close();
		}
		if(NewPassword != null & NewPassword != "" & NewPassword != "null") {
			Statement stmt = DBConnectionServlet.getStatement(con);
			rowUpdated += stmt.executeUpdate("UPDATE s_user SET" + sql_passwordupdate + " WHERE user_id = '" + Id + "'");
			stmt.close();
		}
		if(NewNickname != null & NewNickname != "" & NewNickname != "null") {
			Statement stmt = DBConnectionServlet.getStatement(con);
			rowUpdated += stmt.executeUpdate("UPDATE s_user SET" + sql_nicknameupdate + " WHERE user_id = '" + Id + "'");
			stmt.close();
		}
		if(NewAbout != null & NewAbout != "" & NewAbout != "null") {
			Statement stmt = DBConnectionServlet.getStatement(con);
			rowUpdated += stmt.executeUpdate("UPDATE s_user SET" + sql_aboutupdate + " WHERE user_id = '" + Id + "'");
			stmt.close();
		}
		if(NewRole != null & NewRole != "" & NewRole != "null") {
			Statement stmt = DBConnectionServlet.getStatement(con);
			rowUpdated += stmt.executeUpdate("UPDATE s_user SET" + sql_roleupdate + " WHERE user_id = '" + Id + "'");
			stmt.close();
		}
		if(NewEMail != null & NewEMail != "" & NewEMail != "null") {
			Statement stmt = DBConnectionServlet.getStatement(con);
			rowUpdated += stmt.executeUpdate("UPDATE s_user SET" + sql_emailupdate + " WHERE user_id = '" + Id + "'");
			stmt.close();
		}

		return rowUpdated;
	}
	
	public static ArrayList<User> AllUsers(Connection con) throws SQLException, ClassNotFoundException {
		ArrayList<User> users = new ArrayList<User>();

		Statement stmt = DBConnectionServlet.getStatement(con);
		ResultSet res = stmt.executeQuery("SELECT * FROM s_user ORDER BY user_id DESC");

		while (res.next()) {
			User user = new User(Integer.toString(res.getInt("user_id")), res.getString("user_login"),
				res.getString("user_password"), res.getString("user_nickname"), SourceChars(res.getString("user_about")),
				Integer.toString(res.getInt("user_subs_amount")), res.getString("user_role"), res.getString("user_email"));
			users.add(user);
		}
		stmt.close();

		return users;
	}
	
	public static User GetUser(Connection con, String req_id) throws SQLException, ClassNotFoundException {
		User req_user = null;
		Statement stmt = DBConnectionServlet.getStatement(con);
			
		ResultSet res = stmt.executeQuery("SELECT * FROM s_user WHERE user_id = '" + req_id + "'");
			
		if (res.next()) {
			req_user = new User(Integer.toString(res.getInt("user_id")), res.getString("user_login"),
			res.getString("user_password"), res.getString("user_nickname"), SourceChars(res.getString("user_about")),
			Integer.toString(res.getInt("user_subs_amount")), res.getString("user_role"), res.getString("user_email"));
		}
		
		stmt.close();

		return req_user;
	}
	
	public static int DelUser(Connection con, String user_id) throws SQLException, ClassNotFoundException {
		int rows = 0;
		
		Statement stmt = DBConnectionServlet.getStatement(con);
		
		rows = stmt.executeUpdate("DELETE FROM s_user WHERE user_id = '" + user_id + "'");
		stmt.close();
		if(rows > 0) {
			System.out.println("DBToolsServlet - DelUser: Пользователь удален."); }
		else
			System.out.println("DBToolsServlet - DelUser: Возникла ошибка.");
		return rows;
	}
	
	
	
	
	// --РАБОТА С ТЕМАМИ--
	
	public static ArrayList<Topic> AllTopics(Connection con) throws SQLException {
		ArrayList<Topic> topics = new ArrayList<Topic>();

		Statement stmt = DBConnectionServlet.getStatement(con);
		ResultSet res = stmt.executeQuery("SELECT * FROM content_topic ORDER BY topic_id DESC");
			
		while (res.next()) { topics.add(new Topic(res.getString("topic_id"), SourceChars(res.getString("topic_name")), res.getString("topic_author"))); }
			
		stmt.close();

		return topics;
	}
	
	public static ArrayList<String> GetAllTopics(Connection con, String author_nickname) throws SQLException, ClassNotFoundException {
		ArrayList<String> topics = new ArrayList<String>();

		Statement stmt = DBConnectionServlet.getStatement(con);
		
		String authorid = GetUserID(con, author_nickname);
		System.out.println("DBToolsServlet - GetAllTopics: " + authorid + " - " + author_nickname);
		
		ResultSet res = stmt.executeQuery("SELECT topic_name FROM content_topic WHERE topic_author = '" + authorid + "'");
			
		while (res.next()) { topics.add(SourceChars(res.getString(1))); }
			
		stmt.close();

		return topics;
	}
	
	public static String GetTopicID(Connection con, String Topic) throws SQLException {
		Statement stmt = DBConnectionServlet.getStatement(con);
		String ReqTopic = FixChars(Topic);
		ResultSet res = stmt.executeQuery("SELECT * FROM content_topic WHERE topic_name = '" + ReqTopic + "'");
		String ID = null;
		if(res.next()) {
			ID = Integer.toString(res.getInt("topic_id"));
		}
		stmt.close();
		return ID;
	}
	
	public static String GetTopicName(Connection con, String ID) throws SQLException {
		Statement stmt = DBConnectionServlet.getStatement(con);
		ResultSet res = stmt.executeQuery("SELECT * FROM content_topic WHERE topic_id = '" + ID + "'");
		String name = null;
		if(res.next()) {
			name = SourceChars(res.getString("topic_name"));
		}
		stmt.close();
		return name;
	}
	
	public static int AddTopic(Connection con, String topic, String author_nickname) throws SQLException, ClassNotFoundException {
		Statement stmt = DBConnectionServlet.getStatement(con);

		String authorid = GetUserID(con, author_nickname);
		System.out.println("DBToolsServlet - AddTopic: " + authorid + " - " + author_nickname);
		
		int rows = 0;
		String AddTopic = FixChars(topic);
		rows = stmt.executeUpdate("INSERT INTO content_topic (topic_name, topic_author) values ('" + AddTopic + "', '" + authorid + "')");
		
		System.out.println("DBToolsServlet - AddTopic: Была добавлена тема " + topic);
		stmt.close();
		return rows;
	}
	
	public static int EditTopic(Connection con, String Id, String NewName) throws SQLException, ClassNotFoundException {
		String sql_nameupdate = " topic_name = '" + FixChars(NewName) + "'";
		int rowUpdated = 0;
		
		System.out.println("DBToolsServlet - EditTopic: Запрос на обновление типа подписки с ID = " + Id + "");
		System.out.println("						  " + sql_nameupdate);
		
		if(NewName != null & NewName != "" & NewName != "null") {
			Statement stmt = DBConnectionServlet.getStatement(con);
			rowUpdated += stmt.executeUpdate("UPDATE content_topic SET" + sql_nameupdate + " WHERE topic_id = '" + Id + "'");
			stmt.close();
		}

		return rowUpdated;
	}
	
	public static int DelTopic(Connection con, String topic_id) throws SQLException, ClassNotFoundException {
		int rows = 0;
		rows += DelPostTopic(con, topic_id);
		
		Statement stmt = DBConnectionServlet.getStatement(con);
		rows += stmt.executeUpdate("DELETE FROM content_topic WHERE topic_id = '" + topic_id + "'");
		stmt.close();
		if(rows > 0) {
			System.out.println("DBToolsServlet - DelTopic: Тема удалена."); }
		else
			System.out.println("DBToolsServlet - DelTopic: Возникла ошибка.");
		return rows;
	}
	
	
	
	
	// --РАБОТА С ПОСТАМИ--
	
	public static int AddPost(Connection con, String author_nickname, String post_heading, String post_topic, String post_content, String post_sub_require) throws SQLException, ClassNotFoundException {
		Statement stmt = DBConnectionServlet.getStatement(con);

		int rows = 0;
		
		String topicid = GetTopicID(con, post_topic);
		System.out.println("DBToolsServlet - AddPost: " + topicid + " - " + post_topic);
		
		String authorid = GetUserID(con, author_nickname);
		System.out.println("DBToolsServlet - AddPost: " + authorid + " - " + author_nickname);
		
		String contentstring = FixChars(post_content);
		String headingstring = FixChars(post_heading);
		
		System.out.println("DBToolsServlet - AddPost: добавляемый контент " + contentstring);
		rows = stmt.executeUpdate("INSERT INTO post (post_author, post_heading, post_content, post_topic, post_sub_require) values ('" + authorid + "', '" + headingstring + "', '" + contentstring + "', '" + topicid + "', '" + post_sub_require + "')");
		stmt.close();
		return rows;
	}
	
	public static ArrayList<Post_u> RecentPosts(Connection con) throws SQLException, ClassNotFoundException {
		ArrayList<Post_u> posts = new ArrayList<Post_u>();
		
		Statement stmt = DBConnectionServlet.getStatement(con);
		
		ResultSet res = stmt.executeQuery("SELECT * FROM post WHERE post_sub_require = '1' ORDER BY timestamp DESC LIMIT 5");

		while (res.next()) {
			String id = Integer.toString(res.getInt("post_id"));
			String author_nickname = GetUserNickname(con, Integer.toString(res.getInt("post_author")));
			
			String content = res.getString("post_content");
			String contentstring = SourceChars(content);
			String heading = SourceChars(res.getString("post_heading"));
			String timestamp = res.getString("timestamp");
			String likes = Integer.toString(res.getInt("post_likes"));
			String topic = GetTopicName(con, res.getString("post_topic"));
			String sub_require = res.getString("post_sub_require");
			Post_u post = new Post_u(id, author_nickname, heading, contentstring, timestamp, likes, topic, sub_require, false);
			posts.add(post);
		}
		stmt.close();

		return posts;
	}
	
	public static ArrayList<Post_u> GetAuthorPosts(Connection con, String author_nickname) throws SQLException, ClassNotFoundException {
		ArrayList<Post_u> posts = new ArrayList<Post_u>();
		
		Statement stmt = DBConnectionServlet.getStatement(con);
		
		String authorid = GetUserID(con, author_nickname);
		System.out.println("DBToolsServlet - AuthorPosts1: " + authorid + " - " + author_nickname);
		
		ResultSet res = stmt.executeQuery("SELECT * FROM post WHERE post_author = '" + authorid + "' ORDER BY timestamp DESC");

		while (res.next()) {
			String id = Integer.toString(res.getInt("post_id"));
			
			String content = res.getString("post_content");
			String contentstring = SourceChars(content);
			String heading = SourceChars(res.getString("post_heading"));
			String timestamp = res.getString("timestamp");
			String likes = Integer.toString(res.getInt("post_likes"));
			String topic = GetTopicName(con, res.getString("post_topic"));
			String sub_require = res.getString("post_sub_require");
			Post_u post = new Post_u(id, author_nickname, heading, contentstring, timestamp, likes, topic, sub_require, false);
			posts.add(post);
		}
		stmt.close();

		return posts;
	}
	
	public static ArrayList<Post_u> GetAuthorPosts(Connection con, String author_nickname, String topic_name) throws SQLException, ClassNotFoundException {
		ArrayList<Post_u> posts = new ArrayList<Post_u>();
		
		Statement stmt = DBConnectionServlet.getStatement(con);
		
		String topicid = GetTopicID(con, topic_name);
		System.out.println("DBToolsServlet - AuthorPosts2: " + topicid + " - " + topic_name);
		
		String authorid = GetUserID(con, author_nickname);
		System.out.println("DBToolsServlet - AuthorPosts2: " + authorid + " - " + author_nickname);
		
		ResultSet res = stmt.executeQuery("SELECT * FROM post WHERE post_author = '" + authorid + "' AND post_topic = '" + topicid + "' ORDER BY timestamp DESC");

		while (res.next()) {
			String id = Integer.toString(res.getInt("post_id"));
			
			String content = res.getString("post_content");
			String contentstring = SourceChars(content);
			String heading = SourceChars(res.getString("post_heading"));
			String timestamp = res.getString("timestamp");
			String likes = Integer.toString(res.getInt("post_likes"));
			String sub_require = res.getString("post_sub_require");
			Post_u post = new Post_u(id, author_nickname, heading, contentstring, timestamp, likes, topic_name, sub_require, false);
			posts.add(post);
		}
		stmt.close();

		return posts;
	}
	
	public static Post_u GetPost(Connection con, String req_postid) throws SQLException, ClassNotFoundException {
		Post_u post = null;
		
		Statement stmt = DBConnectionServlet.getStatement(con);
		
		System.out.println("DBToolsServlet - GetPost: Был запрошен пост с id - " + req_postid);
		ResultSet res = stmt.executeQuery("SELECT * FROM post WHERE post_id = '" + req_postid + "'");

		if (res.next()) {
			String author_nickname = GetUserNickname(con, res.getString("post_author"));
			
			String content = res.getString("post_content");
			String contentstring = SourceChars(content);
			
			String heading = SourceChars(res.getString("post_heading"));
			
			String timestamp = res.getString("timestamp");
			String likes = Integer.toString(res.getInt("post_likes"));
			String topic_name = GetTopicName(con, Integer.toString(res.getInt("post_topic")));
			String sub_require = res.getString("post_sub_require");
			post = new Post_u(req_postid, author_nickname, heading, contentstring, timestamp, likes, topic_name, sub_require, false);
		}
		stmt.close();

		return post;
	}
	
	public static int DelPost(Connection con, String post_id) throws SQLException, ClassNotFoundException {
		int rows = 0;
		
		rows += CancelAllLikes(con, post_id);
		rows += DelAllComments(con, post_id);
		
		Statement stmt = DBConnectionServlet.getStatement(con);
		rows += stmt.executeUpdate("DELETE FROM post WHERE post_id = '" + post_id + "'");
		stmt.close();
		if(rows > 0) {
			System.out.println("DBToolsServlet - DelPost: Пост удалены."); }
		else
			System.out.println("DBToolsServlet - DelPost: Возникла ошибка.");
		return rows;
	}
	
	public static int DelPostTopic(Connection con, String topic_id) throws SQLException, ClassNotFoundException {
		int rows = 0;

		System.out.println("DBToolsServlet - DelPostTopic: Был запрошен пост с id - " + topic_id);
		
		Statement stmt = DBConnectionServlet.getStatement(con);
		ResultSet res = stmt.executeQuery("SELECT * FROM post WHERE post_topic = '" + topic_id + "'");
		if (res.next()) {
			rows += DelPost(con, res.getString("post_id"));
		}
		stmt.close();
		
		if(rows > 0) {
			System.out.println("DBToolsServlet - DelPostTopic: Посты удалены по теме " + topic_id + "(" + GetTopicName(con, topic_id) + ")" + " были удалены."); }
		else
			System.out.println("DBToolsServlet - DelPostTopic: Возникла ошибка.");
		return rows;
	}
	
	public static ArrayList<Post_adm> AllPosts(Connection con) throws SQLException, ClassNotFoundException {
		ArrayList<Post_adm> posts = new ArrayList<Post_adm>();
		
		Statement stmt = DBConnectionServlet.getStatement(con);
		
		ResultSet res = stmt.executeQuery("SELECT * FROM post ORDER BY post_id DESC");

		while (res.next()) {
			String id = Integer.toString(res.getInt("post_id"));
			String author_id = Integer.toString(res.getInt("post_author"));
			
			String content = res.getString("post_content");
			String contentstring = SourceChars(content);
			String heading = SourceChars(res.getString("post_heading"));
			String timestamp = res.getString("timestamp");
			String likes = Integer.toString(res.getInt("post_likes"));
			String topic = res.getString("post_topic");
			String sub_require = res.getString("post_sub_require");
			Post_adm post = new Post_adm(id, author_id, heading, contentstring, timestamp, likes, topic, sub_require);
			posts.add(post);
		}
		stmt.close();

		return posts;
	}
	
	
	
	
	
	// --РАБОТА С ЛАЙКАМИ--
	
	public static int LikePost(Connection con, String postid, String user_nickname) throws SQLException, ClassNotFoundException {
		int rows = 0;
		Like like = LikeCheck(con, postid, user_nickname);
		if(like == null)
		{
			Statement stmt = DBConnectionServlet.getStatement(con);
			
			String userid = GetUserID(con, user_nickname);
			System.out.println("DBToolsServlet - LikePost: " + userid + " - " + user_nickname);
			
			rows = stmt.executeUpdate("INSERT INTO p_like (like_post, like_user) values ('" + postid + "', '" + userid + "')");
			stmt.close();
		}
		else {
			System.out.println("DBToolsServlet - LikePost: Лайк уже поставлен");
		}
		
		return rows;
	}
	
	public static Like LikeCheck(Connection con, String postid, String user_nickname) throws SQLException, ClassNotFoundException {
		Statement stmt = DBConnectionServlet.getStatement(con);

		Like like = null;
		
		String userid = GetUserID(con, user_nickname);
		System.out.println("DBToolsServlet - LikeCheck: Пост - " + postid + ", пользователь - " + user_nickname);
		
		ResultSet res = stmt.executeQuery("SELECT * FROM p_like WHERE like_post = '" + postid + "' AND like_user = '" + userid + "'");
		
		if (res.next()) {
			like = new Like(res.getString("like_post"), user_nickname, res.getString("timestamp"));
			System.out.println("DBToolsServlet - LikeCheck: Пост - " + postid + " - Лайк поставлен");
		}
		else {
			System.out.println("DBToolsServlet - LikeCheck: Пост - " + postid + " - Лайк не поставлен");
		}
		
		stmt.close();
		return like;
	}
	
	public static ArrayList<Post_u> LikeCheck(Connection con, ArrayList<Post_u> posts, String user_nickname) throws SQLException, ClassNotFoundException {
		for(Post_u post : posts) {
			 if(LikeCheck(con, post.getId(), user_nickname) != null)
				 post.setIsLiked(true);
		}
		System.out.println("DBToolsServlet - LikeCheck: Проверка лайков завершена");
		return posts;
	}
	
	public static int CancelLike(Connection con, String postid, String user_nickname) throws SQLException, ClassNotFoundException {
		int rows = 0;
		Like like = LikeCheck(con, postid, user_nickname);
		if(like != null)
		{
			Statement stmt = DBConnectionServlet.getStatement(con);
			
			String userid = GetUserID(con, user_nickname);
			System.out.println("DBToolsServlet - CancelLike: " + userid + " - " + user_nickname);
			
			rows = stmt.executeUpdate("DELETE FROM p_like WHERE like_post = '" + postid + "' AND like_user = '" + userid + "'");
			stmt.close();
		}
		else {
			System.out.println("DBToolsServlet - CancelLike: Лайк не поставлен.");
		}
		
		return rows;
	}

	public static int CancelAllLikes(Connection con, String post_id) throws SQLException, ClassNotFoundException {
		int rows = 0;
		Statement stmt = DBConnectionServlet.getStatement(con);
			
		rows = stmt.executeUpdate("DELETE FROM p_like WHERE like_post = '" + post_id + "'");
		if(rows > 0)
			System.out.println("DBToolsServlet - CancelAllLikes: Для поста с ID - " + post_id + " были удалены все лайки.");
		
		stmt.close();
		
		return rows;
	}
	
	
	
	
	// --РАБОТА С КОММЕНТАРИЯМИ--
	
	public static int AddComment(Connection con, String comment_post, String comment_user, String comment_content) throws SQLException, ClassNotFoundException {
		Statement stmt = DBConnectionServlet.getStatement(con);

		int rows = 0;
		
		System.out.println("DBToolsServlet - AddComment: " + comment_user + " - " + comment_post);
		
		rows = stmt.executeUpdate("INSERT INTO comment (comment_post, comment_user, comment_content) values ('" + comment_post + "', '" + comment_user + "', '" + comment_content + "')");
		stmt.close();
		return rows;
	}
	
	public static ArrayList<Comment> GetPostComments(Connection con, String post_id) throws SQLException, ClassNotFoundException {
		ArrayList<Comment> comments = new ArrayList<Comment>();
		
		Statement stmt = DBConnectionServlet.getStatement(con);
		
		System.out.println("DBToolsServlet - PostComments: Запрашиваемый пост имеет id - " + post_id);
		
		ResultSet res = stmt.executeQuery("SELECT * FROM comment WHERE comment_post = '" + post_id + "' ORDER BY timestamp DESC");

		while (res.next()) {
			String id = Integer.toString(res.getInt("comment_id"));
			String userid = res.getString("comment_user");
			String username = GetUserNickname(con, userid);
			
			String content = res.getString("comment_content");
			String timestamp = res.getString("timestamp");
			Comment comment = new Comment(id, post_id, username, content, timestamp);
			comments.add(comment);
		}
		stmt.close();

		return comments;
	}
	
	public static int DelComment(Connection con, String comment_id) throws SQLException, ClassNotFoundException {
		int rows = 0;
		
		Statement stmt = DBConnectionServlet.getStatement(con);
		
		rows = stmt.executeUpdate("DELETE FROM comment WHERE comment_id = '" + comment_id + "'");
		stmt.close();
		if(rows > 0) {
			System.out.println("DBToolsServlet - DelComment: Комментарий удален."); }
		else
			System.out.println("DBToolsServlet - DelComment: Возникла ошибка.");
		return rows;
	}
	
	public static int DelAllComments(Connection con, String post_id) throws SQLException, ClassNotFoundException {
		int rows = 0;
		
		Statement stmt = DBConnectionServlet.getStatement(con);
		
		rows = stmt.executeUpdate("DELETE FROM comment WHERE comment_post = '" + post_id + "'");
		stmt.close();
		if(rows > 0) {
			System.out.println("DBToolsServlet - DelAllComments: Комментарии удален."); }
		else
			System.out.println("DBToolsServlet - DelAllComments: Возникла ошибка.");
		return rows;
	}
	
	public static ArrayList<Comment> AllComments(Connection con) throws SQLException, ClassNotFoundException {
		ArrayList<Comment> comments = new ArrayList<Comment>();
		
		Statement stmt = DBConnectionServlet.getStatement(con);
		
		ResultSet res = stmt.executeQuery("SELECT * FROM comment ORDER BY timestamp DESC");

		while (res.next()) {
			String id = Integer.toString(res.getInt("comment_id"));
			String postid = res.getString("comment_post");
			String userid = res.getString("comment_user");
			String content = res.getString("comment_content");
			String timestamp = res.getString("timestamp");
			Comment comment = new Comment(id, postid, userid, content, timestamp);
			comments.add(comment);
		}
		stmt.close();

		return comments;
	}
	
	
	// --РАБОТА С ПОДПИСКАМИ--
	
	public static int NewSub(Connection con, String reader_nickname, String author_nickname, String sub_type) throws SQLException, ClassNotFoundException {
		int rows = 0;
		Subscription sub = SubCheck(con, reader_nickname, author_nickname);
		if(sub == null)
		{
			Statement stmt = DBConnectionServlet.getStatement(con);
			
			String readerid = GetUserID(con, reader_nickname);
			System.out.println("DBToolsServlet - NewSub: " + readerid + " - " + reader_nickname);
			
			String authorid = GetUserID(con, author_nickname);
			System.out.println("DBToolsServlet - NewSub: " + authorid + " - " + author_nickname);
			
			rows = stmt.executeUpdate("INSERT INTO subscription (sub_reader_id, sub_author_id, sub_type) values ('" + readerid + "', '" + authorid + "', '" + sub_type + "')");
			stmt.close();
		}
		else {
			System.out.println("DBToolsServlet - NewSub: Подписка уже оформлена");
		}
		
		return rows;
	}
	
	public static Subscription SubCheck(Connection con, String reader_nickname, String author_nickname) throws SQLException, ClassNotFoundException {
		Statement stmt = DBConnectionServlet.getStatement(con);

		Subscription sub = null;
		
		String readerid = GetUserID(con, reader_nickname);
		System.out.println("DBToolsServlet - SubCheck: Читающий - " + readerid + " - " + reader_nickname);
		
		String authorid = GetUserID(con, author_nickname);
		System.out.println("DBToolsServlet - SubCheck: Автор - " + authorid + " - " + author_nickname);
		
		ResultSet res = stmt.executeQuery("SELECT * FROM subscription WHERE sub_reader_id = '" + readerid + "' AND sub_author_id = '" + authorid + "'");
		
		if (res.next()) {
			sub = new Subscription(res.getString("sub_reader_id"), res.getString("sub_author_id"),
					res.getString("timestamp"), GetSubType(con, res.getString("sub_type")));
		}
		else {
			System.out.println("DBToolsServlet - SubCheck: Подписка не оформлена");
		}
		
		stmt.close();
		return sub;
	}
	
	public static int CancelSub(Connection con, String reader_nickname, String author_nickname) throws SQLException, ClassNotFoundException {
		int rows = 0;
		Subscription sub = SubCheck(con, reader_nickname, author_nickname);
		if(sub != null)
		{
			Statement stmt = DBConnectionServlet.getStatement(con);
			
			String readerid = GetUserID(con, reader_nickname);
			System.out.println("DBToolsServlet - CancelSub: " + readerid + " - " + reader_nickname);
			
			String authorid = GetUserID(con, author_nickname);
			System.out.println("DBToolsServlet - CancelSub: " + authorid + " - " + author_nickname);
			
			rows = stmt.executeUpdate("DELETE FROM subscription WHERE sub_reader_id = '" + readerid + "' AND sub_author_id = '" + authorid + "'");
			stmt.close();
		}
		else {
			System.out.println("DBToolsServlet - CancelSub: Подписка не оформлена.");
		}
		
		return rows;
	}
	
	public static int CancelSubType(Connection con, String Id) throws SQLException, ClassNotFoundException {
		int rows = 0;
		Statement stmt = DBConnectionServlet.getStatement(con);
			
		rows = stmt.executeUpdate("DELETE FROM subscription WHERE sub_type = '" + Id + "'");
		stmt.close();
		
		System.out.println("DBToolsServlet - CancelSubType: Были отменены все подписки с ID " + Id);
		return rows;
	}
	
	public static ArrayList<Subscription> GetSubsList(Connection con, String reader_nickname) throws SQLException, ClassNotFoundException {
		ArrayList<Subscription> subslist = new ArrayList<Subscription>();
		
		Statement stmt = DBConnectionServlet.getStatement(con);

		Subscription sub = null;
		
		String readerid = GetUserID(con, reader_nickname);
		System.out.println("DBToolsServlet - GetSubsList: " + readerid + " - " + reader_nickname);
		
		ResultSet res = stmt.executeQuery("SELECT * FROM subscription WHERE sub_reader_id = '" + readerid + "'");
		
		if(res.next()) {
			do {
			sub = new Subscription(GetUserNickname(con, res.getString("sub_reader_id")), GetUserNickname(con, res.getString("sub_author_id")),
					res.getString("timestamp"), GetSubType(con, res.getString("sub_type")));
			subslist.add(sub);
			} while(res.next());
		} else subslist = null;
		
		stmt.close();
		return subslist;
	}
	
	public static ArrayList<Subscription_adm> AllSubs(Connection con) throws SQLException, ClassNotFoundException {
		ArrayList<Subscription_adm> subslist = new ArrayList<Subscription_adm>();
		
		Statement stmt = DBConnectionServlet.getStatement(con);

		Subscription_adm sub = null;
		
		ResultSet res = stmt.executeQuery("SELECT * FROM subscription ORDER BY timestamp DESC");
		
		if(res.next()) {
			do {
			sub = new Subscription_adm(res.getString("sub_reader_id"), res.getString("sub_author_id"),
					res.getString("timestamp"), res.getString("sub_type"));
			subslist.add(sub);
			} while(res.next());
		} else subslist = null;
		
		stmt.close();
		return subslist;
	}
	
	
	
	
	// --РАБОТА С ТИПАМИ ПОДПИСКИ--
	
	public static SubType GetSubType(Connection con, String ID) throws SQLException {
		SubType subtype = null;
		
		Statement stmt = DBConnectionServlet.getStatement(con);
		ResultSet res = stmt.executeQuery("SELECT * FROM sub_type WHERE subtype_id = '" + ID + "'");
		if(res.next()) {
			subtype = new SubType(res.getString("subtype_id"), SourceChars(res.getString("subtype_name")),
					res.getString("subtype_author_id"), SourceChars(res.getString("subtype_description")), res.getString("subtype_price"));
		}
		stmt.close();
		return subtype;
	}
	
	public static ArrayList<SubType> GetSubTypes(Connection con, String author_id) throws SQLException {
		ArrayList<SubType> subtypes = new ArrayList<SubType>();
		
		Statement stmt = DBConnectionServlet.getStatement(con);
		
		System.out.println("Запрос на типы подписок автора с ID " + author_id);
		
		ResultSet res = stmt.executeQuery("SELECT * FROM sub_type WHERE subtype_author_id = '" + author_id + "' ORDER BY subtype_id");
		while(res.next()) {
			SubType subtype = new SubType(res.getString("subtype_id"), SourceChars(res.getString("subtype_name")),
						res.getString("subtype_author_id"), SourceChars(res.getString("subtype_description")), res.getString("subtype_price"));
			subtypes.add(subtype);
		}
		stmt.close();
		return subtypes;
	}
	
	public static ArrayList<SubType> AllSubTypes(Connection con) throws SQLException {
		ArrayList<SubType> subtypes = new ArrayList<SubType>();
		
		Statement stmt = DBConnectionServlet.getStatement(con);
		ResultSet res = stmt.executeQuery("SELECT * FROM sub_type ORDER BY subtype_id DESC");
		while(res.next()) {
			SubType subtype = new SubType(res.getString("subtype_id"), SourceChars(res.getString("subtype_name")),
						res.getString("subtype_author_id"), SourceChars(res.getString("subtype_description")), res.getString("subtype_price"));
			subtypes.add(subtype);
		}
		stmt.close();
		return subtypes;
	}
	
	public static int AddSubType(Connection con, String subtype_name, String author, String description, String price) throws SQLException, ClassNotFoundException {
		Statement stmt = DBConnectionServlet.getStatement(con);

		int rows = 0;
		
		System.out.println("DBToolsServlet - AddSubType: " + subtype_name);
		System.out.println("				" + author);
		System.out.println("				" + description);
		System.out.println("				" + price);
		
		rows = stmt.executeUpdate("INSERT INTO sub_type (subtype_name, subtype_author_id, subtype_description, subtype_price) "
				+ "values ('" + FixChars(subtype_name) + "', '" + author + "', '" + FixChars(description) + "', '" + price + "')");
		stmt.close();
		return rows;
	}
	
	public static int EditSubType(Connection con, String Id, String NewName, String NewDesription, String NewPrice ) throws SQLException, ClassNotFoundException {
		String sql_nameupdate = " subtype_name = '" + FixChars(NewName) + "'";
		String sql_desriptionupdate = " subtype_description = '" + FixChars(NewDesription) + "'";
		String sql_priceupdate = " subtype_price = '" + NewPrice + "'";
		int rowUpdated = 0;
		
		System.out.println("DBToolsServlet - EditSubType: Запрос на обновление типа подписки с ID = " + Id + "");
		System.out.println("						  " + sql_nameupdate);
		System.out.println("						  " + sql_desriptionupdate);
		System.out.println("						  " + sql_priceupdate);
		
		if(NewName != null & !NewName.equals("") & !NewName.equals("null")) {
			Statement stmt = DBConnectionServlet.getStatement(con);
			rowUpdated += stmt.executeUpdate("UPDATE sub_type SET" + sql_nameupdate + " WHERE subtype_id = '" + Id + "'");
			stmt.close();
		}
		if(NewDesription != null & !NewDesription.equals("") & !NewDesription.equals("null")) {
			Statement stmt = DBConnectionServlet.getStatement(con);
			rowUpdated += stmt.executeUpdate("UPDATE sub_type SET" + sql_desriptionupdate + " WHERE subtype_id = '" + Id + "'");
			stmt.close();
		}
		if(NewPrice != null & !NewPrice.equals("") & !NewPrice.equals("null")) {
			Statement stmt = DBConnectionServlet.getStatement(con);
			rowUpdated += stmt.executeUpdate("UPDATE sub_type SET" + sql_priceupdate + " WHERE subtype_id = '" + Id + "'");
			stmt.close();
		}

		return rowUpdated;
	}
	
	public static int DelSubType(Connection con, String Id) throws SQLException, ClassNotFoundException {
		int rows = 0;
		
		System.out.println("DBToolsServlet - DelSubType: Происходит удаление типа подписки с ID " + Id + " - " + GetSubType(con, Id).getName());
		
		rows += CancelSubType(con, Id);
		
		Statement stmt = DBConnectionServlet.getStatement(con);
		rows += stmt.executeUpdate("DELETE FROM sub_type WHERE subtype_id = '" + Id + "'");
		stmt.close();
		if(rows > 0) {
			System.out.println("DBToolsServlet - DelSubType: Тип подписки удален."); }
		else
			System.out.println("DBToolsServlet - DelSubType: Возникла ошибка.");
		return rows;
	}
}
