<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.io.*,java.util.*,classes.Author,classes.User,classes.Post_u,classes.Subscription,classes.SubType"%>
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
							ArrayList<String> topics = (ArrayList<String>)request.getAttribute("topics");
		                    User curruser = (User)session.getAttribute("user");
		                    Subscription subscription = null;
		                    ArrayList<SubType> subtypes = (ArrayList<SubType>)request.getAttribute("subtypes_info");
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
			
				<div class="col-md-4">

					<div class="fh5co-sidebox">
						<div><img src='images/user_icon.svg' alt='Svg' class='prof_pic_b'>
		                <p><h2 class='label'><%out.print(author.getNickname());%></h2></p>
			            <%if(author.getAbout() != null)
			           		out.print("<p>" + author.getAbout() + "</p>");
			            out.print("</div>");
			            if(curruser != null && !(curruser.getNickname().equals(author.getNickname()))) {
		                    subscription = (Subscription)request.getAttribute("subscription");
		                    if(subscription != null) {
						        out.print("<p>Ваш тип подписки: " + subscription.getType().getName() + "</p>");
		                    }%>
		                <div class="fh5co-spacer fh5co-spacer-xs"></div>
		                <%if(!subtypes.isEmpty()) { %>
		                <h2>Типы подписок</h2>
		                <%for(SubType subtype : subtypes) {%>
			        	<div class="form-control thumbnail">
	                        <div class="subtype">
	                        	<form action='/subscription' method='get'>
	                        		<input name="subtype_id" id="subtype_id" type="hidden" value="<% out.print(subtype.getId());%>">
			        				<h3 class="h3"><% out.print(subtype.getName());%></h3>
			        				<div class="h4 blockelm text-right"><% out.print(subtype.getPrice());%> (руб/месяц)</div>
			        				<%if(subtype.getDescription() != null && !subtype.getDescription().equals("null") && !subtype.getDescription().equals("")) {%>
			        				<div class="h4text"><% out.print(subtype.getDescription());%></div>
			        				<%}
			        				if(subscription != null) {
			        				if(!subtype.getId().equals(subscription.getType().getId())) {%>
			        				<input type="button" class="btn btn-outline btn-block" value="Изменить тип" onclick='popup()'>
			        				<%} else { %>
			        				<input type="button" class="btn btn-danger btn-block" value="Отписаться" onclick='popup()'>
			        				<% }
			        					}
			        				else {%>
			        				<input type="submit" class="btn btn-primary btn-block" value="Подписаться">
			        				<%}%>
			        			</form>
			        		</div>
			        	</div>
			        	<%} } }%>
					</div>

				</div>
				
				<div class="col-md-8">
					
					<div class="row filtrpanel">
						<form action="#" method="get" id="filter" name="filter">
							<div class="col-md-12">
								<div class="form-group">
									<select class="input-lg" id="topicreq" name="topicreq">
										<option selected disabled hidden="true"><% if(topics.isEmpty() || topics.equals("")) out.print("Список тем пуст"); else {%>Сортировать по теме<%}%></option>
										<%
											for(String topic : topics) { out.print("<option>" + topic + "</option>"); }
										%>
									</select>
									<button class="input-lg btn-outline" onclick="document.getElementById('filter').reset();">Сбросить</button>
								</div>	
							</div>
						</form>	
					</div>
					
					<%
					if(curruser != null)
						if(curruser.getNickname().equals(author.getNickname())){%>
							<div class='row'>
								<a href="/newpost" class='btn blockelm btn-success input-lg'>+ Новый пост</a>
								<div class='fh5co-spacer fh5co-spacer-xs'></div>
								<div class='col-md-12'>
				                <%
									Cookie cookie = null;
							        Cookie[] cookies = null;
							        cookies = request.getCookies();
						            if(cookies != null)
								        for (int i = 0; i < cookies.length; i++) {
								        	cookie = cookies[i];
								            if(cookie.getName().equals("publish_result") && cookie.getValue().equals("1")) {
								            	out.print("<h2 class='text-success'>Пост опубликован</h2>"); } }
							    %>
								</div>
							</div> <%}
                	%>
                	
                	<div class="row">
						<%
						if(request.getAttribute("posts") != null) {
							ArrayList<Post_u> posts = (ArrayList<Post_u>) request.getAttribute("posts");
		                    for(Post_u post : posts) { %>
		                        <div class='row thumbnail'>
		                        	<form action='/post' method='get'>
				                        <input type='hidden' name='postid' value='<% out.print(post.getId()); %>'>
				                        <div class='row bg-primary topic'>
				                        	<h2 class='col-md-12'><b><% out.print(post.getHeading()); %></b></h2>
				                        	<h3 class='col-md-12' style="margin: 0;"><% out.print(post.getTopic()); %></h3>
				                        	<div style="text-align: right;"><% out.print(post.getTimestamp()); %></div>
				                        </div>
				                        <div class='row topic'>
				                        <%
					                    String[] types = post.getSubRequire().split(",");
			                        	int i = 0;
			                        	if(curruser != null && curruser.getNickname().equals(author.getNickname()))
			                        		i++;
			                        	if(i == 0)
				                        	for(String type : types){
						                        System.out.println(type);
						                        if(type.equals("1") || (subscription != null && subscription.getType().getId().equals(type))) {
						                        	i++;
						                        	break;
						                        }
						                    }
					                    if(i > 0)
					                        out.print("<div>" + post.getContent() + "</div>");
					                    else {
					                    	out.print("<div class='postunavailable'><p>Контент доступен только для читателей с подписками: <br>");

				                    		int count = 0;
					                    	for(String type : types){
						                    	for(SubType subtype : subtypes) {
						                    		if(type.equals(subtype.getId())){
						                    			count++;
						                    			if(count == 1)
						                    				out.print("\"<b>" + subtype.getName() + "</b>\"");
						                    			else
						                    				out.print(", \"<b>" + subtype.getName() + "</b>\"");
						                    		}	
						                    	}
					                    	}
					                    	out.print("</p></div>");
					                    }
				                        	
				                        %>
				                        </div>
				                        <div class='row interact-block'>
					                        <div class="col-xs-2">
					                        	<img <% if(post.IsLiked()) out.print("src='images/liked.svg'"); else out.print("src='images/like.svg'");%> alt="Svg" class='img-button' <% if(i > 0) {%>onclick="document.getElementById('likeform<% out.print(post.getId()); %>').submit();<%}%>"><label><% out.print(post.getLikes()); %></label>
					                        </div>
					                        <% if(i > 0) {%>
				                        	<div class="row pull-right"><input type='image' src='images/arrow-right.svg' alt="Svg" class='img-button'></div>
				                        	<%}%>
				                        </div>
			                        </form>
			                        <form id="likeform<% out.print(post.getId()); %>" name="likeform" action="/like"><input type='hidden' name='postid' value='<% out.print(post.getId()); %>'></form>
		                        </div>
		                    <% }
						}
						else
							out.println("<h2>Автор ещё не публиковал постов.</h2>");
                		%>	
					</div>
					
				</div>
				
			</div>
		</div>
	</div>
	
	<div class="notification" id='popup'>
		<div class="container">
			<h3>Вы хотите отменить подписку на <b><% out.print(author.getNickname()); %></b>?</h3>
			<a type='button' class='btn notransition' onclick='popup()'>Закрыть окно</a>
			<a href='/subscription' class='btn btn-warning notransition'>Отменить подписку</a>
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
		
		var topicSelect = filter.topicreq;
	    
	    function changeOption(){
	        document.getElementById('filter').submit();
	    }
	     
	    topicSelect.addEventListener("change", changeOption);
	</script>
	
	</body>
</html>
