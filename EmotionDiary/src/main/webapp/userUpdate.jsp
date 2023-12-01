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
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>JSP 게시판 웹 사이트</title>
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
	
	<%
		
	%>
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="userUpdateAction.jsp">
					<h3 style="text-align:center;">내 정보</h3>
					<div class = "form-group">
						<input type="text" class="form-control" value=<%=user.getUserID()%> name="userID" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" value=<%=user.getUserPassword()%> name="userPassword" maxlength="20">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" value=<%=user.getUserName()%> name="userName" maxlength="20">
					</div>
					<div class="form-group">
						<input type="email" class="form-control" value=<%=user.getUserEmail()%> name="userEmail" maxlength="20">
					</div>
					<input type="submit" class="btn btn-success form-control" value="수정하기"></form>
					<br>
            <form method="post" action="userDeleteAction.jsp">
            <input type="submit" class="btn btn-danger pull-right" value="탈퇴하기">
            </form>

					</div></div>
</div>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>