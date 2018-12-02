<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="triepackage.Trie" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Product Edit Page</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="MicCheck.css">
	<link rel="stylesheet" type="text/css" href="NCss.css">
	<link href="https://fonts.googleapis.com/css?family=Cairo|Lobster" rel="stylesheet">
	
</head>
<body>

	<% String sid = request.getParameter("sid"); %>
	<% String pid = request.getParameter("pid"); %>
	
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
	ResultSet rSet = stmt.executeQuery("SELECT title, description, category, price, cond, brand, year, tags FROM Instrument WHERE pID = '" + pid + "'");
	
	// Setting variables for specific instrument:
	rSet.next();
	String title = rSet.getString(1);
	String desc = rSet.getString(2);
	String cat = rSet.getString(3);
	String price = "" + rSet.getDouble(4);
	String cond = "" + rSet.getInt(5);
	String brand = rSet.getString(6);
	String year = "" + rSet.getInt(7);
	String tags = rSet.getString(8);
	
	%>
	
	<!-- Edit Product Info Form -->
	<div class="container main" style="padding-top: 85px; margin: 0 auto">
		<div class="row textFont">
			<div class="col-md-3"></div>
			<div class="col-md-6">
				<form action="adminItem.jsp" method="get">
					<div><input type="text" class="form-control" id="sid" name="sid" value="<% out.print(sid); %>" style="display: none"></div>
					<div><input type="text" class="form-control" id="i" name="i" value="true" style="display: none"></div>
					<div><input type="text" class="form-control" id="pid" name="pid" value="<% out.print(pid); %>" style="display: none"></div>
	  				<div class="form-group size labelAlign">
	    				<label for="titleInput">Name: </label>
	    				<input type="text" class="form-control" id="titleInput" name="titleInput" value="<% out.print(title); %>">
	    			</div>
	    			<div class="form-group size labelAlign">
	    				<label for="descInput">Description: </label>
	    				<textarea class="form-control" id="descInput" name="descInput" rows="3"><% out.print(desc); %></textarea>
	    			</div>
	    			<div class="form-group size labelAlign">
	    				<label for="catInput">Category: </label>
	    				<input type="text" class="form-control" id="catInput" name="catInput" value="<% out.print(cat); %>">
	    			</div>
	    			<div class="form-group size labelAlign">
	    				<label for="priceInput">Price: </label>
	    				<input type="text" class="form-control" id="priceInput" name="priceInput" value="<% out.print(price); %>">
	    			</div>
	    			<div class="form-group size labelAlign">
	    				<label for="condInput">Condition: </label>
	    				<input type="text" class="form-control" id="condInput" name="condInput" value="<% out.print(cond); %>">
	    			</div>
	    			<div class="form-group size labelAlign">
	    				<label for="brandInput">Brand: </label>
	    				<input type="text" class="form-control" id="brandInput" name="brandInput" value="<% out.print(brand); %>">
	    			</div>
	    			<div class="form-group size labelAlign">
	    				<label for="yearInput">Year: </label>
	    				<input type="text" class="form-control" id="yearInput" name="yearInput" value="<% out.print(year); %>">
	    			</div>
	    			<div class="form-group size labelAlign">
	    				<label for="tagsInput">Tags: </label>
	    				<input type="text" class="form-control" id="tagsInput" name="tagsInput" value="<% out.print(tags); %>">
	 				</div>
	 				<div style="margin-left: 35px; width: 80%" class="text-center">
	 					<button type="submit" class="btn btn-primary">Make Changes</button>
	 					<a href="adminDelete.jsp?pid=<% out.print(pid); %>&sid=<% out.print(sid); %>" class="btn btn-danger" role="button">Delete Product</a>
	 				</div>
				</form>
			</div>
		</div>
	</div>
	
	<%
	
	// Updating Item Info:
	String i = request.getParameter("i");
	if(i != null && i != "null") {
		title = request.getParameter("titleInput");
		desc = request.getParameter("descInput");
		cat = request.getParameter("catInput");
		price = request.getParameter("priceInput");
		cond = request.getParameter("condInput");
		brand = request.getParameter("brandInput");
		year = request.getParameter("yearInput");
		tags = request.getParameter("tagsInput");
		stmt.executeUpdate("UPDATE Instrument SET title = '" + title + "', description = '" + desc + "', category = '" + cat + "', price = '" + price + "', cond = '" + cond + "', brand = '" + brand + "', year = '" + year + "', tags = '" + tags + "' WHERE pID = '" + pid + "'");
		Trie trie = new Trie(application.getRealPath("/") + "searchTrie.xml");
		trie.remove(Integer.parseInt(pid));
		trie.addProduct(Integer.parseInt(pid));
		trie.writeTrie(application.getRealPath("/") + "searchTrie.xml");
		response.setStatus(response.SC_MOVED_TEMPORARILY);
		response.setHeader("Location", "admin.jsp?sid=" + sid);
	}
	
	// Closing Connection:
	con.close();
	
	%>
	
</body>
</html>