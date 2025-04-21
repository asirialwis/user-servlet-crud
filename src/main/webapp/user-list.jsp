<%@ page import="org.example.servletcrudapp.model.User" %><%--
  Created by IntelliJ IDEA.
  User: Asiri
  Date: 4/11/2025
  Time: 10:26 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="org.example.servletcrudapp.model.User" %>
<%@ include file="navbar.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 0;
        }

        .dashboard-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 40px;
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        .profile-card {
            background-color: white;
            padding: 30px;
            width: 400px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }

        .profile-card p {
            margin: 10px 0;
            font-size: 16px;
            color: #555;
        }

        .profile-card a {
            display: inline-block;
            margin-top: 15px;
            color: #007BFF;
            text-decoration: none;
            font-weight: bold;
        }

        .profile-card a:hover {
            text-decoration: underline;
        }

        .btn-group {
            margin-top: 25px;
            display: flex;
            gap: 15px;
            justify-content: space-between;
        }

        .btn-group form {
            margin: 0;
        }

        input[type="submit"] {
            padding: 10px 20px;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .logout-btn {
            background-color: #333;
            color: white;
        }

        .delete-btn {
            background-color: #dc3545;
            color: white;
        }
    </style>
</head>
<body>

<%
    String userEmail = (String) session.getAttribute("user");
    if (userEmail != null) {
        User user = (User) request.getAttribute("userData");
        String imagePath = user.getFilePath();
%>

<div class="dashboard-container">
    <h2>Welcome, <%= userEmail %>!</h2>
    <div class="profile-card">
        <img src="<%= imagePath %>" alt="Profile Image" style="width: 150px; height: 150px; border-radius: 50%; object-fit: cover; margin-bottom: 20px;">
        <p><strong>Username:</strong> <%= user.getUsername() %></p>
        <p><strong>Email:</strong> <%= user.getEmail() %></p>
        <p><strong>Mobile Number:</strong> <%= user.getMobile() %></p>

        <a href="update.jsp">Update Profile</a>

        <div class="btn-group">
            <form action="logout">
                <input type="submit" value="Logout" class="logout-btn">
            </form>

            <form action="delete" method="POST" onsubmit="return confirm('Are you sure you want to delete your account? This action is irreversible.');">
                <input type="submit" value="Delete My Account" class="delete-btn">
            </form>
        </div>
    </div>
</div>

<% } else {
    response.sendRedirect("login.jsp");
} %>

</body>
</html>
