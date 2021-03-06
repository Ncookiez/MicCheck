<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
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
	
</head>
<body  class="background">

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
	<div class="container main" style="padding-top: 85px">
		<div class="row textFont">
		
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
	    			</div>
	    			<div class="form-group size labelAlign">
	    				<label for="cityInput">City: </label>
	    				<input type="text" class="form-control" id="cityInput" name="cityInput" value="<% out.print(city); %>" required>
	    			</div>
	    			<div class="form-group size labelAlign">
	    				<label for="provinceInput">Province: </label>
	    				<input type="text" class="form-control" id="provinceInput" name="provinceInput" value="<% out.print(province); %>" required>
	 				</div>
	 				<div class="text-center"><button type="submit" class="btn btn-primary">Make Changes</button></div>
				</form>
			</div>
			
			<%
			
			// Customer/Orders SQL Queries:
			int sNum = 0;
			double money = 0;
			ArrayList<String> customers = new ArrayList<>();
			rSet = stmt.executeQuery("SELECT email FROM PurchasedProduct, Purchase WHERE PurchasedProduct.orderNum = Purchase.orderNum AND pID IN (SELECT pID FROM Instrument WHERE sID = '" + sid + "') GROUP BY email");
			while(rSet.next()) { customers.add(rSet.getString(1)); }
			rSet = stmt.executeQuery("SELECT (quantity * price) AS totalPrice FROM PurchasedProduct WHERE pID IN (SELECT pID FROM Instrument WHERE sID = '" + sid + "')");
			while(rSet.next()) { sNum++; money = money + rSet.getDouble(1); }
			
			%>
			
			<!-- Customer/Order Info -->
			<div class="col-md-6 text-center">
				<h3><strong>Number of Sales:</strong><br> <% out.print(sNum); %></h3>
				<h3><strong>Total Revenue:</strong><br> $<% out.print(money); %></h3>
				<br>
				<h4><strong>List of Customers:</strong></h4>
				<br>
				<% for(String c: customers) { out.print("<p>" + c + "</p>"); } %>
			</div>
		</div>
		
		<%
			
		// Product Queries:
		int x = 0;
		ArrayList<Integer> productIds = new ArrayList<>();
		ArrayList<String> products = new ArrayList<>();
		rSet = stmt.executeQuery("SELECT pID, title FROM Instrument WHERE sID = '" + sid + "'");
		while(rSet.next()) { productIds.add(rSet.getInt(1)); products.add(rSet.getString(2)); }
		
		%>
		
		<!-- Product List -->
		<div class="row textFont">
			<div class="col-md-12 text-center">
				<hr>
				<h3>List of Products:</h3>
				<% for(String p: products) { out.print("<a href=\"adminItem.jsp?sid=" + sid + "&pid=" + productIds.get(x++) + "\" class=\"btn-sm btn-primary\" role=\"button\">" + p + "</a><br><br>"); } %>
				<hr>
				<a href="adminAdd.jsp?sid=<% out.print(sid); %>" class="btn btn-success" role="button">Add Product</a>
			</div>
		</div>
	</div>
	
	<%
	
	// Updating Seller Info:
	String i = request.getParameter("i");
	if(i != null && i != "null") {
		name = request.getParameter("nameInput");
		street = request.getParameter("streetInput");
		city = request.getParameter("cityInput");
		province = request.getParameter("provinceInput");
		stmt.executeUpdate("UPDATE Seller SET name = '" + name + "', street = '" + street + "', city = '" + city + "', province = '" + province + "' WHERE sID = '" + sid + "'");
	}
	
	// Closing Connection:
	con.close();
	
	%>
	
</body>
</html>