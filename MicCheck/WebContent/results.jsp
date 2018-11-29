<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Results Page</title>
</head>
<body>
	<%
	//Getting the instrument type passed by pressing the button from the dropdown menu
	String result = request.getParameter("search");
	out.println("<h1>" + result + "</h1>");
	%>
</body>
</html>