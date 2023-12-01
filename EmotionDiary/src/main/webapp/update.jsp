<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="diary.Diary" %>
<%@ page import="diary.DiaryDAO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name ="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>Emotion Diary</title>
</head>
<body>
	<%
		String userID=null;
		if(session.getAttribute("userID")!=null){
			userID=(String)session.getAttribute("userID");
		}
		if(userID==null){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
		int diaryID=0;
		if(request.getParameter("diaryID")!=null)
			diaryID=Integer.parseInt(request.getParameter("diaryID"));
		if(diaryID==0){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='diary.jsp'");
			script.println("</script>");
		}
		Diary diary = new DiaryDAO().getDiary(diaryID);
		//작성자가 본인인지?
		if(!userID.equals(diary.getUserID())){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href='diary.jsp'");
			script.println("</script>");
		}
	%>
	
	<jsp:include page="header.jsp" />

	<div class="container">
		<div class="row">
			<form method="post" action="updateAction.jsp?diaryID=<%=diaryID%>"><%--업데이트 요청을 할 때 그 요청을 처리하는 액션 페이지 --%>
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #2e8b57; text-align:center;">게시판 글 수정 양식</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name="diaryTitle" maxlength="50" value="<%=diary.getDiaryTitle() %>"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용" name="diaryContent" maxlength="2048" style="height: 350px"><%=diary.getDiaryContent() %></textarea></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-success pull-right" value="글수정">
		</form>
		</div>
	</div>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>