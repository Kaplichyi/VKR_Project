<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.io.*,java.util.*,classes.User,classes.Author, classes.SubType"%>
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
							Author author = (Author)request.getAttribute("author_info");
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
				<div class="col-md-12">
					<h4 class="fh5co-page-heading-lead">
						Типы подписки
						<span class="fh5co-border"></span>
					</h4>
					
				</div>
	</aside>
	
	<div id="fh5co-main">
		<div class="container">
			<div class="row">
				<div class="col-md-4">
					<div class="fh5co-sidebox">
					<%
						out.print("<img src='images/user_icon.svg' alt='Svg' class='prof_pic_b'>");
				        out.print("<h2 class='fh5co-sidebox-lead'>" + author.getNickname() + "</h2>");
						out.print("<div><a href='/account' class='btn btn-outline'>Назад</a></div>");
					%>
					</div>
					<h3 hidden="true" class="text-danger" id="error">Новый тип подписки не может быть добавлен. Убедитесь в корректности вводимых данных.</h3>
				</div>
			
				<div class="col-md-8">
						<%
						Cookie cookie = null;
				        Cookie[] cookies = null;
				        cookies = request.getCookies();
			            if(cookies != null)
					        for (int i = 0; i < cookies.length; i++) {
					        	cookie = cookies[i];
					            if(cookie.getName().equals("subtypes_page_error") && cookie.getValue().equals("1")){
					                out.print("<h2 class='text-danger'>Произошла ошибка добавления.</h2>");
					            } else if(cookie.getName().equals("subtypes_result")){
					            	if(cookie.getValue().equals("1")) {
					                	out.print("<h2 class='text-success'>Запрос был успешно выполнен.</h2>");
					            	}
					            	else
					            		out.print("<h2 class='text-danger'>Произошла ошибка при выполнении запроса</h2>");
					            }
					        }
				        if(request.getAttribute("subtypes_info") != null) {
							ArrayList<SubType> subtypes = (ArrayList<SubType>)request.getAttribute("subtypes_info");
				        	out.print("<div>");
				        	out.print("<h2>Ваши типы подписок</h2>");
				        	for(SubType subtype : subtypes) {%>
				        		<div class="form-control thumbnail">
		                        	<form action='/my_subtypes' method='post'>
		                        		<input name="type_id" id="type_id" type="hidden" value="<% out.print(subtype.getId());%>">
				        				<input type="text" name="name" class="h3 input-lg borderless" value="<% out.print(subtype.getName());%>"> -
				        				<input type="text" name="price" class="input-lg borderless" value="<% out.print(subtype.getPrice());%>">
				        				
				        				<% if(subtype.getDescription() != null && !subtype.getDescription().equals("null") && !subtype.getDescription().equals("")) {%>
				        				<textarea name="description" class="input-lg col-md-12 borderless" placeholder="Описание типа подписки"><%out.print(subtype.getDescription());%></textarea>
				        				<%} else { %>
				        				<textarea name="description" class="input-lg col-md-12 borderless" placeholder="Описание отсутствует"></textarea>
				        				<%}%>
				        				
				        				<input name="req_method" id="req_method" type="hidden" value="edit">
				        				<div><input type="submit" class="btn btn-outline btn-block" value="Изменить"></div>
				        			</form>
				        		</div>
				        	<%}
				        	out.print("</div>");
				        }%>
				        
				        
				        <div class="form-group-lg reg">
				        	<h2>Добавить новый</h2>
							<form action="/my_subtypes" method="post" id="newsubtype">
								<div>
									<label>Название подписки</label>
									<input placeholder="Только буквы и пробелы" id="name" name="name" type="text" class="form-control input-lg" pattern="[A-Za-zА-Яа-яЁё ]{3,30}" required>
								</div>
								<div>
									<label>Описание подписки</label>
									<textarea placeholder="(можно оставить незаполненным)" name="description" class="form-control input-lg blockelm" rows="2"></textarea>
								</div>
								<div>
									<label>Цена оформления (руб/месяц)</label>
									<input placeholder="Только цифры" name="price" type="text" class="form-control input-lg" pattern="^[0-9]+$" required>
								</div>
								<input name="req_method" id="req_method" type="hidden" value="add">
								<input type="submit" class='btn blockelm' value="Добавить">
							</form>
						</div>
				</div>
			</div>
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
