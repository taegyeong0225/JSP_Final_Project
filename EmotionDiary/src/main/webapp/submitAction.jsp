<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
      
      if(userID==null){
         PrintWriter script=response.getWriter();
         script.println("<script>");
         script.println("alert('로그인을 하세요')");
         script.println("location.href='login.jsp'");
         script.println("</script>");
      }
          else{
             int diaryID = 0; 
             if (request.getParameter("diaryID") != null){
                diaryID = Integer.parseInt(request.getParameter("diaryID"));
             }
             
             if (diaryID == 0){
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('유효하지 않은 글입니다.')");
                script.println("location.href = 'login.jsp'");
                script.println("</script>");
             }
          }
       %>
</body>
</html>