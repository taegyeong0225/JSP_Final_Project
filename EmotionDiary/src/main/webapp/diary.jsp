<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="diary.DiaryDAO"%>
<%@ page import="diary.Diary"%>
<%@ page import="java.util.ArrayList"%>

<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<% request.setCharacterEncoding("UTF-8"); %>


<!DOCTYPE html>
<html lang="en" data-bs-theme="auto">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    
<link rel="stylesheet" href="css/style.css">

<title>일기장 목록</title>


</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {//주어진 userID에 연결된 속성값을 얻어낸다.
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1;//기본적으로 1페이지
		if (request.getParameter("pageNumber") != null)
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	%>
	
	<jsp:include page="header.jsp" />

	<div class="container">
		<div class="row">
			<table class="active table table-striped" style="text-align: center; border: 1px solid #dddddd">
			    <%-- 테이블 헤더 생략 --%>
				<thead>
					<tr>
						<th style="background-color: #ffb1c1; text-align: center;">번호</th>
						<th style="background-color: #ffb1c1; text-align: center;">제목</th>
						<th style="background-color: #ffb1c1; text-align: center;">작성자</th>
						<th style="background-color: #ffb1c1; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						DiaryDAO diaryDAO = new DiaryDAO();
						ArrayList<Diary> list = diaryDAO.getList(pageNumber);
						for (int i = 0; i < list.size(); i++) {
					%>
					<tr>
					    <%-- 다이어리 항목 출력 --%>
						<td><%= list.get(i).getDiaryID() %></td>
						<td><a href="view.jsp?diaryID=<%= list.get(i).getDiaryID() %>"><%= list.get(i).getDiaryTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
							.replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></a></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%=list.get(i).getDiaryDate().substring(0, 11) + list.get(i).getDiaryDate().substring(11, 13) + "시"
						+ list.get(i).getDiaryDate().substring(14, 16) + "분"%></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<div class=container style="text-align: center">
				<%
					if (pageNumber != 1) {//이전페이지로
				%>
				<a href="diary.jsp?pageNumber=<%=pageNumber - 1%>">◀ 이전</a>
				<%
					}
				%>
				<%
					int n = (int) (diaryDAO.getCount() / 10 + 1);
					for (int i = 1; i <= n; i++) {
				%>
				<a href="diary.jsp?pageNumber=<%=i%>">|<%=i%>|
				</a>
				<%
					}
				%>
				<%
					if (diaryDAO.nextPage(pageNumber + 1)) {//다음페이지가 존재하는
				%>
				<a href="diary.jsp?pageNumber=<%=pageNumber + 1%>">다음 ▶</a>
				<%
					}
				%>
				<br>
				<br>
				<a href="inputContent.jsp" class="btn btn-danger pull-right">✍🏻글쓰기</a>
			</div>

		</div>
	</div>
</body>
</html>