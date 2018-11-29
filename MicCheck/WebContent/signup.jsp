<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Sign Up Page</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	
	<style>
		/* TODO */
	</style>
	
	<script>
		function emailAlert() { alert("Please input a unique email address."); }
		function emailLengthAlert() { alert("Your email cannot be longer than 30 characters."); }
		function passAlert() { alert("Please input a password of at least 8 digits."); }
		function passLengthAlert() { alert("Your password cannot be longer than 30 characters."); }
		function nameAlert() { alert("Your name cannot be longer than 50 characters."); }
		function streetAlert() { alert("Your street name cannot be longer than 50 characters."); }
		function cityAlert() { alert("Your city name cannot be longer than 20 characters."); }
		function provAlert() { alert("Your province name cannot be longer than 2 characters."); }
	</script>
	
</head>
<body>

	<h1>Sign Up Page</h1>
	
	<div class="container">
		<form action="signup.jsp" method="get">
	  		<div class="form-group">
	    		<label for="emailInput">Email Address: </label>
	    		<input type="email" class="form-control" id="emailInput" name="emailInput" required>
	 		</div>
	  		<div class="form-group">
	    		<label for="passInput">Password: </label>
	    		<input type="password" class="form-control" id="passInput" name="passInput" required>
	  		</div>
	  		<div class="form-group">
	    		<label for="nameInput">Name: </label>
	    		<input type="text" class="form-control" id="nameInput" name="nameInput" required>
	  		</div>
	  		<div class="form-group">
	  			<h3>Shipping Address:</h3> 
	    		<label for="sStreetInput">Street: </label>
	    		<input type="text" class="form-control" id="sStreetInput" name="sStreetInput" required>
	    		<label for="sCityInput">City: </label>
	    		<input type="text" class="form-control" id="sCityInput" name="sCityInput" required>
	    		<label for="sProvInput">Province: </label>
	    		<input type="text" class="form-control" id="sProvInput" name="sProvInput" required>
	  		</div>
	  		<div class="form-group">
	  			<h3>Billing Address:</h3> 
	    		<label for="bStreetInput">Street: </label>
	    		<input type="text" class="form-control" id="bStreetInput" name="bStreetInput" required>
	    		<label for="bCityInput">City: </label>
	    		<input type="text" class="form-control" id="bCityInput" name="bCityInput" required>
	    		<label for="bProvInput">Province: </label>
	    		<input type="text" class="form-control" id="bProvInput" name="bProvInput" required>
	  		</div>
	  		<button type="submit" class="btn btn-primary">Sign Up</button>
		</form>
		<a href="login.jsp">Already have an account? Click here to login.</a>
	</div>

	<%

	// Initializations:
	String email = request.getParameter("emailInput");
	String password = request.getParameter("passInput");
	String name = request.getParameter("nameInput");
	String shipStreet = request.getParameter("sStreetInput");
	String shipCity = request.getParameter("sCityInput");
	String shipProvince = request.getParameter("sProvInput");
	String billingStreet = request.getParameter("bStreetInput");
	String billingCity = request.getParameter("bCityInput");
	String billingProvince = request.getParameter("bProvInput");
	boolean emailCheck = false;
	boolean passCheck = false;
	boolean nameCheck = false;
	boolean streetCheck = false;
	boolean cityCheck = false;
	boolean provCheck = false;
	int i = 0;
	
	// Preparing SQL Connection:
	try { Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver"); } catch(java.lang.ClassNotFoundException e) { out.println("ClassNotFoundException: " + e); }
	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_ncukiert;";
	String uid = "ncukiert";
	String pw = "41776162";
	Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();
	ResultSet rSet = stmt.executeQuery("SELECT email FROM Customers WHERE email = '" + email + "'");
	
	// Email Validation:
	if(email != null) {
		while(rSet.next()) {
			%><script>emailAlert();</script><%
			i++;
		}
		if(i == 0) {
			if(email.length() <= 30) {
				emailCheck = true;
			} else {
				%><script>emailLengthAlert();</script><%
			}
		}
	}
	
	// Password Validation:
	if(password != null && emailCheck) {
		if(password.length() < 8) {
			%><script>passAlert();</script><%
		} else if(password.length() > 30){
			%><script>passLengthAlert();</script><%
		} else {
			passCheck = true;
		}
	}
	
	// Name Validation:
	if(name != null && passCheck) {
		if(name.length() > 50) {
			%><script>nameAlert();</script><%
		} else {
			nameCheck = true;
		}
	}
	
	// Street Validation:
	if(shipStreet != null && billingStreet != null && nameCheck) {
		if(shipStreet.length() > 50 || billingStreet.length() > 50) {
			%><script>streetAlert();</script><%
		} else {
			streetCheck = true;
		}
	}
	
	// City Validation:
	if(shipCity != null && billingCity != null && streetCheck) {
		if(shipCity.length() > 20 || billingCity.length() > 20) {
			%><script>cityAlert();</script><%
		} else {
			cityCheck = true;
		}
	}
	
	// Province Validation:
	if(shipProvince != null && billingProvince != null && cityCheck) {
		if(shipProvince.length() > 2 || billingProvince.length() > 2) {
			%><script>provAlert();</script><%
		} else {
			provCheck = true;
		}
	}
	
	// Creating account and redirecting user to homepage:
	if(emailCheck && passCheck && nameCheck && streetCheck && cityCheck && provCheck) {
		stmt.executeUpdate("INSERT INTO Customers VALUES ('" + email + "', '" + password + "', '" + name + "', '" + shipStreet + "', '" + shipCity + "', '" + shipProvince + "', '" + billingStreet + "', '" + billingCity + "', '" + billingProvince + "')");
		response.setStatus(response.SC_MOVED_TEMPORARILY);
		response.setHeader("Location", "homepage.jsp?email=" + email);
	}
	
	// Closing Connection:
	con.close();
	
	%>
	
</body>
</html>