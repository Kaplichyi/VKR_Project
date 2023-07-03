<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.io.*,java.util.*,classes.User"%>
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
						<%
		                    User curruser = (User)session.getAttribute("user");
		                    if(curruser != null) {
		                        out.print("<li><a href='/account' class='btn btn-primary btn-nav'>Личный кабинет</a></li>"); }
		                    else {
		                    	out.print("<li class='active'><a href='/signin' class='btn btn-primary btn-nav'>Вход</a></li>");
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
						Войти
						<span class="fh5co-border"></span>
					</h1>
					
				</div>
			</div>
		</div>
	</aside>
	
	<div id="fh5co-main">
		<div class="container reg">
			<%
				Cookie cookie = null;
	            Cookie[] cookies = null;
	            cookies = request.getCookies();
	            if(cookies != null)
	            	for (int i = 0; i < cookies.length; i++) {
		                cookie = cookies[i];
		                if(cookie.getName().equals("signin_error") && cookie.getValue().equals("1")){
		                	out.print("<h2 class='text-danger'>Неверно введен логин или пароль.</h2>");
		                }
		                else if(cookie.getName().equals("reg_result") && cookie.getValue().equals("1")) {
			                	out.print("<h2 class='text-success'>Регистрация прошла успешно.</h2>");
			                	out.print("<p class='text-success'>Теперь вы можете войти в свой личный кабинет.</p>"); } }
	        %>
					
			<form action="#" method="post">
				<div class="form-group">
					<label for="login" class="sr-only">Login</label>
					<input placeholder="Логин" id="login" name="login" type="text" class="form-control input-lg" autofocus required>
				</div>	
				<div class="form-group">
					<label for="password" class="sr-only">Password</label>
					<input placeholder="Пароль" id="password" name="password" type="password" class="form-control input-lg" required>
				</div>	
				<div class="form-group">
					<input type="submit" class="btn btn-primary " value="Войти">
				</div>
			</form>	
		
		</div>
	</div>


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
