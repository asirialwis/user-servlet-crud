<%@ page import="org.example.servletcrudapp.model.User" %>
<%@ page import="java.util.Base64" %>
<%@ include file="navbar.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 0;
        }

        .dashboard-container {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
        }

        .profile-card {
            background-color: white;
            padding: 40px;
            width: 100%;
            max-width: 450px;
            border-radius: 16px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .profile-card img {
            width: 140px;
            height: 140px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 25px;
            border: 3px solid #007bff;
        }

        .profile-card h2 {
            color: #333;
            margin-bottom: 10px;
        }

        .profile-card p {
            margin: 8px 0;
            font-size: 16px;
            color: #555;
        }

        .btn-group {
            margin-top: 30px;
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .btn {
            display: block;
            width: 100%;
            padding: 12px 20px;
            font-weight: bold;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn-update {
            background-color: #007bff;
            color: white;
        }

        .btn-update:hover {
            background-color: #0056b3;
        }

        .btn-delete {
            background-color: #dc3545;
            color: white;
        }

        .btn-delete:hover {
            background-color: #a71d2a;
        }
    </style>
</head>
<body>

<%
    String userEmail = (String) session.getAttribute("user");
    if (userEmail != null) {
        User user = (User) request.getAttribute("userData");

        String base64Image = "";
        byte[] imageBytes = user.getImage();

        if (imageBytes != null && imageBytes.length > 0) {
            base64Image = Base64.getEncoder().encodeToString(imageBytes);
        } else {
            base64Image = "default.png"; //
        }
%>

<div class="dashboard-container">
    <div class="profile-card">
        <img src="<%= imageBytes != null && imageBytes.length > 0 ? "data:image/jpeg;base64," + base64Image : "upload/default.png" %>" alt="Profile Image">
        <h2><%= user.getUsername() %></h2>
        <p><strong>Email:</strong> <%= user.getEmail() %></p>
        <p><strong>Mobile Number:</strong> <%= user.getMobile() %></p>

        <div class="btn-group">
            <form action="update.jsp" method="get">
                <input type="submit" class="btn btn-update" value="Update Profile" />
            </form>

            <form action="delete" method="post" onsubmit="return confirm('Are you sure you want to delete your account? This action is irreversible.');">
                <input type="submit" class="btn btn-delete" value="Delete My Account" />
            </form>
        </div>
    </div>
</div>

<% } else {
    response.sendRedirect("login.jsp");
} %>

</body>
</html>
