<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello Asiri</title>
</head>
<body>
<h1><%= "Hello Asiri!" %>
</h1>
<br/>

<%! Date date = new Date(); %>
<%! String text = "The current date and time is "; %>

<a href="hello-servlet">Hello Servlet</a>
</body>
</html>