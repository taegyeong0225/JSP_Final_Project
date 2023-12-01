<!-- 글을 쓰고 작동하는 파일 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="diary.DiaryDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="diary" class="diary.Diary" scope="page"/>
<jsp:setProperty name="diary" property="diaryTitle"/>
<jsp:setProperty name="diary" property="diaryContent" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Emotion Diary</title>
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
			if(diary.getDiaryTitle()==null||diary.getDiaryContent()==null){
					PrintWriter script=response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 안 된 사항이 있습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}else{
					DiaryDAO diaryDAO=new DiaryDAO();//하나의 인스턴스
					int result=diaryDAO.write(diary.getDiaryTitle(),userID,diary.getDiaryContent(),diary.getDiaryCount());
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