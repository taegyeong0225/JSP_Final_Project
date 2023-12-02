<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en" data-bs-theme="auto">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>emotion diary</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
  	<link href="./css/style.css" rel="stylesheet" type="text/css">
  </head>
  <body>
  
   <jsp:include page="header.jsp" />
 
  
    <div class="container-fluid">
      <div class="row">
        <div class="col-md-4 mx-auto">
          <!-- 중앙에 위치하는 내용을 여기에 배치 -->
          <main class="form-signin">
            <form method="post" action="joinAction.jsp">
              <center><h1 class="h3 mb-3 fw-normal">Sign In</h1></center>
				<div class="form-floating">
				    <input type="text" class="form-control" id="floatingUsername" name="userName" placeholder="username">
				    <label for="floatingUsername">Username</label>
				</div>
				<div class="form-floating">
				    <input type="email" class="form-control" id="floatingEmail" name="userEmail" placeholder="email">
				    <label for="floatingEmail">Email</label>
				</div>
				<div class="form-floating">
				    <input type="text" class="form-control" id="floatingId" name="userID" placeholder="id">
				    <label for="floatingId">Id</label>
				</div>
				<div class="form-floating">
				    <input type="password" class="form-control" id="floatingPassword" name="userPassword" placeholder="password">
				    <label for="floatingPassword">Password</label>
				</div>

              <button class="btn btn-danger w-100 py-2" type="submit">Sign in</button>
            </form>
          </main>
        </div>
      </div>
    </div>
  </body>
</html>
