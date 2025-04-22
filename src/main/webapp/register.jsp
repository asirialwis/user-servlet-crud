<%--
  Created by IntelliJ IDEA.
  User: Asiri
  Date: 4/11/2025
  Time: 2:42 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register User</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f4f6;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding-top: 50px;
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

        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .error {
            color: red;
            font-size: 13px;
            margin-bottom: 10px;
            display: block;
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
            margin-top: 10px;
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
    </style>

    <script>
        function validateForm() {
            const username = document.forms["userForm"]["username"].value.trim();
            const email = document.forms["userForm"]["email"].value.trim();
            const mobile = document.forms["userForm"]["mobile"].value.trim();
            const password = document.forms["userForm"]["password"].value;
            const confirmPassword = document.forms["userForm"]["confirmPassword"].value;

            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            const mobilePattern = /^[0-9]{10}$/;

            let isValid = true;

            // Reset all error spans
            document.getElementById("usernameError").innerText = "";
            document.getElementById("emailError").innerText = "";
            document.getElementById("mobileError").innerText = "";
            document.getElementById("passwordError").innerText = "";
            document.getElementById("confirmPasswordError").innerText = "";

            if (username === "") {
                document.getElementById("usernameError").innerText = "Username is required.";
                isValid = false;
            }
            if (username.length > 10 || /[0-9]/.test(username) || /[^a-zA-Z]/.test(username)) {
                document.getElementById("usernameError").innerText = "Username must be max 15 characters and contain only letters.";
                isValid = false;
            }


            if (!emailPattern.test(email)) {
                document.getElementById("emailError").innerText = "Invalid email format.";
                isValid = false;
            }

            if (!mobilePattern.test(mobile)) {
                document.getElementById("mobileError").innerText = "Mobile number must be exactly 10 digits.";
                isValid = false;
            }

            if (password.length < 6) {
                document.getElementById("passwordError").innerText = "Password must be at least 6 characters long.";
                isValid = false;
            }
            if(password && password !== confirmPassword){
                document.getElementById("confirmPasswordError").innerText = "Password do not match!";
                isValid = false;
            }

            return isValid;
        }
    </script>
</head>
<body>
<h2>User Registration</h2>

<form name="userForm" action="adduser" method="POST" onsubmit="return validateForm()"  enctype="multipart/form-data">
    <label for="username">Username:</label>
    <input type="text" id="username" name="username" placeholder="John Doe">
    <span class="error" id="usernameError"></span>

    <label for="email">Email:</label>
    <input type="email" id="email" name="email" placeholder="john@gmail.com">
    <span class="error" id="emailError"></span>

    <label for="mobile">Mobile:</label>
    <input type="text" id="mobile" name="mobile" placeholder="077*******">
    <span class="error" id="mobileError"></span>

    <label for="password">Password:</label>
    <input type="password" id="password" name="password">
    <span class="error" id="passwordError"></span>

    <label for="confirmPassword">Confirm New Password:</label>
    <input type="password" id="confirmPassword" placeholder="Confirm password" />
    <span class="error" id="confirmPasswordError"></span>

    <label>Upload Image:</label>
    <input type="file" name="image" accept="image/*" />
    <input type="submit" value="Register">

    <p>Already have an account?
        <a href="login.jsp">Login</a>
    </p>
</form>
</body>
</html>


