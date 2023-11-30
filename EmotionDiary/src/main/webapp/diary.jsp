<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="diary.diaryDAO"%>
<%-- <%@ page import="EmotionDiary.Diary"%> --%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		diaryDAO diary = new diaryDAO();
	%>
	<div class="container">
		<div class="row">
			<form method="post" name="search" action="searchdiary.jsp">
				<div class="alert alert-info">
					<strong>오늘은 <%=diary.getDate().substring(0,4) + "년 "
						+ diary.getDate().substring(5, 7) + "월 " + diary.getDate().substring(8, 10) + "일"%> 입니다. </strong>
						오늘을 공유해주세요 💜	</div>
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
			<table class="active table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #2e8b57; text-align: center;">번호</th>
						<th style="background-color: #2e8b57; text-align: center;">제목</th>
						<th style="background-color: #2e8b57; text-align: center;">작성자</th>
						<th style="background-color: #2e8b57; text-align: center;">작성일</th>
						<th style="background-color: #2e8b57; text-align: center;">조회수</th>
						<th style="background-color: #2e8b57; text-align: center;">추천수👍</th>
					</tr>
				</thead>
				<tbody>
					<%
						diaryDAO diaryDAO = new diaryDAO();
						ArrayList<diary> list = diaryDAO.getList(pageNumber);
						for (int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<td><%=list.get(i).getdiaryID()%></td>
						<%--현재 게시글에 대한 정보 --%>
						<td><a href="view.jsp?diaryID=<%=list.get(i).getdiaryID()%>"><%=list.get(i).getdiaryTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
						.replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
						<td><%=list.get(i).getUserID()%></td>
						<td><%=list.get(i).getdiaryDate().substring(0, 11) + list.get(i).getdiaryDate().substring(11, 13) + "시"
						+ list.get(i).getdiaryDate().substring(14, 16) + "분"%></td>
						<td><%=list.get(i).getdiaryCount()%></td>
						<td><%=list.get(i).getLikeCount()%></td>
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