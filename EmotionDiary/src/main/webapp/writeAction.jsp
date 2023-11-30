<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="diary.diaryDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="diary" class="EmotionDiary.diary" scope="page"/>
<jsp:setProperty name="diary" property="diaryTitle"/>
<jsp:setProperty name="diary" property="diaryContent" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID")!=null){
			userID=(String)session.getAttribute("userID");
		}
		
		if(userID == null){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
		else{
			if(diary.getdiaryTitle()==null||diary.getdiaryContent()==null){
					PrintWriter script=response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 안 된 사항이 있습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}else{
					diaryDAO diaryDAO=new diaryDAO();//하나의 인스턴스
					int result=diaryDAO.write(diary.getdiaryTitle(),userID,diary.getdiaryContent(),diary.getdiaryCount(),diary.getLikeCount());
					if(result == -1){//데이터 베이스 오류가 날 때
						PrintWriter script=response.getWriter();
						script.println("<script>");
						script.println("alert('글쓰기에 실패했습니다.')");
						script.println("history.back()");
						script.println("</script>");
					}
					else{
						PrintWriter script=response.getWriter();
						script.println("<script>");
						script.println("location.href='diary.jsp?pageNumber=1'");
						script.println("</script>");
					}
		}
		
		}
	%>
</body>
</html>