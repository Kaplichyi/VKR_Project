<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.io.*,java.util.*,classes.Author,classes.User,classes.Post_u"%>
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
	
	<aside class="fh5co-page-heading">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<h1 class="fh5co-page-heading-lead">
						Авторы
						<span class="fh5co-border"></span>
					</h1>
					
				</div>
			</div>
		</div>
	</aside>
	
	<div id="fh5co-main">
		
		<div class="container">
			<div class="row">
				<div class="col-md-8 col-md-push-4">
					<div class="row filtrpanel">
						<form action="#" method="get">
							<div class="col-md-6">
								<div class="form-group">
									<label for="searchreq" class="sr-only">Nickname</label>
									<input placeholder="Ник автора" name="searchreq" id="searchreq" type="text" class="form-control input-lg">
								</div>	
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<input type="submit" class="btn btn-outline" value="Найти">
								</div>	
							</div>
						</form>	
					</div>
					<%
						if(request.getAttribute("authors") != null) {
							ArrayList<Author> authors = (ArrayList<Author>) request.getAttribute("authors");
		                    for(Author author : authors) { %>
		                        <div class='row'>
			                        <form action='#' id="<% out.print(author.getNickname());%>" method='post'>
				                        <input type='hidden' name='nickname' value="<% out.print(author.getNickname());%>">
				                        
				                        <img src='images/user_icon.svg' alt='Svg' class='fh5co-align-left img-responsive prof_pic_m'>
				                        <div class="h2"><a class="label" onclick="document.getElementById('<% out.print(author.getNickname());%>').submit();"><% out.print(author.getNickname());%></a></div>
				                        <%if(author.getAbout() != null && !author.getAbout().equals("")) {
				                        	out.print("<p>" + author.getAbout() + "</p>");
				                        }%>
				                        <label>Подписчиков: <%out.print(author.getSubsAmount());%></label>
			                        </form>
		                        </div>
		                    <%}
						}
						else
							out.print("<h2>На данный момент список авторов пуст.</h2><a href='#'>Подайте заявку, чтобы стать первым!</a>");
                	%>
				</div>

				<div class="col-md-4 col-md-pull-8">

					<div class="fh5co-sidebox">
						<h3 class="fh5co-sidebox-lead">Последние посты</h3>
						<ul class="fh5co-post">
							<%
							if(request.getAttribute("recentpostslist") != null) {
								ArrayList<Post_u> postslist = (ArrayList<Post_u>) request.getAttribute("recentpostslist");
				                for(Post_u post : postslist) { %>
				                	<li onclick="document.getElementById('post<% out.print(post.getAuthor()); %>form').submit();">
										<div class="form-control bg-primary point">
											<form action='/post' id="post<% out.print(post.getAuthor()); %>form">
												<div class="fh5co-post-blurb">
													<input type="hidden" value="<% out.print(post.getId()); %>" name="postid" id="postid">
													<input type="hidden" value="<% out.print(post.getAuthor()); %>" name="author_nickname" id="author_nickname">
													<h3 style="display: inline; word-wrap: break-word;"><% out.print(post.getHeading()); %></h3>
													<label class="h4" style="float: right;"><% out.print(post.getTopic()); %></label>
												</div>
												<div class="fh5co-post-blurb">
													<span class="fh5co-post-meta">Нравится: <% out.print(post.getLikes()); %></span>
												</div>
											</form>
										</div>
									</li>
				                    <% }
								}
								else
									out.print("<h2>Список постов пуст.</h2>");
		                    %>
						</ul>
						
						<h3 class="fh5co-sidebox-lead">Набирающие популярность</h3>
						<ul class="fh5co-post">
							<%
							if(request.getAttribute("populauthorslist") != null) {
								ArrayList<Author> populauthorslist = (ArrayList<Author>)request.getAttribute("populauthorslist");
				                for(Author author : populauthorslist) { %>
				                	<li onclick="document.getElementById('author<% out.print(author.getNickname()); %>form').submit();">
										<div class="form-control point">
											<form action='/author' id="author<% out.print(author.getNickname()); %>form">
												<div class="fh5co-post-media"><img src="images/user_icon.svg" alt="Svg" class="prof_pic_sm"></div>
												<div class="fh5co-post-blurb">
													<input type="hidden" value="<% out.print(author.getNickname()); %>" name="author_nickname" id="author_nickname">
													<h3><% out.print(author.getNickname()); %></h3>
													<span class="fh5co-post-meta">Подписчиков: <% out.print(author.getSubsAmount()); %></span>
													<span class="fh5co-post-meta">Постов: <% out.print(author.getPostsAmount()); %></span>
												</div>
											</form>
										</div>
									</li>
				                    <% }
								}
								else
									out.print("<h2>Список авторов пуст.</h2>");
		                    %>
						</ul>
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
