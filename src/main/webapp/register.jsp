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
        window.onload = function () {
            const form = document.forms["userForm"];
            const usernameInput = form["username"];
            const emailInput = form["email"];
            const mobileInput = form["mobile"];
            const passwordInput = form["password"];
            const confirmPasswordInput = document.getElementById("confirmPassword");

            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            const mobilePattern = /^[0-9]{10}$/;

            usernameInput.addEventListener("input", () => {
                const username = usernameInput.value.trim();
                if (username === "") {
                    setError("usernameError", "Username is required.");
                } else if (username.length > 15 || /[^a-zA-Z]/.test(username)) {
                    setError("usernameError", "Username must be max 15 characters and contain only letters.");
                } else {
                    clearError("usernameError");
                }
            });

            emailInput.addEventListener("input", () => {
                const email = emailInput.value.trim();
                if (!emailPattern.test(email)) {
                    setError("emailError", "Invalid email format.");
                } else {
                    clearError("emailError");
                }
            });

            mobileInput.addEventListener("input", () => {
                const mobile = mobileInput.value.trim();
                if (!mobilePattern.test(mobile)) {
                    setError("mobileError", "Mobile number must be exactly 10 digits.");
                } else {
                    clearError("mobileError");
                }
            });

            passwordInput.addEventListener("input", () => {
                const password = passwordInput.value;
                if (password.length < 6) {
                    setError("passwordError", "Password must be at least 6 characters long.");
                } else {
                    clearError("passwordError");
                }
                validateConfirmPassword();
            });

            confirmPasswordInput.addEventListener("input", validateConfirmPassword);

            function validateConfirmPassword() {
                const password = passwordInput.value;
                const confirmPassword = confirmPasswordInput.value;
                if (password && confirmPassword && password !== confirmPassword) {
                    setError("confirmPasswordError", "Password do not match!");
                } else {
                    clearError("confirmPasswordError");
                }
            }

            function setError(id, message) {
                document.getElementById(id).innerText = message;
            }

            function clearError(id) {
                document.getElementById(id).innerText = "";
            }
        };

        function validateForm() {

            const username = document.forms["userForm"]["username"].value.trim();
            const email = document.forms["userForm"]["email"].value.trim();
            const mobile = document.forms["userForm"]["mobile"].value.trim();
            const password = document.forms["userForm"]["password"].value;
            const confirmPassword = document.getElementById("confirmPassword").value;

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
                setError("usernameError", "Username is required.");
                isValid = false;
            } else if (username.length > 15 || /[^a-zA-Z]/.test(username)) {
                setError("usernameError", "Username must be max 15 characters and contain only letters.");
                isValid = false;
            }

            if (!emailPattern.test(email)) {
                setError("emailError", "Invalid email format.");
                isValid = false;
            }

            if (!mobilePattern.test(mobile)) {
                setError("mobileError", "Mobile number must be exactly 10 digits.");
                isValid = false;
            }

            if (password.length < 6) {
                setError("passwordError", "Password must be at least 6 characters long.");
                isValid = false;
            }

            if (password && password !== confirmPassword) {
                setError("confirmPasswordError", "Password do not match!");
                isValid = false;
            }

            return isValid;

            function setError(id, message) {
                document.getElementById(id).innerText = message;
            }
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


