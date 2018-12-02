<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="MicCheck.css">
	<link href="https://fonts.googleapis.com/css?family=Cairo|Lobster" rel="stylesheet">
	<script>
		function streetAlert() { alert("Your street name cannot be longer than 50 characters."); }
		function cityAlert() { alert("Your city name cannot be longer than 20 characters."); }
		function provAlert() { alert("Your province name cannot be longer than 2 characters."); }
	</script>
	
	<style>
		.text {
			font-family: 'Cairo', sans-serif;
		}
		.edit-user-input {
			padding-bottom: 15px;
		}
	</style>
	<title>Edit Information</title>
</head>
<body>
	<%
	String email = null; 
	email = request.getParameter("email");
	String sStreet = null;
	String sCity = null;
	String sProvince = null;
	String bStreet = null;
	String bCity = null;
	String bProvince = null;
	%>
	<nav class="navbar navbar-default navbar-fixed-top">
	  <div class="container-fluid">
	    <!-- Brand and toggle get grouped for better mobile display -->
	    <div class="navbar-header">
	      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
	        <span class="sr-only">Toggle navigation</span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	      </button>
	      <% 
	      out.println("<a class='navbar-brand navbar-title' href='homepage.jsp?email=" + email + "'>MicCheck</a>");
	      %>
	      
	    </div>

	    <!-- Collect the nav links, forms, and other content for toggling -->
	    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	      <ul class="nav navbar-nav">
	        <li class="dropdown">
	          <a class="dropdown-toggle instruments-dropdown dropbtn" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Instruments <span class="caret"></span></a>
	          <ul class="dropdown-menu">
	          	<%
	          	out.print("<li><a href='results.jsp?search=Guitar&email=" + email + "' >Guitar</a></li>");
	    		out.print("<li><a href='results.jsp?search=Bass&email=" + email + "' >Bass</a></li>");
	    		out.print("<li><a href='results.jsp?search=Keyboard&email=" + email + "' >Keyboard</a></li>");
	    		out.print("<li><a href='results.jsp?search=Percussion&email=" + email + "' >Percussion</a></li>");
	          	%>
	            <li class="dropdown-submenu">
	            	<a>Orchestral</a>
	            	<ul class="dropdown-menu">
	            		<%
	            		out.print("<li><a href='results.jsp?search=Brass&email=" + email + "' >Brass</a></li>");
	            		out.print("<li><a href='results.jsp?search=Strings&email=" + email + "' >Strings</a></li>");
	            		out.print("<li><a href='results.jsp?search=Woodwind&email=" + email + "' >Woodwind</a></li>");
	            		%>
	            	</ul>
	            </li>
	          </ul>
	        </li>
	      </ul>
	      <%out.print("<form class='navbar-form navbar-left' method='get' action='results.jsp?email=" + email + "'>"); %>
	    	<!-- Add 'form-homepage' to the class for the div listed directly below -->
	        <div class="form-group form-homepage">
	          <input type="text" class="form-control" placeholder="Search for your next instrument" name="search" style="width: 100%; height: 40px;">
	        </div>
	        <%out.print("<button type='submit' class='btn btn-default submit-btn' href='results.jsp?email=" + email + "'>Search</button>"); %>
	      </form>
	      <ul class="nav navbar-nav navbar-right">
	      	<%out.print("<li><a href='shoppingcart.jsp?email=" + email + "&addingToCart=0'><span class='glyphicon glyphicon-shopping-cart' aria-hidden='true'></span> Cart </a></li>"); %>
	        <%
			email = null;
	        email = request.getParameter("email");	        
			if(email == null || email.equals("null")) {
				out.println("<li><a href='signup.jsp'> Sign Up </a></li>");
				out.println("<li><a href='login.jsp'><span class='glyphicon glyphicon-user' aria-hidden='true'></span> Log in </a></li>");
			}
			String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_ncukiert;";
			String uid = "ncukiert";
			String pw = "41776162";
			String name = null;
			
			try {	// Load driver class
				Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			}
			catch (java.lang.ClassNotFoundException e) {
				out.println("ClassNotFoundException: " +e);
			}
			
			try (Connection con = DriverManager.getConnection(url, uid, pw);) {
				String SQL = "SELECT name FROM Customers WHERE email = ?";
				PreparedStatement prpStmt = con.prepareStatement(SQL);
				prpStmt.setString(1, email);
				ResultSet rstl = prpStmt.executeQuery();
				while(rstl.next()) {
					name = rstl.getString(1);
					out.println("<li><a href='useraccount.jsp?email=" + email + "'><span class='glyphicon glyphicon-user' aria-hidden='true'></span> " + name + "</a></li>");
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
			%>
	      </ul>
	    </div><!-- /.navbar-collapse -->
	  </div><!-- /.container-fluid -->
	</nav>
	
	<% 
	url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_ncukiert;";
	uid = "ncukiert";
	pw = "41776162";
	
	
	try {	// Load driver class
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	}
	catch (java.lang.ClassNotFoundException e) {
		out.println("ClassNotFoundException: " +e);
	}
	try(Connection con = DriverManager.getConnection(url, uid, pw);) {
		String SQL = "SELECT shipStreet, shipCity, shipProvince, billingStreet, billingCity, billingProvince FROM Customers WHERE email = ?";
		PreparedStatement prpStmt = con.prepareStatement(SQL);
		prpStmt.setString(1, email);
		ResultSet rstl = prpStmt.executeQuery();
		rstl.next();
		sStreet = rstl.getString(1);
		sCity = rstl.getString(2);
		sProvince = rstl.getString(3);
		bStreet = rstl.getString(4);
		bCity = rstl.getString(5);
		bProvince = rstl.getString(6);
	} catch(Exception e) {
		e.printStackTrace();
	} 
	%>
	
	<div class="container" style="padding-top:85px;">
		<div class="row">
			<div class="col-md-4"></div>
			<div class="col-md-4 text-center box text">
				<h2>Customer Information</h2>
				<hr>
				<%out.print("<a href='useraccount.jsp?email=" + email +"'>Return to account page</a>"); %>
				<br>
				<form action="editinfo.jsp" method="get"  style="padding-bottom:50px;"> 
			  		<div class="form-group size labelAlign">
			  			<h3>Shipping Address:</h3> 
			  			<div class="edit-user-input">
			  				<label for="sStreetInput">Street: </label>
			    			<input type="text" class="form-control" id="sStreetAltered" name="sStreetAltered" required <%out.print("value='" + sStreet + "'"); %>>
			  			</div>
			  			<div class="edit-user-input">
			  				<label for="sCityInput">City: </label>
			    			<input type="text" class="form-control" id="sCityAltered" name="sCityAltered" required <%out.print("value='" + sCity + "'"); %>>
			  			</div>
			    		<div class="edit-user-input">
			    			<label for="sProvInput">Province: </label>
			    			<input type="text" class="form-control" id="sProvAltered" name="sProvAltered" required <%out.print("value='" + sProvince + "'"); %>>
			    		</div>
			  		</div>
			  		<div class="form-group size labelAlign">
			  			<h3>Billing Address:</h3> 
			  			<div class="edit-user-input">
			  				<label for="bStreetInput">Street: </label>
			    			<input type="text" class="form-control" id="bStreetAltered" name="bStreetAltered" required <%out.print("value='" + bStreet + "'"); %>>
			  			</div>
			    		<div class="edit-user-input">
			    			<label for="bCityInput">City: </label>
			    			<input type="text" class="form-control" id="bCityAltered" name="bCityAltered" required <%out.print("value='" + bCity + "'"); %>>
			    		</div>
			    		<div class="edit-user-input">
			    			<label for="bProvInput">Province: </label>
			    			<input type="text" class="form-control" id="bProvAltered" name="bProvAltered" required <%out.print("value='" + bProvince + "'"); %>>
			    		</div>
			  		</div>
			  		<input type="text" class="form-control" id="email" name="email" <%out.print("value='" + email + "'");%> style="display:none;">
			  		<button type="submit" class="btn btn-primary">Submit</button>
				</form>
			</div>
		</div>
	</div>
	
	<%
	String sStreetNew = request.getParameter("sStreetAltered");
	String sCityNew = request.getParameter("sCityAltered");
	String sProvNew = request.getParameter("sProvAltered");
	String bStreetNew = request.getParameter("bStreetAltered");
	String bCityNew = request.getParameter("bCityAltered");
	String bProvNew = request.getParameter("bProvAltered"); 
	
	boolean streetCheck = false;
	boolean cityCheck = false;
	boolean provCheck = false;
	
	try {	// Load driver class
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	}
	catch (java.lang.ClassNotFoundException e) {
		out.println("ClassNotFoundException: " +e);
	}
	
	url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_ncukiert;";
	uid = "ncukiert";
	pw = "41776162";
	Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();
	
	if(sStreetNew != null && !sStreetNew.equals("null") && bStreetNew != null && !bStreetNew.equals("null")) {
		if(sStreetNew.length() > 50 || bStreetNew.length() > 50) {
			%> <script>streetAlert()</script> <%
		} else {
			streetCheck = true;
		}
	} 
	
	if(sCityNew != null && !sCityNew.equals("null") && bCityNew != null && !bCityNew.equals("null") && streetCheck) {
		if(sCityNew.length() > 20 || bCityNew.length()  > 20) {
			%> <script>cityAlert()</script> <% 
		} else {
			cityCheck = true;
		}
	} 
		
	
	if(sProvNew != null && !sProvNew.equals("null") && bProvNew != null && !bProvNew.equals("null") && cityCheck) {
		if(sProvNew.length() > 2 || bProvNew.length() > 2) {
			%> <script>provAlert()</script> <% 
		} else {
			provCheck = true;
		}
	} 
	
	if(streetCheck && cityCheck && provCheck) {
		stmt.executeUpdate("UPDATE Customers SET shipStreet='" + sStreetNew + "', shipCity='" + sCity + "', shipProvince='" + sProvNew + "', billingStreet='" + bStreetNew + "', billingCity='" + bCityNew + "', billingProvince='" + bProvNew + "' WHERE email='" + email + "';");
		response.setStatus(response.SC_MOVED_TEMPORARILY);
		response.setHeader("Location", "useraccount.jsp?email=" + email);
	} 
	
	con.close();
	%>
	
	<script src="http://code.jquery.com/jquery-3.3.1.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>	
</body>
</html>