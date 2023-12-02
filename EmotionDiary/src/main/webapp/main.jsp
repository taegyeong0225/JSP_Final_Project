<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Calendar"%>
<%@page import="diary.DiaryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<link href="css/style.css" rel="stylesheet" type="text/css">

<script src="https://kit.fontawesome.com/e902df2198.js" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>❤Emotion Diary️❤</title>

<%@page import="java.util.Calendar"%>
<%
    request.setCharacterEncoding("utf-8");

    Calendar cal = Calendar.getInstance();
    
    // 시스템 오늘날짜
    int ty = cal.get(Calendar.YEAR);
    int tm = cal.get(Calendar.MONTH) + 1;
    int td = cal.get(Calendar.DATE); // 
    
    int year = cal.get(Calendar.YEAR);
    int month = cal.get(Calendar.MONTH) + 1;
    
    String today = ty + "년 " + tm + "월 " + td + "일";
    
    // URL에서 년도와 월 파라미터 가져오기
    String sy = request.getParameter("year");
    String sm = request.getParameter("month");
    
    if (sy != null) { // 넘어온 파라미터가 있으면
        year = Integer.parseInt(sy);
    }
    if (sm != null) {
        month = Integer.parseInt(sm);
    }
    
    cal.set(year, month - 1, 1);
    year = cal.get(Calendar.YEAR);
    month = cal.get(Calendar.MONTH) + 1;
    int week = cal.get(Calendar.DAY_OF_WEEK); // 1(일)~7(토)
    
    DiaryDAO diaryDAO = new DiaryDAO();
    Map<String, String> emotions = diaryDAO.getEmotionsForMonth(year, month);
    
%>
</head>
<body>


<!-- 해더 내용 -->
<%-- <jsp:include page="header.jsp" /> --%>
<header>
    <%
        String userID = null;
        String userName = null; // 사용자 이름을 저장할 변수
        if (session.getAttribute("userID") != null) {
            userID = (String) session.getAttribute("userID");
            userName = (String) session.getAttribute("userName"); // 세션에서 사용자 이름을 가져옵니다.
        }
    %>

    <div class="container-fluid">
        <div class="row">
            <nav class="navbar navbar-expand-lg bg-danger-subtle">
                <div class="container-fluid">
                    <a class="navbar-brand" href="main.jsp">EMOTION DIARY</a>
                    
                                        
                    <!-- 토글 버튼 추가 -->
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    
                    
                    <div class="collapse navbar-collapse" id="navbarNavDropdown">
                        <ul class="navbar-nav ms-auto">
                            <li class="nav-item">
                                <a class="nav-link btn btn-danger" aria-current="page" href="main.jsp">감정 달력</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link btn btn-danger" href="diary.jsp">일기장</a>
                            </li>
                        </ul>
                        <ul class="navbar-nav">
                            <% if (userID == null) { %>
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        <i class="fa-solid fa-right-to-bracket"></i> 접속하기
                                    </a>
                                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                        <li><a class="dropdown-item" href="login.jsp">로그인</a></li>
                                        <li><a class="dropdown-item" href="join.jsp">회원가입</a></li>
                                    </ul>
                                </li>
                            <% } else { %>
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        <%= userName %>
                                    </a>
                                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                        <li><a class="dropdown-item" href="logoutAction.jsp">로그아웃</a></li>
                                        <li><a class="dropdown-item" href="userUpdate.jsp">내 정보</a></li>
                                    </ul>
                                </li>
                            <% } %>
                        </ul>
                    </div>
                </div>
            </nav>
        </div>
    </div>
</header>


<div class="calendar">
	<div class="title">
		<a href="main.jsp?year=<%=year%>&month=<%=month-1%>"><i class="fa-solid fa-chevron-left"></i></a>
		<label><%=year%>년 <%=month%>월</label>
		<a href="main.jsp?year=<%=year%>&month=<%=month+1%>"><i class="fa-solid fa-chevron-right"></i></a>
</div>
	<table>
		<thead>
			<tr>
				<td>일</td>
				<td>월</td>
				<td>화</td>
				<td>수</td>
				<td>목</td>
				<td>금</td>
				<td>토</td>
			</tr>
		</thead>
        <tbody>
    <%
        int day = 1;
        int lastDayOfMonth = cal.getActualMaximum(Calendar.DAY_OF_MONTH); // 달의 마지막 날짜를 구함
        for (int i = 0; i < 6; i++) { // 최대 6주
            out.println("<tr>");
            for (int j = 1; j <= 7; j++) {
                if (i == 0 && j < week || day > lastDayOfMonth) {
                    out.println("<td></td>"); // 빈 셀
                } else {
                    String dateKey = year + "-" + String.format("%02d", month) + "-" + String.format("%02d", day);
                    String emotion = emotions.getOrDefault(dateKey, "중립");
                    String colorClass = "";
                    
                    switch (emotion) {
                        case "긍정":
                            colorClass = "bg-pink";
                            break;
                        case "중립":
                            colorClass = "bg-yellow";
                            break;
                        case "부정":
                            colorClass = "bg-blue";
                            break;
                    }
                    out.println("<td class='" + colorClass + "'>" + day + "</td>");
                    day++;
                }
            }
            out.println("</tr>");
            if (day > lastDayOfMonth) {
                break; // 달의 마지막 날짜를 초과하면 반복문 종료
            }
        }
    %>
</tbody>
        </table>
	<div class="footer">
		<a href="main.jsp">오늘날짜로(<%= today %>)</a>
	</div>
</div>
</body>
</html>
