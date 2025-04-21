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
        .modal {
            display: none;
            position: fixed;
            z-index: 10;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.5);
        }

        .modal-content {
            background-color: #fefefe;
            margin: 10% auto;
            padding: 20px;
            width: 400px;
            border-radius: 10px;
        }

        .close {
            float: right;
            font-size: 24px;
            cursor: pointer;
        }
    </style>
</head>
<body>

<h2>All Users</h2>
<table border="1">
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
            <form action="delete" method="POST" style="display:inline;" onsubmit="return confirm('Are you sure?');">
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

<!-- Modal -->
<div id="updateModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <h3>Update User</h3>
        <form action="update" method="POST">
            <label>Username:</label>
            <input type="text" name="username" id="modalUsername" required /><br/><br/>
            <label>Email</label>
            <input type="text" name="email" id="modalEmail" required/><br/><br/>
            <label>Mobile:</label>
            <input type="text" name="mobile" id="modalMobile" required /><br/><br/>

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

    // Close modal on outside click
    window.onclick = function(event) {
        const modal = document.getElementById('updateModal');
        if (event.target === modal) {
            closeModal();
        }
    }
</script>

</body>
</html>


