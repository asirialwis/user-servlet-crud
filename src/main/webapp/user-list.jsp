<%--
  Created by IntelliJ IDEA.
  User: Asiri
  Date: 4/11/2025
  Time: 10:26 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Dashboard</title>
</head>
<body>
<%
    String userEmail = (String) session.getAttribute("user");
    if (userEmail != null) {
%>
<h2>Welcome, <%= userEmail %>!</h2>
<%
    } else {
        response.sendRedirect("login.jsp");
    }
%>
<form action = "logout">
    <input type = "submit" value="Logout">
</form>
</body>
</html>
