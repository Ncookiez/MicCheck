<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	<link href="https://fonts.googleapis.com/css?family=Cairo|Lobster" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="MicCheck.css">
	<title>User Account Page</title>
	
	<style>
	.cart-thumbnail {
		background: url("Images/icon-1415760_960_720.png");
		background-size: cover; 
		height: 150px;
		width: 150px
	}
	.info-thumbnail {
		background: url("Images/tag-1873545_960_720.png");
		background-size: cover; 
		height: 150px;
		width: 150px
	}
	.edit-thumbnail {
		background: url("Images/cyber-security-1915629_960_720.png");
		background-size: cover; 
		height: 150px;
		width: 150px
	}
	.column_1 {
		padding-top: 20px;
		text-align:center;
		font-family: 'Cairo', sans-serif;
		font-size: 18px;
		color: black;
	}
	.column_2 {
		padding-top: 30px;
		text-align:center;
		font-family: 'Cairo', sans-serif;
		font-size: 18px;
		color: black;
	}
	.inner-row {
		border: 1px solid #021a40;
	}
	.account-name {
		font-family: 'Cairo', sans-serif;
		font-weight: bold;
		color: black;
	}
	.container-account-info {
		padding-top: 70px;
		padding-bottom: 30px;
		padding-right: 15px;
		padding-left: 15px;
	}
	</style>
</head>
<body>
	<%
	String email = null; 
	email = request.getParameter("email");
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
	            <li><a href="results.jsp?search=Guitar">Guitar</a></li>
	            <li><a href="results.jsp?search=Bass">Bass</a></li>
	            <li><a href="results.jsp?search=Keyboard">Keyboard</a></li>
	            <li><a href="results.jsp?search=Percussion">Percussion</a></li>
	            <li class="dropdown-submenu">
	            	<a>Orchestral</a>
	            	<ul class="dropdown-menu">
	            		<li><a href="results.jsp?search=Brass">Brass</a></li>
	            		<li><a href="results.jsp?search=Strings">Strings</a></li>
	            		<li><a href="results.jsp?search=Woodwind">Woodwind</a></li>
	            	</ul>
	            </li>
	          </ul>
	        </li>
	      </ul>
	      <form class="navbar-form navbar-left" method="get" action="results.jsp">
	        <div class="form-group form-homepage">
	          <input type="text" class="form-control" placeholder="Search for your next instrument" name="search" style="width: 100%; height: 40px;">
	        </div>
	        <button type="submit" class="btn btn-default submit-btn" href="results.jsp">Submit</button>
	      </form>
	      <ul class="nav navbar-nav navbar-right">
	      	<li><a href="shoppingcart.jsp"><span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span> Cart </a></li>
	        <%	        
			if(email == null || email.equals("null")) {
				out.println("<li><a href='signup.jsp'> Sign Up </a></li>");
				out.println("<li><a href='login.jsp'><span class='glyphicon glyphicon-user' aria-hidden='true'></span> Log in </a></li>");
			}
			String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_ncukiert;";
			String uid = "ncukiert";
			String pw = "41776162";
			
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
					out.println("<li><a href='useraccount.jsp?email=" + email + "'><span class='glyphicon glyphicon-user' aria-hidden='true'></span> " + rstl.getString(1) + "</a></li>");
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
			%>
	      </ul>
	    </div><!-- /.navbar-collapse -->
	  </div><!-- /.container-fluid -->
	</nav>
	
	<div class="container container-account-info">
		<div class="your-account">
		<% 
		url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_ncukiert;";
		uid = "ncukiert";
		pw = "41776162";
		
		String name = null;
		
		try {	// Load driver class
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		}
		catch (java.lang.ClassNotFoundException e) {
			out.println("ClassNotFoundException: " +e);
		}
		try(Connection con = DriverManager.getConnection(url, uid, pw);) {
			String SQL = "SELECT name FROM Customers WHERE email = ?";
			PreparedStatement prpStmt = con.prepareStatement(SQL);
			prpStmt.setString(1, email);
			ResultSet rstl = prpStmt.executeQuery();
			while(rstl.next()) {
				name = rstl.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} 
		%>
			<%out.println("<h1 class='account-name'>" + name + "'s Account</h1>");%>		
			<br>
		</div>
		<div class="row">
			<%out.print("<a href='shoppingcart.jsp?email=" + email + "' class='col-sm-4'>");%>
				<div class="row inner-row">
					<div class="column cart-thumbnail col-sm-3"></div>
					<div class="column_1">
						<h3>View items in cart</h3>
					</div>
				</div>
			</a> 
			<%out.print("<a href='userinfo.jsp?email=" + email + "' class='col-sm-4'>"); %>
				<div class="row inner-row">
					<div class="column info-thumbnail col-sm-3"></div>
					<div class="column_1">
						<h3>Shipping and Billing info</h3>
					</div>
				</div>
			</a>
			<%out.print("<a href='editinfo.jsp?email=" + email + "' class='col-sm-4'>"); %>
				<div class="row inner-row">
					<div class="column edit-thumbnail col-sm-3"></div>
					<div class="column_2">
						<h3>Edit information</h3>
					</div>
				</div>
			</a>	
		</div>
	</div>

	<script src="http://code.jquery.com/jquery-3.3.1.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>	
</body>
</html>