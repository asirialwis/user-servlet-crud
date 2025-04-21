<%--
  Created by IntelliJ IDEA.
  User: Asiri
  Date: 4/21/2025
  Time: 10:41 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.List" %>
<%@ page import="org.example.servletcrudapp.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User List</title>
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
        List<User> users = (List<User>) request.getAttribute("userList");  // Note: attribute is "userList" set in servlet
        if (users != null) {
            for (User user : users) {
    %>
    <tr>
        <td><img src="<%= user.getFilePath() %>" width="80" height="80"/></td>
        <td><%= user.getUsername() %></td>
        <td><%= user.getEmail() %></td>
        <td><%= user.getMobile() %></td>
        <td>
            <form action="update.jsp" method="GET" style="display:inline;">
                <input type="hidden" name="email" value="<%= user.getEmail() %>" />
                <input type="submit" value="Update" />
            </form>
            <form action="delete" method="POST" style="display:inline;"
                  onsubmit="return confirm('Are you sure?');">
                <input type="hidden" name="email" value="<%= user.getEmail() %>" />
                <input type="submit" value="Delete" />
            </form>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr><td colspan="5">No users found.</td></tr>
    <%
        }
    %>

</table>

</body>
</html>

