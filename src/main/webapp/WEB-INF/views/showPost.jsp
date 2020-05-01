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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Tangerine" />
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Pacifico" />
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Gloria+Hallelujah" />
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Patrick+Hand" />
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Patrick+Hand" />
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
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
	<!-- NAVBAR END-->
	
		<div class="d-flex justify-content-around mt-5">
			<div class="w-50">
				<h3 id="userPostFont" class="text-center">Poster Board</h3>	
				<div class="card border-0" >
					<div class="card-body d-flex justify-content-center ">
					
					<!--POST INFO -->


						<div class="card rounded-lg" id="posts">
							<img src="${posts.filePath}" width="400" height="400" class="mb-4 ">
							<c:choose>
			            		<c:when test="${  posts.usersliked.contains( user ) }">
			            			<form action="/show/likePost/${posts.id}" method="post">
										<div class="text-left">
											<button class="border-0"><i class="material-icons" id="like">favorite</i></button>
											
										</div>
									</form>
								</c:when>
								<c:otherwise>
									<form action="/show/likePost/${posts.id}" method="post">
										<div class="text-left">
											<button class="border-0"><i class="material-icons" id="like">favorite_border</i></button>
											
										</div>
									</form>
									
								</c:otherwise>
							</c:choose>
							<div class="d-flex flex-wrap">
								<c:forEach var="tag" items="${posts.tags}">
									<h6>#<c:out value="${tag.tag}"/></h6>
								</c:forEach>
							</div>
							<h5 class="postDesc text-left"><c:out value="${posts.description }" /></h5>
						</div>

					</div>
					<!--POST INFO-->
				</div>
			</div>
			
			<div class="w-50">
				<h3 id="userPostFont" class="text-center">Comments</h3>	
				<div class="card border-0" id="dashBody">
					<div class="card-body d-flex justify-content-center ">
					
					<!--POST INFO -->
						<div class="card rounded-lg border-0" id="posts"style="width: 35rem;">
							<div class="overflow-auto mb-4" style="height: 320px">
			            		<c:forEach items="${posts.comments}" var="comment">
			            			<p class="p-3">
			            			<c:out value="${comment.user.name}"/>
			            			: <c:out value="${comment.comment}"/>
			            			</p>
			            			<hr class="dotted"/>
			            		</c:forEach>
			            	</div>
			            	
			            	<form action="/postComment/<c:out value='${posts.id}'/>" method="post">
			            		<div class="form-group">
 									<textarea name="comment" class="form-control" placeholder="Type Comment"rows="3"></textarea>
			            		</div>
			            		<div class="d-flex justify-content-end">
			            			<input type="submit" class=" btn my-2 my-sm-0 btn btn-outline-light allBtns" value="Submit"/>
			            		</div>
			            	</form>
						</div>
					</div>
					<!--POST INFO-->
				</div>
			</div>
		</div>
	
	</div>
</body>
</html>