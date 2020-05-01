<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true" %>    				
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Tangerine" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Pacifico" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Gloria+Hallelujah" />
<link rel="stylesheet" href="https://unpkg.com/swiper/css/swiper.css">
<link rel="stylesheet" href="https://unpkg.com/swiper/css/swiper.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Patrick+Hand" />
<title>Register</title>
</head>
<body>
<div class="container">
	<!-- NAVBAR -->
	<nav class="navbar navbar-expand-lg mynav w-100 d-flex justify-content-between ">
		<div class="" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<a class="nav-link navFont m-2" href="/register">Profile <span class="sr-only">(current)</span></a>
				</li>
				<li class="nav-item active">
					<a class="nav-link navFont m-2" href="/register">Post <span class="sr-only">(current)</span></a>
				</li>
				<li class="nav-item active">
					<a class="nav-link navFont m-2" href="/login">Login <span class="sr-only">(current)</span></a>
				</li>
			</ul>
		</div>
		<div>
			<h3 id="projectTitle">PicShare</h3>
		</div>
		<div>
			<form action="" method="post" class="form-inline my-2 my-lg-0">
				<input class="form-control mr-sm-2"  type="search" placeholder="Search Tags" aria-label="Search">
				<button class="btn my-2 my-sm-0 btn btn-outline-light" style="background-color:#6782B4;" type="submit">Search</button>
			</form>
		</div>
		
	</nav>
	<!-- NAVBAR END-->

	<!-- REGISTRATION -->
	<div class="card; shadow p-3 mb-5" style="width: 30rem; margin: auto">
		<div class="card-body" style="margin: auto; font-family: Verdana;">
			<h1>Register</h1>
			<form:form action="/register" method="post" modelAttribute="user">
				<div class="form-group">
				<p>
				Name:
				<form:input path="name" class="form-control" />
				</p>
				<p>
				<form:errors path="name" style="color:red"/>
				</p>
				<p>
				User Name:
				<form:input path="userName" class="form-control" />
				</p>
				<p>
				<form:errors path="userName" style="color:red"/>
				</p>
				<p>
				Email:
				<form:input type="email" path="email" class="form-control" />
				</p>
				<p>
				<form:errors path="email" style="color:red" />
				</p>
				<p>
				Password:
				<form:input type ="password" path ="password" class="form-control" />
				</p>
				<p>
				<form:errors path="password" style="color:red" />
				</p>
				<p>
				Password Confirmation:
				<form:input type ="password" path="passwordConfirmation" class="form-control" />
				</p>
				<p>
				<form:errors path="passwordConfirmation" style="color:red" />
				</p>
				</div>
				<button type="submit" class="btn my-2 my-sm-0 btn btn-outline-light allBtns">Register</button>
			</form:form>
			<br>
			<p>Have an account? <a href="/login">Login here</a></p>
		</div>
	</div>
	<!-- REGISTRATION END -->
</div>
</body>
</html>