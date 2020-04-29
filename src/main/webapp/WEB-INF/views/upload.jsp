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
</head>
<body>
	<div class="container">
		<div class="card mt-5 border-0" style="width: 25rem;">
            <div class="card-body">
              <h2 class="mb-5">Create a new course</h2>
                <form method="POST" action="uploadFile" enctype="multipart/form-data">
                
                    <div class="form-group row d-flex justify-content-between">
                    
                    	
             
                        <div class="col-sm-8">
                        	File to upload: <input type="file" name="file"><br /> 
                       	</div>
                                   
                    </div>
                    
                    <div class="form-group row d-flex justify-content-between">
                    
                        <div class="col-sm-8">
                        	Description: <textarea rows="3" name="description"></textarea><br /> <br /> 
                        </div>
                        
                    </div>
                     <div class="form-group row d-flex justify-content-between">
                    
                        <div class="col-sm-8">
                        	Tags: <input type="text" name="tags"><br /> <br /> 
                        </div>
                        
                    </div>
                    
                   
                    
                    <button type="submit" class="btn btn-secondary mt-5">Post!</button>
                    
                </form>
            </div>
        </div>			
			
		
	</div>
</body>
</html>