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
		function emailAlert() { alert("The email you entered does not have an account."); }
		function passAlert() { alert("The password you entered is wrong. Please try again."); }
	</script>
	
</head>
<body>
	
	<!-- Login Box -->
	<div class="container margin">
		<div class="row">
			<div class="col-md-4"></div>
			<div class="col-md-4 text-center box text">
				<a class="logo" href="homepage.jsp">MicCheck</a>
				<h3>Login Page</h3>
				<br>
				<form action="login.jsp" method="get">
	  				<div class="form-group size labelAlign">
	    				<label for="emailInput">Email Address: </label>
	    				<input type="text" class="form-control" id="emailInput" name="emailInput" required>
	 				</div>
	  				<div class="form-group size labelAlign">
			    		<label for="passInput">Password: </label>
			    		<input type="password" class="form-control" id="passInput" name="passInput" required>
			  		</div>
			  		<button type="submit" class="btn btn-primary">Log In</button>
				</form>
				<br>
				<a style="color: white" href="signup.jsp">Click here to sign up.</a>
			</div>
		</div>
	</div>

	<%

	// Initializations:
	String email = request.getParameter("emailInput");
	String password = request.getParameter("passInput");
	boolean emailCheck = false;
	boolean passCheck = false;
	int i = 0;
	String serverPass = null;
	
	// Exception for Admin Login:
	if(email != null) {
		if(email.equals("Admin") && password.equals("admin")) {
			response.setStatus(response.SC_MOVED_TEMPORARILY);
			response.setHeader("Location", "siteManager.jsp");
		}
	}
	
	// Preparing SQL Connection:
	String url = "jdbc:mysql://173.194.107.58/MicCheck";
	String uid = "Ncookie";
	String pw = "miccheck";
	Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();
	ResultSet rSet = stmt.executeQuery("SELECT email, password FROM Customers WHERE email = '" + email + "'");
	
	// Email & Password Validation:
	if(email != null) {
		while(rSet.next()) {
			serverPass = rSet.getString(2);
			emailCheck = true;
			i++;
		}
		if(i == 0) {
			%><script>emailAlert();</script><%
		}
	}
	
	// Password validation:
	if(password != null && emailCheck) {
		if(password.equals(serverPass)) {
			passCheck = true;
		} else {
			%><script>passAlert();</script><%
		}
	}
	
	// Logging user in and redirecting to home page:
	if(emailCheck && passCheck) {
		response.setStatus(response.SC_MOVED_TEMPORARILY);
		response.setHeader("Location", "homepage.jsp?email=" + email);
	}
	
	// Closing Connection:
	con.close();
	
	%>
	
</body>
</html>