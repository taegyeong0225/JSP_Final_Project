<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="diary.Diary" %>
<%@ page import="diary.DiaryDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
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
		if(!userID.equals(diary.getUserID())){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href='diary.jsp'");
			script.println("</script>");
		} else{
			if(request.getParameter("diaryTitle")==null||request.getParameter("diaryContent")==null
					||request.getParameter("diaryTitle").equals("")||request.getParameter("diaryContent").equals("")){
					PrintWriter script=response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 안 된 사항이 있습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}else{
					DiaryDAO diaryDAO=new DiaryDAO();//하나의 인스턴스
					int result=diaryDAO.update(diaryID, request.getParameter("diaryTitle"),request.getParameter("diaryContent"));
					if(result == -1){//데이터 베이스 오류가 날 때
						PrintWriter script=response.getWriter();
						script.println("<script>");
						script.println("alert('글 수정에 실패했습니다.')");
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