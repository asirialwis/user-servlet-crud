<%--
  Created by IntelliJ IDEA.
  User: Asiri
  Date: 4/21/2025
  Time: 10:41 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.List" %>
<%@ page import="org.example.servletcrudapp.model.User" %>
<%@ include file="navbar.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User List</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
        }

        h2 {
            text-align: center;
            margin-top: 30px;
            color: #333;
        }

        .table-container {
            margin: 40px auto;
            width: 90%;
            max-width: 1000px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 15px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            object-fit: cover;
        }

        button, input[type="submit"] {
            padding: 8px 12px;
            background-color: #007bff;
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        input[type="submit"]:hover,
        button:hover {
            background-color: #0056b3;
        }

        form {
            display: inline-block;
        }

        /* Modal Styling */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.5);
        }

        .modal-content {
            background-color: white;
            margin: 8% auto;
            padding: 30px;
            width: 400px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.2);
        }

        .modal-content h3 {
            margin-top: 0;
            color: #333;
        }

        .modal-content label {
            display: block;
            margin-top: 10px;
            color: #555;
        }

        .modal-content input[type="text"],
        .modal-content input[type="email"] {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .modal-content input[type="submit"] {
            width: 100%;
            margin-top: 20px;
            padding: 10px;
        }

        .close {
            float: right;
            font-size: 24px;
            cursor: pointer;
            color: #aaa;
        }

        .close:hover {
            color: #000;
        }
    </style>
</head>
<body>

<h2>All Registered Users</h2>

<div class="table-container">
    <table>
        <tr>
            <th>Image</th>
            <th>Username</th>
            <th>Email</th>
            <th>Mobile</th>
            <th>Actions</th>
        </tr>
        <%
            List<User> users = (List<User>) request.getAttribute("userList");
            if (users != null) {
                for (User user : users) {
        %>
        <tr>
             <td><img src="<%= user.getFilePath() %>" width="80" height="80"/></td>
            <td><%= user.getUsername() %></td>
            <td><%= user.getEmail() %></td>
            <td><%= user.getMobile() %></td>
            <td>
                <button onclick="openModal('<%= user.getUsername() %>', '<%= user.getEmail() %>', '<%= user.getMobile() %>')">Update</button>
                <form action="delete" method="POST" onsubmit="return confirm('Are you sure?');">
                    <input type="hidden" name="email" value="<%= user.getEmail() %>" />
                    <input type="submit" value="Delete" />
                </form>
            </td>
        </tr>
        <%
                }
            }
        %>
    </table>
</div>

<!-- Modal -->
<div id="updateModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <h3>Update User</h3>
        <form action="update" method="POST">
            <label for="modalUsername">Username:</label>
            <input type="text" name="username" id="modalUsername" required />

            <label for="modalEmail">Email:</label>
            <input type="text" name="email" id="modalEmail" required readonly />

            <label for="modalMobile">Mobile:</label>
            <input type="text" name="mobile" id="modalMobile" required />

            <input type="submit" value="Update" />
        </form>
    </div>
</div>

<script>
    function openModal(username, email, mobile) {
        document.getElementById('modalUsername').value = username;
        document.getElementById('modalEmail').value = email;
        document.getElementById('modalMobile').value = mobile;
        document.getElementById('updateModal').style.display = 'block';
    }

    function closeModal() {
        document.getElementById('updateModal').style.display = 'none';
    }

    window.onclick = function(event) {
        const modal = document.getElementById('updateModal');
        if (event.target === modal) {
            closeModal();
        }
    }
</script>

</body>
</html>


