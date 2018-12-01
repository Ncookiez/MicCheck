<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Admin Page</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="MicCheck.css">
	<link rel="stylesheet" type="text/css" href="NCss.css">
	<link href="https://fonts.googleapis.com/css?family=Cairo|Lobster" rel="stylesheet">
	
</head>
<body>
	
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
	      			<% out.println("<li><a href='siteManager.jsp'><span class='glyphicon glyphicon-user' aria-hidden='true'></span> Admin</a></li>"); %>
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
	ResultSet rSet = stmt.executeQuery("SELECT sID, name FROM Seller");
	
	%>
	
	<!-- Site Manager Page -->
	<div class="container main" style="padding-top: 85px">
		<div class="row textFont">
		
			<!-- Seller List -->
			<div class="col-xs-12 col-sm-6 text-center">
				<h3>Seller List:</h3>
				<% while(rSet.next()) { out.print("<p>" + rSet.getString(2) + "</p><br>"); } %>
			</div>
			
			<% rSet = stmt.executeQuery("SELECT email FROM Customers"); %>
			
			<!-- User List -->
			<div class="col-xs-12 col-sm-6 text-center">
				<h3>User List:</h3>
				<% while(rSet.next()) { out.print("<p>" + rSet.getString(1) + "</p><br>"); } %>
			</div>
		</div>
		
		<% rSet = stmt.executeQuery("SELECT pid, title FROM Instrument"); %>
		
		<!-- Product List -->
		<div class="row textFont">
			<div class="col-sm-12 col-md-12 text-center">
				<hr>
				<h3>List of Products:</h3>
				<br><br>
				<div class="row">
					<% while(rSet.next()) { out.print("<div class=\"col-xs-6 col-md-4\" style=\"padding-bottom: 30px\"><a href=\"siteManagerItem.jsp?pid=" + rSet.getInt(1) + "\" class=\"btn-sm btn-primary\" role=\"button\">" + rSet.getString(2) + "</a></div>"); } %>
				</div>
				<hr>
				<a href="siteManagerAdd.jsp" class="btn btn-success" role="button">Add Product</a>
			</div>
		</div>
	</div>
	
	<!-- Closing Connection -->
	<% con.close(); %>
	
</body>
</html>