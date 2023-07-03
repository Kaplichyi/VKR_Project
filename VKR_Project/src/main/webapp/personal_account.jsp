<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.io.*,java.util.*,classes.Author,classes.User,classes.Subscription"%>
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
					<h1 class="fh5co-page-heading-lead">
						Личный кабинет
						<span class="fh5co-border"></span>
					</h1>
					
				</div>
			</div>
		</div>
	</aside>
	
	<div id="fh5co-main">
		
		<div class="container">
			<div class="row">
			
				<div class="col-md-4">

					<div>
						<h3 class="fh5co-sidebox-lead">Подписки</h3>	
						<ul class="row fh5co-post">
							<%
								if(request.getAttribute("subslist") != null) {
									ArrayList<Subscription> subslist = (ArrayList<Subscription>) request.getAttribute("subslist");
				                    for(Subscription sub : subslist) { %>
				                        <li onclick="document.getElementById('<% out.print(sub.getAuthor()); %>form').submit();">
											<div class="form-control point">
											<form action='/author' id="<% out.print(sub.getAuthor()); %>form">
												<div class="fh5co-post-media"><img src="images/user_icon.svg" alt="Svg" class="prof_pic_sm"></div>
												<div class="fh5co-post-blurb">
													<input type="hidden" value="<% out.print(sub.getAuthor()); %>" name="author_nickname" id="author_nickname">
													<h3><% out.print(sub.getAuthor()); %></h3>
													<span class="fh5co-post-meta">Когда оформлена:<br><% out.print(sub.getTimestamp()); %></span>
												</div>
											</form>
											</div>
										</li>
				                    <% }
								}
								else
									out.print("<h2>Ваш список подписок пуст.</h2>");
		                    %>
						</ul>
						
					</div>
				</div>
			
				<div class="col-md-8">
					<%
						Cookie cookie = null;
			            Cookie[] cookies = null;
			            cookies = request.getCookies();
			            for (int i = 0; i < cookies.length; i++) {
			                cookie = cookies[i];
			                if(cookie.getName().equals("upd_result") && cookie.getValue().equals("1")) {
				                	out.print("<h2 class='text-success'>Изменение данных прошло успешно.</h2>"); } }
			        %>
			        
                    <%
	                    User curruser = (User)session.getAttribute("user");
	                    Integer author = 0;
	                    if(curruser.getRole().equals("author")) author = 1;
                    	if(author == 1) { %>
                    		<h2>Возможности автора</h2>
							<a href='/my_author_page' class='btn btn-primary'>Страница автора</a>
							<a href='/my_subtypes' class='btn btn-outline'>Управление типами подписок</a> <%}
					%>
			        
					<h2>Информация о пользователе</h2>
					<%
						
                        out.print("<div><strong>Логин:</strong> " + curruser.getLogin() + "</div>");
                        out.print("<div><strong>Ник:</strong> " + curruser.getNickname() + "</div>");
						if(author == 1) {
							out.print("<div><strong>Роль:</strong> Автор</div>"); }
                        else if (curruser.getRole().equals("user"))
                            out.print("<div><strong>Роль:</strong> Читатель</div>");
                        out.print("<div><strong>Адрес электронной почты:</strong> " + curruser.getEMail() + "</div>");
                    %>
                    <div class="fh5co-spacer fh5co-spacer-xs"></div>
                    
                    
                    <input type="button" class='btn btn-outline' onclick='popup()' value="Изменить личные данные">
                    <%
				    	cookies = request.getCookies();
    	            	if(cookies != null)
					        for (int i = 0; i < cookies.length; i++) {
					        	cookie = cookies[i];
					            if(cookie.getName().equals("account_error") && cookie.getValue().equals("1")){
					            	out.print("<h2 class='text-danger'>Ошибка изменения данных.</h2>");
						            out.print("<p class='text-danger'>Проверьте правильность введенного пароля или повторите попытку позже.</p>");
					            }
					        }
				    %>
                    <div class="row" id='popup'>
						<form action="" method="post" class="reg" name="editform">
							<div class="col-md-12"><h4>В поля формы занесены ваши данные (если они были указаны).<br>Внесите изменения в поля, данные которых вы хотите изменить.</h4></div>
							<div class="fh5co-spacer fh5co-spacer-xs"></div>
							<div class="col-md-12">
									<label for="newnickname">Ник</label>
									<input placeholder="<% out.print(curruser.getNickname()); %>" id="newnickname" name="newnickname" type="text" class="form-control input-lg">
							</div>
							<div class="col-md-12">
									<label for="email">Электронная почта</label>
									<input placeholder="<% out.print(curruser.getEMail()); %>" id="newemail" name="newemail" type="email" class="form-control input-lg" pattern="[A-Za-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$">
							</div>
							<div class="col-md-12">
									<label>Роль</label>
								    <select id="newrole" name="newrole" class="form-control input-lg">
								    	<option value="" selected disabled hidden="true"><%if(curruser.getRole().equals("user")) out.print("Читатель"); else if(curruser.getRole().equals("author")) out.print("Автор");%></option>
								        <option value="user">Читатель</option>
								        <option value="author">Автор</option>
								    </select>
						    </div>
							
							<div class="col-md-12">
									<label for="About">О вас</label>
									<%
									if(curruser.getAbout() == null) {
										out.print("<textarea placeholder='На данный момент у вас нет описания.' id='newabout' name='newabout' class='form-control input-lg blockelm' rows='3'></textarea>"); }
									else {
										out.print("<textarea placeholder='" + curruser.getAbout() + "' id='newabout' name='newabout' class='form-control input-lg blockelm' rows='3'></textarea>"); }
									%>
							</div>
							
							<div class="fh5co-spacer fh5co-spacer-xs"></div>
							<div class="col-md-12">
								<div class="form-group">
									<label for="password">Введите пароль, чтобы подтвердить изменения</label>
									<input placeholder="Пароль" id="password" name="password" type="password" class="form-control input-lg" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}">
								</div>	
							</div>
							<div class="col-md-6">
								<div>
									<input type="submit" class="btn btn-primary" value="Изменить">
								</div>	
							</div>
						</form>	
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
	
	<script>
		function popup() {
			el = document.getElementById("popup");
			el.style.visibility = (el.style.visibility == "visible") ? "hidden" : "visible";
		}
	</script>
	
	</body>
</html>
