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
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Tangerine" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Pacifico" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Gloria+Hallelujah" />
<link rel="stylesheet" href="https://unpkg.com/swiper/css/swiper.css">
<link rel="stylesheet" href="https://unpkg.com/swiper/css/swiper.min.css">
<title>Update User</title>
</head>
<body>
<div class="container">
	<!-- NAVBAR -->
	<nav class="navbar navbar-expand-lg mynav w-100 d-flex justify-content-between ">
		<div class="" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<a class="nav-link navFont m-2" href="#">Profile <span class="sr-only">(current)</span></a>
				</li>
				<li class="nav-item active">
					<a class="nav-link navFont m-2" href="#">Post <span class="sr-only">(current)</span></a>
				</li>
				<li class="nav-item active">
					<a class="nav-link navFont m-2" href="#">Logout <span class="sr-only">(current)</span></a>
				</li>
			</ul>
		</div>
		<div>
			<h3 id="projectTitle">PiClique</h3>
		</div>
		<div>
			<form action="" method="post" class="form-inline my-2 my-lg-0">
				<input class="form-control mr-sm-2"  type="search" placeholder="Search Tags" aria-label="Search">
				<button class="btn my-2 my-sm-0 btn btn-outline-light" style="background-color:#6782B4;" type="submit">Search</button>
			</form>
		</div>
		
	</nav>
	<!-- NAVBAR END-->
	
	<!-- LOGIN -->
	<div class="card; shadow p-3 mb-5" style="width: 30rem; margin: auto">
		<div class="card-body; " style="margin: auto; font-family: Verdana;">
			<h1>Update Profile</h1>
			<form action="/profile/edit" method="post">
			<div class="form-group">
				<p>
				Upload Profile Picture:
				<br>
				<input type="file" class="mt-2"/>
				</p>
				<hr>
				<div class="bio" style="valign: top">
				Bio:
				</div>
				<p>
				<input  type="text" name="bio" />
				</p>	
						
			</div>
			<button type="submit" class="btn btn-primary">Submit</button>
			</form>
			<br>
		</div>
	</div>
	<!-- LOGIN END -->
</div>
</body>
</html>