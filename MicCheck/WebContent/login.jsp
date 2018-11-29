<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Login Page</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	
	<style>
		/* TODO */
	</style>
	
	<script>
		function emailAlert() { alert("The email you entered does not have an account."); }
		function passAlert() { alert("The password you entered is wrong. Please try again."); }
	</script>
	
</head>
<body>

	<nav class="navbar navbar-default">
		<div class="container-fluid">
	    	<div class="navbar-header">
	    		<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
	        		<span class="sr-only">Toggle navigation</span>
	        		<span class="icon-bar"></span>
	        		<span class="icon-bar"></span>
	        		<span class="icon-bar"></span>
	      		</button>
	      		<a class="navbar-brand navbar-title" href="#">MicCheck</a>
	    	</div>
	    	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	    		<ul class="nav navbar-nav">
	    			<li class="dropdown">
	    				<a href="#" class="dropdown-toggle instruments-dropdown dropbtn" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Instruments <span class="caret"></span></a>
    					<ul class="dropdown-menu">
    						<li><a href="#">Guitar</a></li>
            				<li><a href="#">Bass</a></li>
			            	<li><a href="#">Keyboard</a></li>
				            <li><a href="#">Percussion</a></li>
				            <li class="dropdown-submenu">
            					<a href="#">Orchestral</a>
            					<ul class="dropdown-menu">
				            		<li><a href="#">Brass</a></li>
				            		<li><a href="#">Strings</a></li>
				            		<li><a href="$">Woodwind</a></li>
            					</ul>
            				</li>
          				</ul>
	        		</li>
	      		</ul>
	      		<form class="navbar-form navbar-left">
	        		<div class="form-group">
	          			<input type="text" class="form-control" placeholder="Search for your next instrument" style="width: 599px; height: 40px;">
	        		</div>
	        	<button type="submit" class="btn btn-default submit-btn">Submit</button>
	      		</form>
	      		<ul class="nav navbar-nav navbar-right">
	      			<li><a href="shoppingcart.jsp"><span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span> Cart </a></li>
	      	<li><a href="signup.jsp"> Sign Up </a></li>
	        <li><a href="login.jsp"><span class="glyphicon glyphicon-user" aria-hidden="true"></span> Log in </a></li>
	      </ul>
	    </div><!-- /.navbar-collapse -->
	  </div><!-- /.container-fluid -->
	</nav>

	<h1>Login Page</h1>
	
	<div class="container">
		<form action="login.jsp" method="get">
	  		<div class="form-group">
	    		<label for="emailInput">Email Address: </label>
	    		<input type="email" class="form-control" id="emailInput" name="emailInput" required>
	 		</div>
	  		<div class="form-group">
	    		<label for="passInput">Password: </label>
	    		<input type="password" class="form-control" id="passInput" name="passInput" required>
	  		</div>
	  		<button type="submit" class="btn btn-primary">Log In</button>
		</form>
		<a href="signup.jsp">Create a new account.</a>
	</div>

	<%

	// Initializations:
	String email = request.getParameter("emailInput");
	String password = request.getParameter("passInput");
	boolean emailCheck = false;
	boolean passCheck = false;
	int i = 0;
	String serverPass = null;
	
	// Preparing SQL Connection:
	try { Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver"); } catch(java.lang.ClassNotFoundException e) { out.println("ClassNotFoundException: " + e); }
	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_ncukiert;";
	String uid = "ncukiert";
	String pw = "41776162";
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