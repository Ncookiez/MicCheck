<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Login Page</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="MicCheck.css">
	<link rel="stylesheet" type="text/css" href="NCss.css">
	<link href="https://fonts.googleapis.com/css?family=Cairo|Lobster" rel="stylesheet">
	
	<script>
		function sidAlert() { alert("The seller ID you entered is not valid."); }
	</script>
	
</head>
<body  class="background">
	
	<!-- Login Box -->
	<div class="container margin">
		<div class="row textFont">
			<div class="col-md-4"></div>
			<div class="col-md-4 text-center box text">
				<a class="logo" href="homepage.jsp">MicCheck</a>
				<h3>Seller Login Page</h3>
				<br>
				<form action="adminLogin.jsp" method="get">
	  				<div class="form-group size labelAlign">
	    				<label for="sidInput">Seller ID: </label>
	    				<input type="text" class="form-control" id="sidInput" name="sidInput" required>
	 				</div>
			  		<button type="submit" class="btn btn-primary">Log In</button>
				</form>
			</div>
		</div>
	</div>

	<%

	// Initializations:
	String sid = request.getParameter("sidInput");
	boolean sidCheck = false;
	int i = 0;
	
	try
	{	// Load driver class
		Class.forName("com.mysql.jdbc.Driver");
	}
	catch (java.lang.ClassNotFoundException e)
	{
		out.println("ClassNotFoundException: " +e);
	}
	
	// Preparing SQL Connection:
	String url = "jdbc:mysql://173.194.107.58/MicCheck";
	String uid = "Ncookie";
	String pw = "miccheck";
	Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();
	ResultSet rSet = stmt.executeQuery("SELECT sID FROM Seller WHERE sID = '" + sid + "'");
	
	// Seller ID Validation:
	if(sid != null) {
		while(rSet.next()) {
			sidCheck = true;
			i++;
		}
		if(i == 0) {
			%><script>sidAlert();</script><%
		}
	}
	
	// Logging user in and redirecting to home page:
	if(sidCheck) {
		response.setStatus(response.SC_MOVED_TEMPORARILY);
		response.setHeader("Location", "admin.jsp?sid=" + sid);
	}
	
	// Closing Connection:
	con.close();
	
	%>
	
</body>
</html>