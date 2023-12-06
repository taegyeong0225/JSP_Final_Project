<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>데이터베이스 연결</h3>
	<%
	   // 1. DB 연결
	   // Class의 static 메소드인 forName은 클래스의 이름을 매개변수로 받아서 Class 객체를 리턴해줌
	   Class.forName("com.mysql.cj.jdbc.Driver");
	
	   Connection conn = null;
	   Statement stat    = null;
	   ResultSet rs    = null;
	   
	   String jdbcURL = "jdbc:mysql://localhost:3306/EmotionDiary";
	   String dbUser = "root";
	   String dbPass = "rootpw";
	   
	   String sql      = "select * from user";
	   
	   // 2. 데이터베이스 connection 생성
	   conn = DriverManager.getConnection(jdbcURL, dbUser, dbPass);
	   
	   // 3. 쿼리를 위한 객체 Statement 객체 생성
	   stat = conn.createStatement();
	   
	   // 4. 쿼리 실행
	   rs = stat.executeQuery(sql);
	   
	   // 5. 쿼리 결과 출력
	   if (rs != null)
	      out.println("DB 연결 성공");
	   else
	      out.println("연결 실패");
	   
	   // 6. 사용한 객체 종료
	   rs.close();
	   stat.close();
	   conn.close();
	%>
</body>
</html>