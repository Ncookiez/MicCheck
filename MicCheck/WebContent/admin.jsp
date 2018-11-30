<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Your Selling Page</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="MicCheck.css">
	<link rel="stylesheet" type="text/css" href="NCss.css">
	<link href="https://fonts.googleapis.com/css?family=Cairo|Lobster" rel="stylesheet">
	
	<!--
	Implementation:
	seller info in forms, make changes button to update
	number of customers
	list of customers in spoiler
	number of sales, total money
	list of products with edit and delete for each
	edit button opens item info page with make changes button to return to seller page
	-->
	
</head>
<body>

	<% String sid = request.getParameter("sid"); %>
	
	<!-- Navbar -->
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="container-fluid">
			<div class="navbar-header">
	      		<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
	        		<span class="sr-only">Toggle navigation</span>
	        		<span class="icon-bar"></span>
	        		<span class="icon-bar"></span>
	        		<span class="icon-bar"></span>
	      		</button>
	      		<a class='navbar-brand navbar-title' href='homepage.jsp'>MicCheck</a>
	    	</div>
	    	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	      		<ul class="nav navbar-nav navbar-right">
	      			<% out.println("<li><a href='admin.jsp?sid=" + sid + "'><span class='glyphicon glyphicon-user' aria-hidden='true'></span> Your Account </a></li>"); %>
	      		</ul>
	    	</div>
	  	</div>
	</nav>
	
	<%
	
	// Preparing SQL Connection:
	try { Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver"); } catch(java.lang.ClassNotFoundException e) { out.println("ClassNotFoundException: " + e); }
	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_ncukiert;";
	String uid = "ncukiert";
	String pw = "41776162";
	Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();
	ResultSet rSet = stmt.executeQuery("SELECT name, street, city, province, rating FROM Seller WHERE sID = '" + sid + "'");
	
	// Setting variables for specific seller:
	rSet.next();
	String name = rSet.getString(1);
	String street = rSet.getString(2);
	String city = rSet.getString(3);
	String province = rSet.getString(4);
	double rating = rSet.getDouble(5);
	
	%>
	
	<!-- Admin Page -->
	<div class="container" style="padding-top: 85px">
		<div class="row">
		
			<!-- Seller Info -->
			<div class="col-md-6">
				<form action="admin.jsp" method="get">
					<div><input type="text" class="form-control" id="sid" name="sid" value="<% out.print(sid); %>" style="display: none"></div>
					<div><input type="text" class="form-control" id="i" name="i" value="true" style="display: none"></div>
	  				<div class="form-group size labelAlign">
	    				<label for="nameInput">Name: </label>
	    				<input type="text" class="form-control" id="nameInput" name="nameInput" value="<% out.print(name); %>" required>
	 				</div>
	 				<div class="form-group size labelAlign">
	    				<label for="streetInput">Street: </label>
	    				<input type="text" class="form-control" id="streetInput" name="streetInput" value="<% out.print(street); %>" required>
	    				<label for="cityInput">City: </label>
	    				<input type="text" class="form-control" id="cityInput" name="cityInput" value="<% out.print(city); %>" required>
	    				<label for="provinceInput">Province: </label>
	    				<input type="text" class="form-control" id="provinceInput" name="provinceInput" value="<% out.print(province); %>" required>
	 				</div>
	 				<div class="text-center"><button type="submit" class="btn btn-primary">Make Changes</button></div>
				</form>
			</div>
			
			<!-- Customer/Order Info -->
			<div class="col-md-6">
				<!-- TODO -->
			</div>
		</div>
		
		<!-- Product List -->
		<div class="row">
			<div class="col-md-12">
				<!-- TODO -->
			</div>
		</div>
	</div>
	
	<%
	
	// Updating Seller Info:
	String i = request.getParameter("i");
	if(i.equals("true")) {
		name = request.getParameter("name");
		street = request.getParameter("street");
		city = request.getParameter("city");
		province = request.getParameter("province");
		stmt.executeUpdate("UPDATE Seller SET name = " + name + ", street = " + street + ", city = " + city + ", province = " + province + " WHERE sid = " + sid);
	}
	
	// Closing Connection:
	con.close();
	
	%>
	
</body>
</html>