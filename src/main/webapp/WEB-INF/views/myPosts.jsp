<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page isErrorPage="true"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
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
	
	<script src="https://unpkg.com/swiper/js/swiper.js"></script>
	<script src="https://unpkg.com/swiper/js/swiper.min.js"></script>
</head>
<body>
	<div class="container">
	
	<!-- NAVBAR -->
		<nav class="navbar navbar-expand-lg mynav w-100 d-flex justify-content-between">
			<div class="" id="navbarSupportedContent">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item active">
						<a class="nav-link navFont m-2" href="/profile">Profile <span class="sr-only">(current)</span></a>
					</li>
					<li class="nav-item active">
						<a class="nav-link navFont m-2" href="/new">Post <span class="sr-only">(current)</span></a>
					</li>
					<li class="nav-item active">
						<a class="nav-link navFont m-2" href="/logout">Logout <span class="sr-only">(current)</span></a>
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
		<!-- NAVBAR END -->
		
		
		<!-- DASHBOARD BODY -->
		<div class="">
		<img src="file:///Untitled/private/var/folders/gt/22k5_8k16p5gp9ssmym49rsr0000gn/T/tomcat.7685507392122744966.8081/tmpFiles/1" alt="test Image"/>
		<!-- FRIEND'S LIST -->		
			<!-- <div class="w-25">
				<div class="card border-0" id="dashBody1">
					<div class="card-body border-right">
						<h5 class="card-title " id="friendsList">My Clique</h5>
						<ul class="list-group list-group-flush">
							<li class="list-group-item">Friend #1</li>
							<li class="list-group-item">Friend #2</li>
							<li class="list-group-item">Friend #3</li>
						</ul>
					</div>
				</div>
			</div> -->
		<!-- FRIEND'S LIST END -->
		
			<div class="d-flex justify-content-center mb-5">
				<div class="card w-50 border-0">
					<h1 id="userPostFont" class="mb-3">Create Post:</h1>
					
					<form method="post" action="/newPost" enctype="multipart/form-data" >
						<div class="form-group">
							<label for="file">Image/File:</label>
							<input type="file" name="file">
						</div>
						<div class="form-group">
							<label for="description">Caption:</label>
							<textarea class="form-control" rows="3" name="description"></textarea>
						</div>      
						
						<div class="form-group">
							<label for="tags">HashTags:</label>
							<input type="text" name="tags" placeholder="Seperate by commas">
						</div>    
	                    <div class="text-right">
	                    	<button type="submit" class="btn my-2 my-sm-0 btn btn-outline-light allBtns" >Post!</button>
	                    </div>
                    </form>
					
				</div>
			</div>
			
			<div class="card border-0">
				<h4 id="userPostFont" class="text-center">Poster Board</h4>	
				<div class="card-body d-flex justify-content-center ">		
					<div class="swiper-container">
					
						<c:forEach var="post" items="${posts}">
							<div class="swiper-wrapper text-center">
								<div class="card rounded-lg">
									<img src="${post.filePath}" width="400" height="400" class="mb-4">
									<h5><c:out value="${post.description }" /></h5>
								<div class="flex-wrap">
									<c:forEach var="post" items="${posts}">
										<p>#<c:out value="${post.tags}" />, </p>
									</c:forEach>
								</div>
								</div>
							</div>
						</c:forEach>
					<!-- Add Pagination -->
						<div class="swiper-pagination mt-5"></div>
					</div>
				</div>
			
			</div>
		  <!-- Initialize Swiper -->
			<script>

			
		    var swiper = new Swiper('.swiper-container', {
		      slidesPerView: 1,
		      spaceBetween: 10,
		      // init: false,
		      pagination: {
		        el: '.swiper-pagination',
		        clickable: true,
		      },
		      breakpoints: {
		        '@0.00': {
		          slidesPerView: 1,
		          spaceBetween: 10,
		        },
		        '@0.75': {
		          slidesPerView: 2,
		          spaceBetween: 20,
		        },
		        '@1.00': {
		          slidesPerView: 3,
		          spaceBetween: 40,
		        },
		        '@1.50': {
		          slidesPerView: 4,
		          spaceBetween: 50,
		        },
		      }
		    });
			</script>
		
		</div>
		<!-- DASHBOARD BODY END -->
		
	</div>
</body>
</html>