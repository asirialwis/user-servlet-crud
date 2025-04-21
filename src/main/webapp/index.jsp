<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Home</title>
</head>
<body>
<h1><%= "Welcome To User Management System!" %>
</h1>
<br/>

<%! Date date = new Date(); %>
<%! String text = "The current date and time is "; %>

<a href="register.jsp">Register</a>
<a href="login.jsp"> Login </a>
<a href="profile">Profile</a>
<a href="users">User List</a>
</body>
</html>