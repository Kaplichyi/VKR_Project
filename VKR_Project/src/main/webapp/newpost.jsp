<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.io.*,java.util.*,classes.User,classes.Author,classes.SubType"%>
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

	<script src="https://cdn.tiny.cloud/1/9bjpl24k6f5zyyb5p3097g19ukktwmmiu1mjtt75fqvljeck/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>
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
						Новый пост
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
					            out.print("<div><a href='/author' class='btn btn-outline'>Назад</a></div>");
								%>
								<h3 hidden="true" class="text-danger" id="error">Пост не может быть опубликован без содержания и темы. Убедитесь в корректности вводимых данных.</h3>
					</div>
				</div>
		
				<div class="col-md-8">
					<%
						ArrayList<String> topics = (ArrayList<String>)request.getAttribute("topics");
						Cookie cookie = null;
			            Cookie[] cookies = null;
			            cookies = request.getCookies();
			            if(cookies != null)
				            for (int i = 0; i < cookies.length; i++) {
				                cookie = cookies[i];
				                if(cookie.getName().equals("publish_error") && cookie.getValue().equals("1")){ %>
				                	<h2 class='text-danger'>Произошла ошибка публикации.</h2>
				                	<p class='text-danger'>Проверьте правильность заполнения формы</p>
				            <%} }%>
						<form id="newpost" name="newpost" class="reg" action="/newpost" method="post" id="newpost">
							<div class="form-group">
								<input type="text" placeholder="Заголовок" id="pheading" name="pheading" class="form-control input-lg" pattern="[A-Za-z0-9А-Яа-яЁё ]{4,50}" required>
								<label for="Content" class="sr-only">Содержание</label>
								<textarea placeholder="Содержание поста" id="content" name="content" class="form-control input-lg blockelm" rows="3" required></textarea>
								
								<div class="fh5co-spacer fh5co-spacer-sm"></div>
									
								<div>
									<label for="topic">Тема</label>
									<select class="form-control input-lg blockelm" id="topic" name="topic" required>
										<option selected disabled hidden="true"></option>
										<%
											for(String topic : topics) { out.print("<option>" + topic + "</option>"); }
										%>
										<option value="newtopic"> + Добавить тему</option>
									</select>
									<input type="hidden" placeholder="Впишите название темы" id="new_topic" name="new_topic" class="form-control input-lg" pattern="[A-Za-z0-9А-Яа-яЁё ]{4,20}" required disabled>
								</div>
								
								<%if(request.getAttribute("subtypes_list") != null) { %>
								<div class="fh5co-spacer fh5co-spacer-sm"></div>
								
								<div class="form-control">
									<p><label for="subtype">Пост виден для читателей с типом подписки:</label></p>
								<%
								    ArrayList<SubType> subtypes = (ArrayList<SubType>)request.getAttribute("subtypes_list");
									for(SubType subtype : subtypes) {
										out.print("<div class='checkbox'><input type='checkbox' id='" + subtype.getId() + "' class='button btn' name='subtype_require' value='" + subtype.getId() + "'><label for='" + subtype.getId() + "'>" + subtype.getName() + "</label></div>");
									}
								%>
									<p><small>(если не будет выбран ни один из типов подписки - пост будет доступен для всех)</small></p>
								<%} else {%>
									<p>Ваш список типов подписки пуст - пост будет доступен для всех читателей.</p>
								<%}%>
								</div>
								<input type="button" class='btn blockelm btn-primary' onclick="sendform()" value="Опубликовать">
							</div>
						</form>
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
	
	<script>
		tinymce.init({
	      selector: 'textarea',
	      plugins: 'anchor autolink charmap codesample emoticons image link lists media searchreplace table visualblocks wordcount',
	      toolbar: 'undo redo | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table | align lineheight | numlist bullist indent outdent | emoticons charmap | removeformat',
	    });
	    
	    function sendform() {
	    	e = document.getElementById("content").value = tinyMCE.get('content').getBody();
	    	if(document.getElementById('newpost').checkValidity()){
	    		document.getElementById('newpost').submit();
	    	} else {
	    		document.getElementById('error').hidden = false;
	    		console.log(e);
	    	}
	    		
	    }
	    
	    var topicSelect = newpost.topic;
	    
	    function changeOption(){
	        var selectedOption = topicSelect.options[topicSelect.selectedIndex];
	        if(selectedOption.value == "newtopic") {
	        	document.getElementById('new_topic').type = 'text';
	        	document.getElementById('new_topic').disabled = false;
	        }
	        else {
	        	document.getElementById('new_topic').type = 'hidden';
	        	document.getElementById('new_topic').disabled = true;
	        }
	    }
	     
	    topicSelect.addEventListener("change", changeOption);
  	</script>
	
	</body>
</html>
