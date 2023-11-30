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
                                <a class="nav-link btn btn-danger active" aria-current="page" href="calendar.jsp">mood tracker</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link btn btn-danger" href="#">diary</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link btn btn-outline-light" href="inputContent.jsp">write</a>
                            </li>
                        </ul>
                        <ul class="navbar-nav">
                            <% if (userID == null) { %>
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        connect
                                    </a>
                                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                        <li><a class="dropdown-item" href="login.jsp">login</a></li>
                                        <li><a class="dropdown-item" href="join.jsp">sign up</a></li>
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
