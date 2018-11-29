<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>User Account Page</title>
</head>
<body>
	<%
	String email = null; 
	email = request.getParameter("email");
	
	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_ncukiert;";
	String uid = "ncukiert";
	String pw = "41776162";
	
	try {	// Load driver class
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	}
	catch (java.lang.ClassNotFoundException e) {
		out.println("ClassNotFoundException: " +e);
	}
	try(Connection con = DriverManager.getConnection(url, uid, pw);) {
		String SQL = "SELECT * FROM Customers WHERE email = ?";
		PreparedStatement prpStmt = con.prepareStatement(SQL);
		prpStmt.setString(1, email);
		ResultSet rstl = prpStmt.executeQuery();
		
	} catch(Exception e) {
		e.printStackTrace();
	}
	
	%>
</body>
</html>