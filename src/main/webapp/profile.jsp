<%@ page import="org.example.servletcrudapp.model.User" %><%--
  Created by IntelliJ IDEA.
  User: Asiri
  Date: 4/16/2025
  Time: 1:32 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>

<p>User Name:<%= ((User) request.getAttribute("userData")).getUsername() %></p>
<body>

</body>
</html>
