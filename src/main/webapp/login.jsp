<%--
  Created by IntelliJ IDEA.
  User: Asiri
  Date: 4/16/2025
  Time: 9:17 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f4f6;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding-top: 60px;
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        form {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 350px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            color: #444;
        }

        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        input[type="checkbox"] {
            margin-right: 5px;
        }

        input[type="submit"] {
            background-color: #007BFF;
            color: white;
            padding: 10px;
            width: 100%;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        p {
            margin-top: 15px;
            text-align: center;
        }

        a {
            color: #007BFF;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
        .error {
            color: red;
            font-size: 13px;
            margin-bottom: 10px;
            display: block;
        }
    </style>

    <script>
        function validateForm(){
            const email = document.forms["userForm"]["email"].value.trim();
            const password = document.forms["userForm"]["password"].value;
            let isValid = true;

            document.getElementById("emailError").innerText = "";



            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if(!emailPattern.test(email)){
                document.getElementById("emailError").innerText = "Invalid email Format";
                isValid = false;
            }
            if(email === "" || password === ""){
                document.getElementById("emailError").innerText = "please end valid email password"
                isValid = false;
            }
            return isValid;

        }
    </script>
</head>
<body>
<h2>Login</h2>


<form name="userForm" action="login" method="POST" onsubmit="return validateForm()">
    <label for="email">Email:</label>
    <input type="email" id="email" name="email">
    <span class="error" id="emailError"></span>

    <label for="password">Password:</label>
    <input type="password" id="password" name="password">

    <% if ("invalid".equals(request.getParameter("error"))) { %>
    <span class="error">Invalid email or password</span>
    <% } %>



    <br><br>
    <input type="submit" value="Login">

    <p>Don't have an account?
        <a href="register.jsp">Register</a>
    </p>
</form>
</body>
</html>

