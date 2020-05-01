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
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Patrick+Hand" />
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  
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
		
		
		<!-- DASHBOARD BODY -->
		<div class="row d-flex justify-content-around">
		<!-- FRIEND'S LIST -->		
			<div class="w-25">
				<div class="card border-0" id="dashBody">
					<div class="card-body border-right">
						<h5 class="card-title " id="friendsList">My Clique</h5>
						<div class="overflow-auto mb-4" style="height: 500px">
							<ul class="list-group list-group-flush">
								<c:forEach var="friend" items="${friends}" >
									<li class="list-group-item mt-2 mb-2" ><a href="/profile/${friend.id}"><c:out value="${friend.name}" /></a></li>
									<hr />
								</c:forEach>
							</ul>
						</div>
						<form action="/addFriend" method="post">
							<div class="form-group">
								<label for="username">Username:</label>
								<input type="text" name="username" class="form-control mb-3" placeholder="Add Friend"/>
								<button class="btn my-2 my-sm-0 btn btn-outline-light allBtns">Add</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		<!-- FRIEND'S LIST END -->
		
		<!-- ALL POSTS -->
			<div class="w-75">
				<div class="card border-0" id="dashBody">
					<div class="card-body d-flex flex-wrap ">
					
						<c:forEach var="post" items="${posts}">
							<div class="card m-3" id="posts">
								<a href="/post/${post.id}"><img src="${post.filePath}" alt="" width="200" height="250" class="postPic mb-2"/></a>
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
						</c:forEach>

					</div>
				</div>
			</div>
		<!-- ALL POSTS END -->
		
		</div>
		<!-- DASHBOARD BODY END -->
		
	</div>
	
	<script>
		$(".heart.fa").click(function() {
		  $(this).toggleClass("fa-heart fa-heart-o");
		});
	</script>
</body>
</html>