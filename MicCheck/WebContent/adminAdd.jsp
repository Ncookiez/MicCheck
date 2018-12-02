<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="triepackage.Trie" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Product Add Page</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="MicCheck.css">
	<link rel="stylesheet" type="text/css" href="NCss.css">
	<link href="https://fonts.googleapis.com/css?family=Cairo|Lobster" rel="stylesheet">
	
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
	String url = "jdbc:mysql://173.194.107.58/MicCheck";
	String uid = "Ncookie";
	String pw = "miccheck";
	Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();
	ResultSet rSet = stmt.executeQuery("SELECT pID FROM Instrument ORDER BY pID DESC");
	
	// Setting pID for added instrument:
	rSet.next();
	int pid = rSet.getInt(1) + 1;
	
	%>
	
	<!-- Add Product Form -->
	<div class="container main" style="padding-top: 85px; margin: 0 auto">
		<div class="row textFont">
			<div class="col-md-3"></div>
			<div class="col-md-6">
				<form action="adminAdd.jsp" method="get">
					<div><input type="text" class="form-control" id="sid" name="sid" value="<% out.print(sid); %>" style="display: none"></div>
					<div><input type="text" class="form-control" id="i" name="i" value="true" style="display: none"></div>
	  				<div class="form-group size labelAlign">
	    				<label for="titleInput">Name: </label>
	    				<input type="text" class="form-control" id="titleInput" name="titleInput" required>
	    			</div>
	    			<div class="form-group size labelAlign">
	    				<label for="descInput">Description: </label>
	    				<textarea class="form-control" id="descInput" name="descInput" rows="3" required></textarea>
	    			</div>
	    			<div class="form-group size labelAlign">
	    				<label for="catInput">Category: </label>
	    				<input type="text" class="form-control" id="catInput" name="catInput" required>
	    			</div>
	    			<div class="form-group size labelAlign">
	    				<label for="priceInput">Price: </label>
	    				<input type="text" class="form-control" id="priceInput" name="priceInput" required>
	    			</div>
	    			<div class="form-group size labelAlign">
	    				<label for="condInput">Condition: </label>
	    				<input type="text" class="form-control" id="condInput" name="condInput" required>
	    			</div>
	    			<div class="form-group size labelAlign">
	    				<label for="brandInput">Brand: </label>
	    				<input type="text" class="form-control" id="brandInput" name="brandInput" required>
	    			</div>
	    			<div class="form-group size labelAlign">
	    				<label for="yearInput">Year: </label>
	    				<input type="text" class="form-control" id="yearInput" name="yearInput" required>
	    			</div>
	    			<div class="form-group size labelAlign">
	    				<label for="tagsInput">Tags: </label>
	    				<input type="text" class="form-control" id="tagsInput" name="tagsInput" required>
	 				</div>
	 				<div style="margin-left: 35px; width: 80%" class="text-center">
	 					<button type="submit" class="btn btn-primary">Add Product</button>
	 				</div>
				</form>
			</div>
		</div>
	</div>
	
	<%
	
	// Updating Item Info:
	String i = request.getParameter("i");
	if(i != null && i != "null") {
		String title = request.getParameter("titleInput");
		String desc = request.getParameter("descInput");
		String cat = request.getParameter("catInput");
		String price = request.getParameter("priceInput");
		String cond = request.getParameter("condInput");
		String brand = request.getParameter("brandInput");
		String year = request.getParameter("yearInput");
		String tags = request.getParameter("tagsInput");
		stmt.executeUpdate("INSERT INTO Instrument VALUES ('" + pid + "', '" + sid + "', '" + title + "', '" + desc + "', '" + cat + "', '" + price + "', '" + cond + "', '" + brand + "', '" + year + "', '" + tags + "')");
		Trie trie = new Trie(application.getRealPath("/") + "searchTrie.xml");
		trie.addProduct(pid);
		trie.writeTrie(application.getRealPath("/") + "searchTrie.xml");
		response.setStatus(response.SC_MOVED_TEMPORARILY);
		response.setHeader("Location", "admin.jsp?sid=" + sid);
	}
	
	// Closing Connection:
	con.close();
	
	%>
	
</body>
</html>