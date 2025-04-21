<%@ page import="org.example.servletcrudapp.dao.userDAO" %>
<%@ page import="org.example.servletcrudapp.model.User" %><%--
  Created by IntelliJ IDEA.
  User: Asiri
  Date: 4/17/2025
  Time: 11:31 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="navbar.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String email = (String) session.getAttribute("user");
    userDAO userDAO = new userDAO();
    User user = userDAO.getUserByEmail(email);
%>
<html>
<head>
    <title>Update Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 40px;
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        form {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            width: 400px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-top: 15px;
            color: #555;
            font-weight: bold;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            margin-top: 25px;
            background-color: #007BFF;
            color: white;
            padding: 12px;
            width: 100%;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }

        input[type="submit"]:hover {
            background-color:  #0056b3;
        }

        a {
            display: inline-block;
            margin-top: 20px;
            color: #007bff;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<h2>Update Your Profile</h2>

<form action="update" method="post">
    <label for="username">User Name:</label>
    <input type="text" name="username" id="username" value="<%=user.getUsername()%>" required />

    <label for="email">Email:</label>
    <input type="text" name="email" id="email" value="<%=user.getEmail()%>" readonly />

    <label for="mobile">Mobile:</label>
    <input type="text" name="mobile" id="mobile" value="<%=user.getMobile()%>" required />

    <label for="password">New Password:</label>
    <input type="password" name="password" id="password" placeholder="Enter new password" />

    <input type="submit" value="Update">
</form>

<a href="profile">← Back to Profile</a>

</body>
</html>
