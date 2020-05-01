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
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="css/style.css" />
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Tangerine" />
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Pacifico" />
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Gloria+Hallelujah" />
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Varela+Round" />
	<link rel="stylesheet" href="https://unpkg.com/swiper/css/swiper.css">
	<link rel="stylesheet" href="https://unpkg.com/swiper/css/swiper.min.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Patrick+Hand" />
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://unpkg.com/swiper/js/swiper.js"></script>
	<script src="https://unpkg.com/swiper/js/swiper.min.js"></script>
	
</head>
<body>
	<div class="container">
		<!-- NAVBAR -->
		<nav class="navbar navbar-expand-lg mynav w-100 d-flex justify-content-between ">
			<div class="" id="navbarSupportedContent">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item active">
						<a class="nav-link navFont m-2" href="/profile">Profile <span class="sr-only">(current)</span></a>
					</li>
					<li class="nav-item active">
						<a class="nav-link navFont m-2" href="/new">Post <span class="sr-only">(current)</span></a>
					</li>
					<li class="nav-item active">
						<a class="nav-link navFont m-2" href="/dashboard">Dashboard <span class="sr-only">(current)</span></a>
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
				<form action="/searchTags" method="post" class="form-inline my-2 my-lg-0">
					<input class="form-control mr-sm-2"  type="search" name="tags" placeholder="Search Tags" aria-label="Search">
					<button class="btn my-2 my-sm-0 btn btn-outline-light" style="background-color:#6782B4;" type="submit">Search</button>
				</form>
			</div>
			
		</nav>
		<!-- NAVBAR END -->
		
		<!-- PROFILE HEADER -->
		<div class="row d-flex justify-content-around">
		<!-- FRIEND'S LIST -->		
			<div class="w-25">
				<div class="card border-0" id="dashBody1">
					<div class="card-body border-right">
						<div class="text-center mb-5">
							<h5 class="card-title text-center mb-4" id="friendsList"><c:out value="${user.name }" /></h5>
							<img src="${user.filePath}" alt="..." class="rounded-circle" width="200" height="180" id="profilePic">
						</div>
						<div class="list-group list-group-flush">
							<hr />
							<div>
								<h6>Username:</h6>
								<h5><c:out value="${user.userName }" /></h5>
							</div>
							<hr />
							<div>
								<h6>Email:</h6>
								<h5><c:out value="${user.email }" /></h5>
							</div>
							<hr />
							<div>
								<h6>Bio:</h6>
								<h5><c:out value="${user.bio }" /></h5>
							</div>
							<div class="text-center mt-4">
								<form action="/update">
									<button type="submit" class="btn my-2 my-sm-0 btn btn-outline-light allBtns">Update Profile</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		<!-- FRIEND'S LIST END -->
		
		<!-- ALL POSTS -->
			<div class="w-75">
				<h3 id="userPostFont" class="text-center">Poster Board</h3>	
				<div class="card border-0" id="dashBody2">
					<div class="card-body d-flex justify-content-center ">
					
					<!-- USER'S POSTS CAROUSEL -->
							
					<div class="swiper-container">
						<div class="swiper-wrapper mb-5">
						
						<c:forEach var="post" items="${posts}">
							<div class="swiper-slide post-slide">
								<div class="card rounded-lg" id="posts">
									<img src="${post.filePath}" width="360" height="420" class="mb-4 postPic">
									<c:choose>
				            		<c:when test="${  post.usersliked.contains( user ) }">
				            			<form action="/likePost/${post.id}" method="post">
											<div class="text-left">
												<button class="border-0"><i class="material-icons" id="like">favorite</i></button>
												
											</div>
										</form>
									</c:when>
									<c:otherwise>
										<form action="/likePost/${post.id}" method="post">
											<div class="text-left">
												<button class="border-0"><i class="material-icons" id="like">favorite_border</i></button>
												
											</div>
										</form>
										
									</c:otherwise>
								</c:choose>
									<div class="d-flex flex-wrap">
										<c:forEach var="tag" items="${post.tags}">
											<h6>#<c:out value="${tag.tag}"/></h6>
										</c:forEach>
									</div>
									<h5 class="postDesc text-left"><c:out value="${post.description }" /></h5>
								
								</div>
							</div>
						</c:forEach>
							
						</div>
					<!-- Add Pagination -->
						<br />
						<br />
						<div class="swiper-pagination pt-5"></div>
					</div>
					
					<!-- USER'S POSTS CAROUSEL END -->
					</div>
				</div>
		<!-- ALL POSTS END -->
		
			</div>
		<!-- DASHBOARD BODY END -->
		
		</div>
		<!-- PROFILE HEADER END -->
		
	</div>
	
	<script>

	
	
    var swiper = new Swiper('.swiper-container', {
      effect: 'coverflow',
      grabCursor: true,
      centeredSlides: true,
      slidesPerView: 'auto',
      coverflowEffect: {
        rotate: 50,
        stretch: 0,
        depth: 100,
        modifier: 1,
        slideShadows : true,
      },
      pagination: {
        el: '.swiper-pagination',
      },
    });
	</script>
</body>
</html>