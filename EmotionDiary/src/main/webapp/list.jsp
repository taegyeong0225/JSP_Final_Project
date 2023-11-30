<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="/css/style.css">
  <script type="text/javascript">
  
  </script>
</head>
<body>
<div class="container">
<h2>파일 첨부형 게시판 - 목록보기(List)</h2>
	
<!-- 검색 폼 -->
<form method ="get">
<table width="100%">
	<tr align="center">
		<td>
			<select name="searchField" class="custom-select" style="width:10%; display:inline-block;">
				<option value="title">제목</option>
				<option value="content">내용</option>
			</select>
			<input type="text" name="searchWord"  class="form-control" style="width:30%; display:inline-block;"/>
			<input type="submit" value="검색하기" class="btn btn-primary" style="width:10%; display:inline-block;"/>
		</td>
	</tr>
</table>	
</form>
	
<!-- 목록 테이블 -->
<table class ="table">
	<tr class= "bg-color2">
		<th width ="10%">번호</th>
		<th width ="*"> 제목 </th>
		<th width ="15%"> 작성자 </th>
		<th width ="10%"> 조회수 </th>
		<th width ="15%"> 작성일 </th>
		<th width ="8%"> 첨부 </th>
	</tr>
<c:choose>
	<c:when test="${empty boardLists }"> <!-- 게시물이 없을때 -->
		<tr>
			<td colspan="6" align="center"> 등록된 게시물이 없습니다 ! </td>
		</tr>
	</c:when>
	
	<c:otherwise> <!-- 게시물이 있을때 -->
		<c:forEach items="${ boardLists }" var ="row" varStatus="loop">
		<tr align="center" class="bg-color4">
			<td> ${map.totalCount  - (((map.pageNum-1) * map.pageSize) + loop.index)} </td>
			<td align="left">
			 	<a href="../mvcboard/view.do?idx=${row.idx }">${row.title }</a> 
			</td>
			<td> ${row.name} </td>
			<td> ${row.visitcount} </td>	
			<td> ${row.postdate} </td>
			<td>
			<c:if test="${not empty row.ofile }">	
			<c:set var="fileNm" value="${row.ofile}" />
			<c:forTokens var="token" items="${fileNm }" delims="." varStatus="status">
				<c:if test="${status.last }">
					<c:choose> 
						<c:when test="${token eq 'html' }"> 
							<img src="/img/html.png" width="40px" height="40px"> 
						</c:when>
							
						<c:when test="${token eq 'txt'}"> 
							<img src="/img/txt.png"  width="40px" height="34px">
						</c:when> 
							 
						<c:when test="${token eq 'pdf'}"> 
							<img src="/img/pdf.png"  width="40px" height="40px"> 
						</c:when>
							 
						<c:when test="${token eq 'css'}"> 
							<img src="/img/css.png"  width="40px" height="40px"> 
						</c:when>
							 
						<c:when test="${token eq 'png'}"> 
							<img src="/img/png.png"  width="40px" height="40px"> 
						</c:when>
							 
						<c:when test="${token eq 'jpg'}"> 
							<img src="/img/jpg.png"  width="40px" height="40px"> 
						</c:when>
					</c:choose> 
				</c:if>
			</c:forTokens>			
			</c:if>
			</td>
		</tr>
		</c:forEach>
	</c:otherwise>
</c:choose>
	</table>	
	
	<!-- 하단메뉴(바로가기, 글쓰기) -->	
	<table>
		<tr align="center">
			<td>
				${map.pagingImg }
			</td>
			<td width="100"> <button type="button" onclick="location.href='../mvcboard/write.do';"> 글쓰기 </button> </td>
		</tr>	
	</table>
	</div>
</body>
</html>