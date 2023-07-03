<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.io.*,java.util.*,classes.Author,classes.User,classes.Subscription_adm,classes.Comment,classes.Post_adm,classes.Topic,classes.SubType"%>
<!DOCTYPE html>
	<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
	<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
	<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
	<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Проект А</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
	<link rel="shortcut icon" href="favicon.ico">

	<!-- Google Webfonts -->
	<link href='http://fonts.googleapis.com/css?family=Roboto:400,300,100,500' rel='stylesheet' type='text/css'>
	<link href='https://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
	
	<!-- Animate.css -->
	<link rel="stylesheet" href="css/animate.css">
	<!-- Icomoon Icon Fonts-->
	<link rel="stylesheet" href="css/icomoon.css">
	<!-- Owl Carousel -->
	<link rel="stylesheet" href="css/owl.carousel.min.css">
	<link rel="stylesheet" href="css/owl.theme.default.min.css">
	<!-- Magnific Popup -->
	<link rel="stylesheet" href="css/magnific-popup.css">
	<!-- Theme Style -->
	<link rel="stylesheet" href="css/style.css">
	<!-- Modernizr JS -->
	<script src="js/modernizr-2.6.2.min.js"></script>
	<!-- FOR IE9 below -->
	<!--[if lt IE 9]>
	<script src="js/respond.min.js"></script>
	<![endif]-->

	</head>
	<body>
		
	<header id="fh5co-header" role="banner">
		<nav class="navbar navbar-default" role="navigation">
			<div class="container-fluid">
				<div class="navbar-header"> 
				<!-- Mobile Toggle Menu Button -->
				<a href="#" class="js-fh5co-nav-toggle fh5co-nav-toggle" data-toggle="collapse" data-target="#fh5co-navbar" aria-expanded="false" aria-controls="navbar"><i></i></a>
				<a class="navbar-brand" href="index.jsp">Проект А</a>
				</div>
				<div id="fh5co-navbar" class="navbar-collapse collapse">
					<ul class="nav navbar-nav navbar-right">
						<li><a href="index.jsp"><span>Главная <span class="border"></span></span></a></li>
						<li><a href="/authors"><span>Авторы <span class="border"></span></span></a></li>
		                <li><a href='/logout' class='btn btn-primary btn-nav'>Выход</a></li>
					</ul>
				</div>
			</div>
		</nav>
	</header>
	<!-- END .header -->
	
	<aside class="fh5co-page-heading">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<h3 class="fh5co-page-heading-lead">
						Администрация
						<span class="fh5co-border"></span>
					</h3>
					
				</div>
			</div>
		</div>
	</aside>
	
	
	<div id="fh5co-main">
		<div class="col-md-2">
			<div class="fh5co-sidebox">
				<ul class="fh5co-post">
					<li><form action="/admin" method="get"><input name="table_name" id="table_name" value="s_user" type="hidden"><input type="submit" class="btn btn-info form-control" value="Пользователи"></form></li>
					<li><form action="/admin" method="get"><input name="table_name" id="table_name" value="post" type="hidden"><input type="submit" class="btn btn-info form-control" value="Посты"></form></li>
					<li><form action="/admin" method="get"><input name="table_name" id="table_name" value="content_topic" type="hidden"><input type="submit" class="btn btn-info form-control" value="Темы"></form></li>
					<li><form action="/admin" method="get"><input name="table_name" id="table_name" value="comment" type="hidden"><input type="submit" class="btn btn-info form-control" value="Комментарии"></form></li>
					<li><form action="/admin" method="get"><input name="table_name" id="table_name" value="subscription" type="hidden"><input type="submit" class="btn btn-info form-control" value="Подписки"></form></li>
					<li><form action="/admin" method="get"><input name="table_name" id="table_name" value="sub_type" type="hidden"><input type="submit" class="btn btn-info form-control" value="Типы подписок"></form></li>
				</ul>
			</div>
		</div>
		
		
		<%
		String table_name = (String)session.getAttribute("table_name");
		ArrayList<String> headers = (ArrayList<String>)request.getAttribute("table_headers");
		Cookie cookie = null;
	    Cookie[] cookies = null;
	    cookies = request.getCookies();
	    if(table_name != null) {
	    %>
		<div class="col-md-10">
			<div class="col-md-12 rowcenter-block">
				<% 
	            if(cookies != null)
	            	for (int i = 0; i < cookies.length; i++) {
		        	cookie = cookies[i];
		            if(cookie.getName().equals("admin_page_error") && cookie.getValue().equals("1")){
		            	out.print("<h2 class='text-danger'>Возникла ошибка в ходе выполнения запроса.</h2>");
		            	out.print("<p class='text-danger'>Проверьте правильность вводимых данных или повторите попытку позднее.</p>");
		            	break;
		        	} else if (cookie.getName().equals("admin_page_res")){
		        		String result = cookie.getValue();
		        		if(result.equals("0"))
		        			out.print("<h2 class='text-info'>В базу данных не были занесены изменения</h2>");
		        		else {
		        			out.print("<h2 class='text-success'>В базу данных были внесены изменения.</h2>");
			        		out.print("<p class='text-success'>Было затронуто строк: " + result + "</p>");
		        		}
		        		break;
		        	}
		        } %>
				<div class="scroll-table scroll_vartical">
				<table class="table table-hover">
					<!-- column headers -->
					<thead>
						<tr class="h5">
						<%if(headers != null) {
			                for(String column : headers) { %>
			                	<th><%out.print(column); %></th>
			            	<%}
						}%>
						</tr>
					</thead>
					
		            <!-- column data -->
		            <tbody class="scroll-table-body" id="data">
					<%if(request.getAttribute("users_list") != null) {
						ArrayList<User> users = (ArrayList<User>)request.getAttribute("users_list");
		                for(User user : users) { %>
		                	<tr>
			                	<td data-field="user_id"><%out.print(user.getId()); %></td>
			                	<td data-field="user_login"><%out.print(user.getLogin()); %></td>
			                	<td data-field="user_password"><%out.print(user.getPassword()); %></td>
			                	<td data-field="user_nickname"><%out.print(user.getNickname()); %></td>
			                	<td data-field="user_about"><%out.print(user.getAbout()); %></td>
			                	<td data-field="user_subs_amount"><%out.print(user.getSubsAmount()); %></td>
			                	<td data-field="user_role"><%out.print(user.getRole()); %></td>
			                	<td data-field="user_email"><%out.print(user.getEMail()); %></td>
							</tr>
		            <%} } else if(request.getAttribute("posts_list") != null) {
		            	ArrayList<Post_adm> posts = (ArrayList<Post_adm>) request.getAttribute("posts_list");
						System.out.println("Принимаю посты");
		            	for(Post_adm post : posts) { 
							System.out.println("Вот что я нашел" + post.getAuthor() + " " + post.getContent() + " " + post.getId());%>
                        	<tr>
			                	<td data-field="post_author"><%out.print(post.getAuthor()); %></td>
			                	<td data-field="post_content"><xmp class="scroll_horizontal"><%out.print(post.getContent()); %></xmp></td>
			                	<td data-field="timestamp"><%out.print(post.getTimestamp()); %></td>
			                	<td data-field="post_likes"><%out.print(post.getLikes()); %></td>
			                	<td data-field="post_id"><%out.print(post.getId()); %></td>
			                	<td data-field="post_topic"><%out.print(post.getTopic()); %></td>
			                	<td data-field="post_sub_require"><%out.print(post.getSubRequire()); %></td>
			                	<td data-field="post_sub_require"><%out.print(post.getHeading()); %></td>
							</tr>
                    <% } } else if(request.getAttribute("comments_list") != null) {
		            	ArrayList<Comment> comments = (ArrayList<Comment>) request.getAttribute("comments_list");
		            	for(Comment comment : comments) { %>
                        	<tr>
			                	<td data-field="comment_id"><%out.print(comment.getId()); %></td>
			                	<td data-field="comment_post"><%out.print(comment.getPostId()); %></td>
			                	<td data-field="comment_user"><%out.print(comment.getUsername()); %></td>
			                	<td data-field="comment_content"><%out.print(comment.getContent()); %></td>
			                	<td data-field="timestamp"><%out.print(comment.getTimestamp()); %></td>
							</tr>
                    <% } } else if(request.getAttribute("subs_list") != null) {
		            	ArrayList<Subscription_adm> subs = (ArrayList<Subscription_adm>) request.getAttribute("subs_list");
		            	for(Subscription_adm sub : subs) { %>
                        	<tr>
			                	<td data-field="sub_reader_id"><%out.print(sub.getReader()); %></td>
			                	<td data-field="sub_author_id"><%out.print(sub.getAuthor()); %></td>
			                	<td data-field="timestamp"><%out.print(sub.getTimestamp()); %></td>
			                	<td data-field="sub_type"><%out.print(sub.getType()); %></td>
							</tr>
                    <% } } else if(request.getAttribute("sub_types_list") != null) {
		            	ArrayList<SubType> subtypes = (ArrayList<SubType>) request.getAttribute("sub_types_list");
		            	for(SubType subtype : subtypes) { %>
                        	<tr>
			                	<td data-field="subtype_id"><%out.print(subtype.getId()); %></td>
			                	<td data-field="subtype_name"><%out.print(subtype.getName()); %></td>
			                	<td data-field="subtype_author_id"><%out.print(subtype.getAuthor()); %></td>
			                	<td data-field="subtype_description"><%out.print(subtype.getDescription()); %></td>
			                	<td data-field="subtype_price"><%out.print(subtype.getPrice()); %></td>
							</tr>
                    <% } } else if(request.getAttribute("topics_list") != null) {
		            	ArrayList<Topic> topics = (ArrayList<Topic>) request.getAttribute("topics_list");
		            	for(Topic topic : topics) { %>
                        	<tr>
			                	<td data-field="topic_id"><%out.print(topic.getId()); %></td>
			                	<td data-field="topic_name"><%out.print(topic.getName()); %></td>
			                	<td data-field="topic_author"><%out.print(topic.getAuthor()); %></td>
							</tr>
                    <% } }%>
					</tbody>
		        </table>
		        </div>
		        <div class="row">
					<form action="#" method="post" id="DBdata"  class="form-horizontal">
		        	<div class="col-xs-10">
					<input name="table_name" id="table_name" value="<%out.print(table_name); %>" type="hidden">
					<%if(headers != null) {
			            for(String column : headers) { 
			            if(column.equals("user_about")) {%>
			            <div class="col-xs-12">
					       	<label><%out.print(column); %></label>
					       	<textarea name="user_about" id="user_about" class="form-control input-lg"></textarea>
				    	</div>
			            <%} else if (column.equals("post_content")) { %>
			            <div class="col-xs-12">
					       	<label><%out.print(column); %></label>
					       	<textarea name="post_content" id="post_content" class="form-control input-lg"></textarea>
				    	</div>
			            <%} else if (column.equals("user_role")) { %> 
			            <div class="col-xs-6">
						    <label><%out.print(column); %></label>
						    <select name="user_role" id="user_role" class="form-control input-lg">
						    	<option selected disabled hidden="true"></option>
						        <option value="user">Читатель</option>
						        <option value="author">Автор</option>
						        <option value="admin">Админ</option>
						    </select>
					    </div>
			            <%} else if (column.equals("sub_type")) { %> 
			            <div class="col-xs-6">
						    <label><%out.print(column); %></label>
						    <select name="sub_type" id="sub_type" class="form-control input-lg">
						    	<option selected disabled hidden="true"></option>
						    	<%
						    		ArrayList<SubType> types = (ArrayList<SubType>)request.getAttribute("subtypes_list");
									for(SubType type : types) { out.print("<option value='" + type.getId() + "'>" + type.getName() + "</option>"); }
								%>
						    </select>
					    </div>
			            <%} else if (column.equals("post_topic")) { %> 
			            <div class="col-xs-6">
						    <label><%out.print(column); %></label>
						    <select name="post_topic" id="post_topic" class="form-control input-lg">
						    	<option selected disabled hidden="true"></option>
						    	<%
						    		ArrayList<Topic> topics = (ArrayList<Topic>)request.getAttribute("post_topics_list");
									for(Topic topic : topics) { out.print("<option value='" + topic.getId() + "'>" + topic.getName() + "</option>"); }
								%>
						    </select>
					    </div>
			            <%} else { %>
			            <div class="col-xs-6">
					       	<label><%out.print(column); %></label>
					      	<input name="<%out.print(column); %>" id="<%out.print(column); %>" type="text" class="form-control input-lg" <%if(column.contains("_id") || column.contains("_likes") || column.contains("_subs")) out.print("readonly");%>>
					    </div>
			            <%}
			            }
					}%>
						<div class="fh5co-spacer fh5co-spacer-sm"></div>
						<div class="col-xs-12">
							<input type="button" class="btn-outline form-control" value="Сброс" onclick="document.getElementById('DBdata').reset(); $('#data tr').removeClass('selectedrow');">
						</div>
				    </div>
				    
				    <div class="col-xs-2">
				    	<label>Управление выбранным</label>
				    	<input name="req_method" id="req_method" type="hidden">
				    	
				    	<% if(!table_name.equals("post") && !table_name.equals("comment") && !table_name.equals("subscription")) {
				    	if(!table_name.equals("sub_type") && !table_name.equals("content_topic")) {%>
				    	<input type="button" id="addbtn" class="btn-outline form-control" value="Добавить" onclick="addEntry()" disabled>
					    <small>Введите в пустые поля формы значения </small>
					    <div class="fh5co-spacer fh5co-spacer-sm"></div>
					    <%}%>
				    	
					    <input type="button" id="editbtn" class="btn-outline form-control" value="Изменить" onclick="editEntry()" disabled>
					    <small>Введите в нужные поля формы значения которых нужно изменить и нажмите "Изменить"</small>
					    
					    <div class="fh5co-spacer fh5co-spacer-sm"></div>
					    <%}%>
					    
						<input type="button" id="deletebtn" class="btn-danger form-control" value="Удалить" onclick="deleteEntry()" disabled>
						<small>Удаляет выбранную запись из базы данных</small>
				    </div>
				  </form>
				</div>
		        
			</div>
		</div>
		<%}%>
	</div>
	
	<div class="fh5co-spacer fh5co-spacer-lg"></div>


	<!-- jQuery -->
	<script src="js/jquery.min.js"></script>
	<!-- jQuery Easing -->
	<script src="js/jquery.easing.1.3.js"></script>
	<!-- Bootstrap -->
	<script src="js/bootstrap.min.js"></script>
	<!-- Owl carousel -->
	<script src="js/owl.carousel.min.js"></script>
	<!-- Waypoints -->
	<script src="js/jquery.waypoints.min.js"></script>
	<!-- Magnific Popup -->
	<script src="js/jquery.magnific-popup.min.js"></script>
	<!-- Main JS -->
	<script src="js/main.js"></script>
	
	<script type="text/javascript">
		function popup() {
			el = document.getElementById("popup");
			el.style.visibility = (el.style.visibility == "visible") ? "hidden" : "visible";
		}
		$("#data").on('click', "tr", function(){
			var selected = $(this).hasClass("selectedrow");
		    $("#data tr").removeClass("selectedrow");
		    if(!selected){
		    	$(this).addClass("selectedrow");

		    	$(this).find("td").each(function(){
					var f = $(this).data('field');
					var v = $(this).data('value');
					
					$("#" + f).val( v == undefined ? $(this).text() : v);
				});
		    	if(document.getElementById('user_role') != null) {
			    	if(document.getElementById('user_role').value == "admin"){
				    	document.getElementById('addbtn').disabled = true;
				    	document.getElementById('editbtn').disabled = true;
			    		document.getElementById('deletebtn').disabled = true;
			    	}
			    	else {
			    		document.getElementById('addbtn').disabled = false;
				    	document.getElementById('editbtn').disabled = false;
				    	document.getElementById('deletebtn').disabled = false;
			    	}
		    	}
		    	else {
		    		if(document.getElementById('addbtn') != null && document.getElementById('editbtn') != null) {
		    			document.getElementById('addbtn').disabled = false;
				    	document.getElementById('editbtn').disabled = false;
		    		}
			    	document.getElementById('deletebtn').disabled = false;
		    	}
		    }
		    else {
		    	document.getElementById('DBdata').reset();
		    	if(document.getElementById('addbtn') != null && document.getElementById('editbtn') != null) {
	    			document.getElementById('addbtn').disabled = true;
			    	document.getElementById('editbtn').disabled = true;
	    		}
		    	document.getElementById('deletebtn').disabled = true;
		    }
			
		});
		function addEntry() {
			document.getElementById("req_method").value = "add";
			document.getElementById("DBdata").submit();
		}
		function editEntry() {
			document.getElementById("req_method").value = "edit";
			document.getElementById("DBdata").submit();
		}
		function deleteEntry() {
			document.getElementById("req_method").value = "delete";
			document.getElementById("DBdata").submit();
		}
		
	</script>
	
	</body>
</html>
