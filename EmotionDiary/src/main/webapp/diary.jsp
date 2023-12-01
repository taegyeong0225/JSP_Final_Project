<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="diary.DiaryDAO"%>
<%@ page import="diary.Diary"%>
<%@ page import="java.util.ArrayList"%>

<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<link rel="stylesheet" href="css/style.css">

<title>Emotion Diary - list</title>
<style type="text/css">
a, a:hover {
	color: #000000;
	text-decoration: none;
}</style>=
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {//주어진 userID에 연결된 속성값을 얻어낸다.
			userID = (String) session.getAttribute("userID");
		}
		//현재 페이지가 몇번째 페이지 인가
		int pageNumber = 1;//기본적으로 1페이지
		if (request.getParameter("pageNumber") != null)
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	%>
	
	<jsp:include page="header.jsp" />
	
	<div class="container">
		<div class="row">
			<form method="post" name="search" action="searchdiary.jsp">
				<table class="pull-right">
					<tr>
						<td><select class="form-control" name="searchField">
								<option value="0">선택</option>
								<option value="diaryTitle">제목</option>
								<option value="userID">작성자</option>
						</select></td>
						<td><input type="text" class="form-control"
							placeholder="검색어 입력" name="searchText" maxlength="100"></td>
						<td><button type="submit" class="btn btn-success">검색</button></td>
					</tr>

				</table>
			</form>
		</div>
	</div>
	<br>
	<div class="container">
		<div class="row">
			<table class="active table table-striped" style="text-align: center; border: 1px solid #dddddd">
			    <%-- 테이블 헤더 생략 --%>
				<thead>
					<tr>
						<th style="background-color: #2e8b57; text-align: center;">번호</th>
						<th style="background-color: #2e8b57; text-align: center;">제목</th>
						<th style="background-color: #2e8b57; text-align: center;">작성자</th>
						<th style="background-color: #2e8b57; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						DiaryDAO diaryDAO = new DiaryDAO();
						ArrayList<Diary> list = diaryDAO.getList(pageNumber);
						for (int i = 0; i < list.size(); i++) {
					%>
					<%				
					    // ArrayList의 타입이 Diary 타입인지 확인하고, Diary 타입으로 변경해야 합니다.
					    ArrayList<Diary> list = diaryDAO.getList(pageNumber);
					    for (int i = 0; i < list.size(); i++) {
					        // Timestamp 객체를 가져와서 SimpleDateFormat을 이용해 문자열로 포매팅
					        String formattedDate = sdf.format(list.get(i).getDiaryDate());
					%>
					<tr>
						<td><%=list.get(i).getDiaryID()%></td>
						<%--현재 게시글에 대한 정보 --%>
						<td><a href="view.jsp?diaryID=<%=list.get(i).getDiaryID()%>"><%=list.get(i).getDiaryTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
						.replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
						<td><%=list.get(i).getUserID()%></td>
						<td><%=formattedDate%></td>
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
					if (diaryDAO.nextPage(pageNumber + 1)) {//다음페이지가 존재하는ㄱ ㅏ
				%>
				<a href="diary.jsp?pageNumber=<%=pageNumber + 1%>">다음 ▶</a>
				<%
					}
				%>
				<a href="write.jsp" class="btn btn-success pull-right">글쓰기</a>
			</div>

		</div>
	</div>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>