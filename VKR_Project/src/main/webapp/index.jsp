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
						<li class="active"><a href="index.jsp"><span>Главная <span class="border"></span></span></a></li>
						<li><a href="/authors"><span>Авторы <span class="border"></span></span></a></li>
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
	
	<div id="fh5co-main">
		<!-- Features -->

		<div id="fh5co-features">
			<div class="container">
				<div class="row text-center">
					<div class="col-md-8 col-md-offset-2">
						<h2 class="fh5co-section-lead">Проект А</h2>
						<h3 class="fh5co-section-sub-lead">Веб-платформа по продвижению эксклюзивного авторского контента.</h3>
					</div>
					<div class="fh5co-spacer fh5co-spacer-md"></div>
				</div>
				<div class="row">
					<div class="col-md-6 col-sm-6 fh5co-feature-border">
						<div class="fh5co-feature">
							<div class="fh5co-feature-icon to-animate">
								<i class="icon-megaphone"></i>
							</div>
							<div class="fh5co-feature-text">
								<h3>Контент</h3>
								<p>Делитесь своими идеями и мыслями.</p>
								<p>Просматривайте интересующий вас контент.</p>
							</div>
						</div>
						<div class="fh5co-feature no-border">
							<div class="fh5co-feature-icon to-animate">
								<i class="icon-head"></i>
							</div>
							<div class="fh5co-feature-text">
								<h3>Сообщество</h3>
								<p>Становитесь автором или оказывайте материальную поддержку контент мейкерам.</p>
								<p>От вас зависит дальнейшие новинки и эксклюзивы.</p>
							</div>
						</div>
					</div>
					<div class="col-md-6 col-sm-6">
						<div class="fh5co-feature">
							<div class="fh5co-feature-icon to-animate">
								<i class="icon-message"></i>
							</div>
							<div class="fh5co-feature-text">
								<h3>Комментарии</h3>
								<p>Общайтесь с читателями и получайте обратную связь.</p>
								<p>Комментируйте контент авторов. Ваше мнение может помочь авторам стать лучше.</p>
							</div>
						</div>
						<div class="fh5co-feature no-border">
							<div class="fh5co-feature-icon to-animate">
								<i class="icon-heart"></i>
							</div>
							<div class="fh5co-feature-text">
								<h3>Подписки</h3>
								<p>Следите за новинками понравившихся вам авторов.</p>
								<p>Отслеживайте состояние вашего блога.</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
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

	<div id="cookie_notification">
        <div class="col-md-9">Для улучшения работы сайта и его взаимодействия с пользователями мы используем файлы cookie. Продолжая работу с сайтом, Вы разрешаете использование cookie-файлов. Вы всегда можете отключить файлы cookie в настройках Вашего браузера.</div>
        <button class="btn btn-primary cookie_accept">Принять</button>
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
	<script type="text/javascript">
		function checkCookies(){
		    let cookieDate = localStorage.getItem('cookieDate');
		    let cookieNotification = document.getElementById('cookie_notification');
		    let cookieBtn = cookieNotification.querySelector('.cookie_accept');
	
		    // Если записи про кукисы нет или она просрочена на 1 год, то показываем информацию про кукисы
		    if( !cookieDate || (+cookieDate + 31536000000) < Date.now() ){
		        cookieNotification.classList.add('show');
		    }
	
		    // При клике на кнопку, в локальное хранилище записывается текущая дата в системе UNIX
		    cookieBtn.addEventListener('click', function(){
		        localStorage.setItem( 'cookieDate', Date.now() );
		        cookieNotification.classList.remove('show');
		    })
		}
		checkCookies();
	</script>
	
	</body>
</html>
