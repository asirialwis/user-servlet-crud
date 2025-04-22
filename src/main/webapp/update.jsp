<%@ page import="org.example.servletcrudapp.dao.userDAO" %>
<%@ page import="org.example.servletcrudapp.model.User" %>
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
        .form-container {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 40px;
            min-height: 100vh;
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        .profile-form {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            width: 100%;
            max-width: 500px;
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
            background-color: #0056b3;
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #007bff;
            text-decoration: none;
        }

        .back-link:hover {
            text-decoration: underline;
        }
        .error {
            color: red;
            margin-top: 10px;
            font-weight: bold;
            display: none;
        }
    </style>

    <script>
        function validateForm(){
            const password = document.getElementById("password").value;
            const confirmPassword = document.getElementById("confirmPassword").value;
            const errorMsg = document.getElementById("error");

            if(password && password !== confirmPassword){
                errorMsg.style.display = "block";
                return false;
            }
            errorMsg.style.display = "none";
            return true;
        }
    </script>

</head>
<body>

<div class="form-container">
    <h2>Update Your Profile</h2>

    <form action="update" method="post" class="profile-form" onsubmit="return validateForm()">
        <label for="username">User Name:</label>
        <input type="text" name="username" id="username" value="<%=user.getUsername()%>" required />

        <label for="email">Email:</label>
        <input type="text" name="email" id="email" value="<%=user.getEmail()%>" readonly />

        <label for="mobile">Mobile:</label>
        <input type="text" name="mobile" id="mobile" value="<%=user.getMobile()%>" required />

        <label for="password">New Password:</label>
        <input type="password" name="password" id="password" placeholder="Enter new password" />

        <label for="confirmPassword">Confirm New Password:</label>
        <input type="password" id="confirmPassword" placeholder="Re-enter new password" />

        <div id="error" class="error">Passwords do not match!</div>

        <input type="submit" value="Update">
    </form>

    <a class="back-link" href="profile">← Back to Profile</a>
</div>

</body>
</html>
