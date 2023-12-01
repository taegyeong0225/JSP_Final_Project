<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name ="viewport" content="width=device-width", initial-scale="1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    
<link rel="stylesheet" href="css/style.css">
<title>내 정보</title>
</head>
<body>
	<%
	String userID=null;
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}
	User user=new UserDAO().getUser(userID);
	
	%>
	
	<jsp:include page="header.jsp"/>
	
	<div class="container">
		<div class="row justify-content-center">
    		<div class="col-lg-4 gx-lg-4">
				<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="userUpdateAction.jsp">
					<h3 style="text-align:center;">내 정보</h3>
					<div class ="form-group mb-3">
						<input type="text" class="form-control" value=<%=user.getUserID()%> name="userID" maxlength="20">
					</div>
					<div class="form-group mb-3">
						<input type="password" class="form-control" value=<%=user.getUserPassword()%> name="userPassword" maxlength="20">
					</div>
					<div class="form-group mb-3">
						<input type="text" class="form-control" value=<%=user.getUserName()%> name="userName" maxlength="20">
					</div>
					<div class="form-group mb-3">
						<input type="email" class="form-control" value=<%=user.getUserEmail()%> name="userEmail" maxlength="20">
					</div>
					<input type="submit" class="btn btn-danger form-control" value="수정하기"></form>
					<br>
            <form method="post" action="userDeleteAction.jsp">
            <input type="submit" class="btn btn-danger pull-right" value="탈퇴하기">
            </form>
			</div>
		</div>
	</div>
</body>
</html>