<%@ page import="org.example.servletcrudapp.model.User" %><%--
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


<p>User Name:<%= ((User) request.getAttribute("userData")).getUsername() %></p>
<p>Email:<%= ((User) request.getAttribute("userData")).getEmail()%></p>
<p>Mobile Number:<%= ((User) request.getAttribute("userData")).getMobile()%></p>


<a href="update.jsp">Update</a>


<form action = "logout">
    <input type = "submit" value="Logout">
</form>
</body>
</html>
