<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.io.*,java.util.*,classes.Author,classes.User,classes.Post_u,classes.Subscription,classes.Comment"%>
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
						<li class="active"><a href="/authors"><span>Авторы <span class="border"></span></span></a></li>
						<%
						Author author = (Author)request.getAttribute("author_info");
						Post_u post = (Post_u)request.getAttribute("post_info");
						User curruser = (User)session.getAttribute("user");
						if(curruser != null) {
							out.print("<li><a href='/account' class='btn btn-primary btn-nav'>Личный кабинет</a></li>"); }
						else {
							out.print("<li><a href='/signin' class='btn btn-primary btn-nav'>Вход</a></li>");
							out.print("<li><a href='/signup' class='btn btn-outline btn-nav'>Регистрация</a></li>"); }
						%>
					</ul>
				</div>
			</div>
		</nav>
	</header>
	<!-- END .header -->
	
	<aside class="fh5co-page-heading"> </aside>
	
	<div id="fh5co-main">
		
		<div class="container">
			<div class="row">
			
				<div class="col-md-8">
					
					<div class="row filtrpanel">
						<%
						if(post != null) {
							%>
		                        <div class='row thumbnail'>
				                    <div class='row bg-primary topic'>
				                    	<h2 class='col-md-12'><b><% out.print(post.getHeading()); %></b></h2>
				                        <h3 class='col-md-12' style="margin: 0;"><% out.print(post.getTopic()); %></h3>
				                        <div style="text-align: right;"><% out.print(post.getTimestamp()); %></div>
				                    </div>
				                    <div class='row topic'>
				                        <p><% out.print(post.getContent()); %></p>
				                    </div>
				                    <div class='row interact-block'>
				                        <div>
					                        <div class="col-xs-2">
					                        	<img <% if(post.IsLiked()) out.print("src='images/liked.svg'"); else out.print("src='images/like.svg'");%> alt="Svg" class='img-button' onclick="document.getElementById('likeform<% out.print(post.getId()); %>').submit();"><label><% out.print(post.getLikes()); %></label>
					                        </div>
					                    </div>
				                    </div>
				                    <form id="likeform<% out.print(post.getId()); %>" name="likeform" action="/like"><input type='hidden' name='postid' value='<% out.print(post.getId()); %>'></form>
		                        </div>
		                    <%
						}
                		%>	
					</div>
					
					<div class='row'>
						<h1>Комментарии</h1>
						<div>
						<%
						if(curruser != null) {%>
							<form action="#" method="post">
								<div class="form-group">
								<label for="Content" class="sr-only">Содержание</label>
								<textarea placeholder="Введите комментарий" id="content" name="content" class="form-control input-lg blockelm" rows="3" required></textarea>
		                        <input type='hidden' name='post_id' value='<% out.print(post.getId()); %>'>
								<input type='submit' class='btn blockelm' value='Отправить'>
								</div>
							</form>
						<%}%>
                		</div>
                		<%
						if(request.getAttribute("comments") != null) {
							ArrayList<Comment> comments = (ArrayList<Comment>) request.getAttribute("comments");
		                    for(Comment comment : comments) {
		                        out.print("<div class='row'><form action='' method=''>");
		                        out.print("<img src='images/user_icon.svg' alt='Svg' class='fh5co-align-left img-responsive prof_pic_sm'>");
		                        out.print("<h3 class='inline'>" + comment.getUsername() + "</h3> - " + comment.getTimestamp());
		                        out.print("<p>" + comment.getContent() + "</p></form></div>");
		                    }
						}
						else
							out.print("<h2>Пока что комментариев нет.</h2>");
                		%>
					</div>
                	
					
				</div>
				
				<div class="col-md-4">

					<div class="fh5co-sidebox">
						<%
						out.print("<img src='images/user_icon.svg' alt='Svg' class='prof_pic_b'>");
		                out.print("<h2 class='fh5co-sidebox-lead'>" + author.getNickname() + "</h2>");
			            out.print("<div class='Author'><form action='/author' method='get'>");
			            out.print("<input type='hidden' name='nickname' value='" + author.getNickname() + "'>");
			            out.print("<input type='submit' class='btn' value='На страницу автора'></form></div>");
						%>
					</div>
				</div>
				
			</div>
		</div>
	</div>
	<div class="fh5co-spacer fh5co-spacer-lg"></div>

	<footer id="fh5co-footer">
		
		<div class="container">
			<div class="row">
				<div class="col-md-6 col-sm-6">
					<div class="fh5co-footer-widget">
						<h2 class="fh5co-footer-logo">Проект А</h2>
					</div>
				</div>
			</div>

			<div class="row fh5co-row-padded fh5co-copyright">
				<div class="col-md-5">
					<p><small>&copy; Проект А. Все права защищены.</small></p>
				</div>
			</div>
		</div>

	</footer>


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
	
	</body>
</html>