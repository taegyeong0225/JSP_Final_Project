<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<link href="style.css" rel="stylesheet" type="text/css">

<meta charset="UTF-8">



<%@page import="java.util.Calendar"%>
<%
    request.setCharacterEncoding("utf-8");

    Calendar cal = Calendar.getInstance();
    
    // 시스템 오늘날짜
    int ty = cal.get(Calendar.YEAR);
    int tm = cal.get(Calendar.MONTH) + 1;
    int td = cal.get(Calendar.DATE);
    
    int year = cal.get(Calendar.YEAR);
    int month = cal.get(Calendar.MONTH) + 1;
    
    // 파라미터 받기
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
%>

<%-- <jsp:include page="header.jsp" /> --%>

<!--  해더 내용 -->
<!-- 해더 내용 -->
<header>
    <%
        String userID = null;
        if (session.getAttribute("userID") != null) {
            userID = (String) session.getAttribute("userID");
        }
    %>
    <div class="container-fluid">
        <div class="row">
            <nav class="navbar navbar-expand-lg bg-danger-subtle">
                <div class="container-fluid">
                    <a class="navbar-brand" href="main.jsp">EMOTION DIARY</a>
                    <div class="collapse navbar-collapse" id="navbarNavDropdown">
                        <ul class="navbar-nav ms-auto">
                            <li class="nav-item">
                                <a class="nav-link btn btn-danger active" aria-current="page" href="calendar.jsp">감정 달력</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link btn btn-danger" href="#">일기장</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link btn btn-outline-light" href="inputContent">✍🏻글쓰기</a>
                            </li>
                        </ul>
                        <ul class="navbar-nav">
                            <% if (userID == null) { %>
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        접속하기
                                    </a>
                                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                        <li><a class="dropdown-item" href="login.jsp">로그인</a></li>
                                        <li><a class="dropdown-item" href="join.jsp">회원가입</a></li>
                                    </ul>
                                </li>
                            <% } else { %>
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        회원관리
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
		<a href="calendar.jsp?year=<%=year%>&month=<%=month-1%>">&lt;</a>
		<label><%=year%>년 <%=month%>월</label>
		<a href="calendar.jsp?year=<%=year%>&month=<%=month+1%>">&gt;</a>
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
			// 1일 앞 달
			Calendar preCal = (Calendar)cal.clone();
			preCal.add(Calendar.DATE, -(week-1));
			int preDate = preCal.get(Calendar.DATE);
			
			out.print("<tr>");
			// 1일 앞 부분
			for(int i=1; i<week; i++) {
				//out.print("<td>&nbsp;</td>");
				out.print("<td class='gray'>"+(preDate++)+"</td>");
			}
			
			// 1일부터 말일까지 출력
			int lastDay = cal.getActualMaximum(Calendar.DATE);
			String cls;
			for(int i=1; i<=lastDay; i++) {
				cls = year==ty && month==tm && i==td ? "today":"";
				
				out.print("<td class='"+cls+"'>"+i+"</td>");
				if(lastDay != i && (++week)%7 == 1) {
					out.print("</tr><tr>");
				}
			}
			
			// 마지막 주 마지막 일자 다음 처리
			int n = 1;
			for(int i = (week-1)%7; i<6; i++) {
				// out.print("<td>&nbsp;</td>");
				out.print("<td class='gray'>"+(n++)+"</td>");
			}
			out.print("</tr>");
%>		
		</tbody>
	</table>
	<div class="footer">
		<a href="calendar.jsp">오늘날짜로</a>
	</div>
</div>
