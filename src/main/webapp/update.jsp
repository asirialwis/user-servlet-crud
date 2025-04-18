<%@ page import="org.example.servletcrudapp.dao.userDAO" %>
<%@ page import="org.example.servletcrudapp.model.User" %><%--
  Created by IntelliJ IDEA.
  User: Asiri
  Date: 4/17/2025
  Time: 11:31 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String email = (String) session.getAttribute("user");
    userDAO userDAO = new userDAO();
    User user = userDAO.getUserByEmail(email);
%>
<html>
<head>
    <title>Update</title>
</head>
<body>
<form action="update" method="post">
    <label>User Name:</label>
    <label for="username"></label><input type="text" name="username" id="username" value="<%=user.getUsername()%>" />

    <label>Email:</label>
    <label for="email"></label><input type="text" name="email" id="email" value="<%=user.getEmail()%>" />

    <label>Mobile:</label>
    <label for="mobile"></label><input type="text" name="mobile" id="mobile" value="<%=user.getMobile()%>" />


    <label>Password:</label>
    <label for="password"></label>
    <input type="password" name="password" id="password" placeholder="Enter new password" />

    <input type="submit" value="Update">
</form>

</body>
</html>
