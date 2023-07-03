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
		                    	out.print("<li><a href='/signin' class='btn btn-primary btn-nav'>Вход</a></li>");
		                    	out.print("<li class='active'><a href='/signup' class='btn btn-outline btn-nav'>Регистрация</a></li>"); }
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
						Регистрация
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
				            if(cookie.getName().equals("reg_error") && cookie.getValue().equals("1")) {
					    		out.print("<h2 class='text-danger'>В процессе регистрации произошла ошибка.</h2>");
					            out.print("<p class='text-danger'>Попробуйте повторить попытку позже.</p>"); } }
			    %>
						<form id="regform" name="regform" action="#" method="post" class="reg">
							<div class="col-md-6">
								<div class="form-group">
									<label for="login" class="sr-only">Login</label>
									<input placeholder="Логин" id="login" name="login" type="text" class="form-control input-lg" pattern="[A-Za-z0-9]{4,}" required>
								</div>	
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label for="nickname" class="sr-only">Nickname</label>
									<input placeholder="Ник" id="nickname" name="nickname" type="text" class="form-control input-lg" pattern="[A-Za-z0-9]{4,12}" required>
								</div>
							</div>
							<div class="col-md-12">
								<div class="form-group">
									<label for="email" class="sr-only">Email</label>
									<input placeholder="Эл.почта" id="email" name="email" type="email" class="form-control input-lg" pattern="[A-Za-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$" required>
								</div>	
							</div>
							<div class="col-md-12">
								<div class="form-group">
									<label for="password" class="sr-only">Password</label>
									<input placeholder="Пароль" id="password" name="password" type="password" class="form-control input-lg" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}" required>
								</div>	
							</div>
							<div class="col-md-12">
								<div class="form-group">
									<label for="r_password" class="sr-only">Repeat password</label>
									<input placeholder="Повторите пароль" id="r_password" type="password" class="form-control input-lg" required>
								</div>	
							</div>
							<div class="col-md-12">
								<div class="checkbox">
									<input id="is_author" name="is_author" type="checkbox" class="button btn">
									<label for="is_author" class="input-lg">Зарегистрироваться как автор</label>
								</div>
								<p class="annotation">* <small>Ваша страница появится в общем списке авторов, а вам предоставится возможность публиковать посты.</small></p>
							</div>
							<div class="col-md-12">
								<p id="capchaerror" class="text-danger" hidden="true">Проверка не пройдена</p>
								<label class="form-group" id="str"></label>
    							<input class="input-sm" type="text" id="capcha" required>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<input type="button" id="submitcapcha" class="btn btn-primary" value="Зарегистрироваться" disabled>
								</div>	
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
	<script type="text/javascript">
		function validate() {
		    if (document.regform.password.value != document.regform.r_password.value) {
		        document.regform.r_password.style.border = "1px solid red";
				document.getElementById("submitcapcha").disabled = true;
		    }
			else {
				document.regform.r_password.style.border = "2px solid #ccc";
				document.getElementById("submitcapcha").disabled = false;
			}
		}
		r_password.addEventListener("input", validate);
		
		let str = document.getElementById("str");
		let btn = document.getElementById("submitcapcha");
		 
		let num1 = Math.ceil(Math.random() * 10);
		let num2 = Math.ceil(Math.random() * 10);
		let res = num1 + num2;
		 
		str.innerHTML = num1 + " + " + num2 + " = ";
		 
		// События нажатия на кнопку
		btn.addEventListener("click", function () {
		    let inputNum = document.getElementById("capcha").value;
		    inputNum = parseInt(inputNum);
		    if (inputNum == (num1 + num2)) {
		        document.getElementById("regform").submit();
		    } else {
		    	document.getElementById("capchaerror").hidden = false;
		    	num1 = Math.ceil(Math.random() * 10);
		    	num2 = Math.ceil(Math.random() * 10);
		    	res = num1 + num2;
		    	str.innerHTML = num1 + " + " + num2 + " = ";
		    }
		});
		
	</script>
</html>
