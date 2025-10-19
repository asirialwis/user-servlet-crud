<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Check for registration success/error messages passed from the Servlet
    String success = request.getParameter("success");
    String regError = request.getParameter("error");
%>
<html>
<head>
    <title>Register User</title>
    <style>
        /* CSS Variables matching the Login Page */
        :root {
            --primary-color: #007bff; /* Standard Blue */
            --primary-hover: #0056b3;
            --background-color: #e9ecef;
            --card-bg: #ffffff;
            --text-color: #343a40;
            --error-color: #dc3545;
            --success-color: #28a745; /* Green for success messages */
            --border-radius: 8px;
            --shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--background-color);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            color: var(--text-color);
        }

        .register-card {
            width: 100%;
            max-width: 450px; /* Slightly wider card for more input fields */
            background-color: var(--card-bg);
            padding: 40px;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            text-align: center;
        }

        .register-card h2 {
            font-size: 1.8rem;
            margin-bottom: 25px;
            color: var(--primary-color);
        }

        /* Form element styling */
        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            transition: border-color 0.3s;
            box-sizing: border-box;
            margin-bottom: 0px; /* Removed margin-bottom here to manage spacing with error spans */
        }

        input[type="file"] {
            width: 100%;
            padding: 8px 0;
            box-sizing: border-box;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="password"]:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 0.1rem rgba(0, 123, 255, 0.25);
        }

        /* Submit Button */
        input[type="submit"] {
            background-color: var(--primary-color);
            color: white;
            padding: 12px;
            width: 100%;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 700;
            font-size: 1rem;
            margin-top: 20px;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: var(--primary-hover);
        }

        /* Message Styling */
        .error-message, .success-message {
            font-size: 0.9rem;
            margin-bottom: 15px;
            padding: 10px;
            border-radius: 4px;
            text-align: left;
            display: block;
            font-weight: 500;
        }

        .error-message {
            color: var(--error-color);
            border: 1px solid rgba(220, 53, 69, 0.3);
            background-color: rgba(220, 53, 69, 0.05);
        }

        .success-message {
            color: var(--success-color);
            border: 1px solid rgba(40, 167, 69, 0.3);
            background-color: rgba(40, 167, 69, 0.05);
        }

        .error { /* For client-side validation errors */
            color: var(--error-color);
            font-size: 0.85rem;
            margin-top: 5px;
            margin-bottom: 10px; /* Added spacing after error */
            display: block;
            text-align: left;
        }

        .login-link {
            margin-top: 25px;
            font-size: 0.95rem;
        }

        .login-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
        }

        .login-link a:hover {
            text-decoration: underline;
        }
    </style>

    <script>
        // --- Your existing JavaScript logic remains here ---
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
            // --- Your existing validateForm function remains here ---
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

<div class="register-card">
    <h2><span style="color: #6c757d;">New User</span> Registration</h2>

    <% if ("success".equals(success)) { %>
    <span class="success-message">
            **Registration Successful!** You can now log in.
        </span>
    <% } else if (regError != null) { %>
    <span class="error-message">
            **Registration Failed:** <%= regError %>
        </span>
    <% } %>

    <form name="userForm" action="adduser" method="POST" onsubmit="return validateForm()" enctype="multipart/form-data">

        <div class="form-group">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" placeholder="John Doe">
            <span class="error" id="usernameError"></span>
        </div>

        <div class="form-group">
            <label for="email">Email Address:</label>
            <input type="email" id="email" name="email" placeholder="john@example.com">
            <span class="error" id="emailError"></span>
        </div>

        <div class="form-group">
            <label for="mobile">Mobile Number:</label>
            <input type="text" id="mobile" name="mobile" placeholder="077xxxxxxx">
            <span class="error" id="mobileError"></span>
        </div>

        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" placeholder="••••••••">
            <span class="error" id="passwordError"></span>
        </div>

        <div class="form-group">
            <label for="confirmPassword">Confirm Password:</label>
            <input type="password" id="confirmPassword" placeholder="Confirm password" />
            <span class="error" id="confirmPasswordError"></span>
        </div>

        <div class="form-group">
            <label>Profile Image (Optional):</label>
            <input type="file" name="image" accept="image/*" />
        </div>

        <input type="submit" value="Register">

        <p class="login-link">Already have an account?
            <a href="login.jsp">Login</a>
        </p>
    </form>
</div>
</body>
</html>