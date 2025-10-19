<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Capture the error parameter for server-side messages
    String error = request.getParameter("error");
%>
<html>
<head>
    <title>User Management System | Login</title>
    <style>
        /* Modern CSS Variables for easy theme changes */
        :root {
            --primary-color: #007bff; /* Standard Bootstrap Blue */
            --primary-hover: #0056b3; /* Darker blue for hover */
            --background-color: #e9ecef; /* Light gray background */
            --card-bg: #ffffff;
            --text-color: #343a40;
            --error-color: #dc3545; /* Standard red for errors */
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

        .login-card {
            width: 100%;
            max-width: 400px;
            background-color: var(--card-bg);
            padding: 40px;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            text-align: center;
        }

        .login-card h2 {
            font-size: 1.8rem;
            margin-bottom: 25px;
            color: var(--primary-color); /* Blue Header */
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

        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            transition: border-color 0.3s;
            box-sizing: border-box;
        }

        input[type="email"]:focus,
        input[type="password"]:focus {
            border-color: var(--primary-color);
            outline: none;
            /* Subtle focus glow using blue */
            box-shadow: 0 0 0 0.1rem rgba(0, 123, 255, 0.25);
        }

        /* Submit Button */
        input[type="submit"] {
            background-color: var(--primary-color); /* Blue Button */
            color: white;
            padding: 12px;
            width: 100%;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 700;
            font-size: 1rem;
            margin-top: 10px;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: var(--primary-hover); /* Darker blue on hover */
        }

        /* Error and Link Styling */
        .error-message {
            color: var(--error-color);
            font-size: 0.9rem;
            margin-top: 15px;
            padding: 10px;
            border: 1px solid rgba(220, 53, 69, 0.3);
            background-color: rgba(220, 53, 69, 0.05);
            border-radius: 4px;
            text-align: left;
            display: block;
            font-weight: 500;
        }

        #emailError {
            color: var(--error-color);
            font-size: 0.85rem;
            margin-top: 5px;
            display: block;
            text-align: left;
        }

        .register-link {
            margin-top: 25px;
            font-size: 0.95rem;
        }

        .register-link a {
            color: var(--primary-color); /* Blue Link */
            text-decoration: none;
            font-weight: 600;
        }

        .register-link a:hover {
            text-decoration: underline;
        }
    </style>

    <script>
        function validateForm(){
            const email = document.forms["userForm"]["email"].value.trim();
            const password = document.forms["userForm"]["password"].value;
            let isValid = true;

            document.getElementById("emailError").innerText = "";

            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            if(email === "" || password === ""){
                document.getElementById("emailError").innerText = "Please enter both email and password.";
                isValid = false;
            } else if(!emailPattern.test(email)){
                document.getElementById("emailError").innerText = "Invalid email format.";
                isValid = false;
            }

            return isValid;
        }
    </script>
</head>
<body>

<div class="login-card">
    <h2><span style="color: #6c757d;">System</span> Login</h2>

    <% if ("credentials".equals(error)) { %>
    <span class="error-message">
            **Login Failed:** Invalid Email or Password. Please try again.
        </span>
    <% } else if ("denied".equals(error)) { %>
    <span class="error-message">
            **Access Denied:** Your account is inactive. Please contact support.
        </span>
    <% } %>

    <form name="userForm" action="login" method="POST" onsubmit="return validateForm()">

        <div class="form-group">
            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" placeholder="you@example.com" required>
            <span id="emailError"></span>
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="••••••••" required>
        </div>

        <input type="submit" value="Log In">

        <p class="register-link">
            Don't have an account?
            <a href="register.jsp">Create an Account</a>
        </p>
    </form>
</div>

</body>
</html>