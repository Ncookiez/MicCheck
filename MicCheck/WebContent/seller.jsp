<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="MicCheck.css">
	<link href="https://fonts.googleapis.com/css?family=Cairo|Lobster" rel="stylesheet">
	<title>Seller Page</title>
	
</head>
<body>

	<%
	String seller = request.getParameter("sID");
	String email = request.getParameter("email");
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
	          <a href="#" class="dropdown-toggle instruments-dropdown dropbtn" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Instruments <span class="caret"></span></a>
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
	    	<!-- Add 'form-homepage' to the class for the div listed directly below -->
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
	
	<%
	String sellerName = null;
	String sellerStreet = null;
	String sellerCity = null;
	String sellerProvince = null;
	double sellerRating = 0;
	
	try(Connection con = DriverManager.getConnection(url, uid, pw);) {
		String SQL = "SELECT name, street, city, province, rating FROM Seller WHERE sid='" + seller + "'";
		Statement stmt = con.createStatement();
		ResultSet rstl = stmt.executeQuery(SQL);
		
		rstl.next();
		sellerName = rstl.getString(1);
		sellerStreet = rstl.getString(2);
		sellerCity = rstl.getString(3);
		sellerProvince = rstl.getString(4);
		sellerRating = rstl.getDouble(5);
	} catch(Exception e) {
		e.printStackTrace();
	}
	%>
	
	<div class="container" style="padding-top: 80px;">
		<div class="row">
			<div class="col-md-1"></div>
			<div class="col-md-5">
				<div class="column thumbnail thumbnail-user"></div>
				<br>
			</div>
			<div class="col-md-5 seller-text">
				<%out.println("<h1>" + sellerName + "</h1>"); %>
				<hr>
				<br>
				<div class="panel panel-default">
					<div class="panel-heading">
						<h4>Seller's Address:</h4>
					</div>
					<div class="panel-body">
						<%out.println(sellerStreet + " " + sellerCity + " " + sellerProvince);%>
					</div>
				</div>
				<div class="panel panel-default">
					<div class="panel-heading">
						<h4>Rating:</h4>
					</div>
					<div class="panel-body">
						<%out.println(sellerRating); %>
					</div>
				</div>
			</div>
		</div>
		<hr>
		<div class="row" style="padding-bottom: 30px;">
			<div class="col-md-2"></div>
			<div class="col-md-10">
			<h2 class="seller-text">Listings by Seller</h2>
			<br>
			<table class="seller-text">
				<th></th><th>Instruments</th><th>Category</th><th>Condition</th><th>Price</th>
				<%
				NumberFormat currFormat = NumberFormat.getCurrencyInstance();
				
				int productId = 0;
				String productName = null;
				String productCategory = null;
				float productPrice = 0;
				String productCondition = null;
				
				try(Connection con = DriverManager.getConnection(url, uid, pw);) {
					Statement stmt = con.createStatement();
					ResultSet rstl = stmt.executeQuery("SELECT pID, title, category, price, condition FROM Instrument WHERE sid='" + seller + "'");
					while(rstl.next()) {
						productId = rstl.getInt(1);
						productName = rstl.getString(2);
						productCategory = rstl.getString(3);
						productPrice = rstl.getFloat(4);
						productCondition = rstl.getString(5);
						String link = "<a href='item.jsp?pID=" + productId + "&email=" + email + "' class='col-xs-6 col-md-3'><h3>View Instrument</h3></a>";
						out.println("<tr><td>" + link + "</td><td>" + productName + "</td><td>" + productCategory + "</td><td>" + (productCondition.charAt(0) == '1' ? "New" : "Used") + "</td><td>" + currFormat.format(productPrice) + "</td></tr>");
					}
				} catch(Exception e) {
					e.printStackTrace();
				}
				%>
			</table>
			
			</div>
		</div>
	</div>
	
	<script src="http://code.jquery.com/jquery-3.3.1.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>	
</body>
</html>