<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
    <title>MicCheck Home Page</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="MicCheck.css">
	<link href="https://fonts.googleapis.com/css?family=Cairo|Lobster" rel="stylesheet">
</head>
<body>
	
	<%
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
	    	<!-- Add 'form-homepage' to the class for the div listed directly below -->
	        <div class="form-group form-homepage">
	          <input type="text" class="form-control" placeholder="Search for your next instrument" name="search" style="width: 100%; height: 40px;">
	        </div>
	        <button type="submit" class="btn btn-default submit-btn" href="results.jsp">Submit</button>
	      </form>
	      <ul class="nav navbar-nav navbar-right">
	      	<li><a href="shoppingcart.jsp"><span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span> Cart </a></li>
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

	<div class="container jumbotron-div">
		<div class="jumbotron center-picture">
  			<h1 class="micCheck-title" type="text">MicCheck</h1>
		</div>

		<div class="row">
			<%out.print("<a href='results.jsp?search=Guitar&email=" + email +" 'class='col-xs-6 col-md-3'>"); %>
				<div class="thumbnail thumbnail_1">
					<h3>Guitar</h3>
				</div>
			</a>
			<%out.print("<a href='results.jsp?search=Bass&email=" + email +" 'class='col-xs-6 col-md-3'>"); %>
				<div class="thumbnail thumbnail_2">
					<h3>Bass</h3>
				</div>
			</a>
			<%out.print("<a href='results.jsp?search=Keyboard&email=" + email +" 'class='col-xs-6 col-md-3'>"); %>
				<div class="thumbnail thumbnail_3">
					<h3>Keyboard</h3>
				</div>
			</a>
			<%out.print("<a href='results.jsp?search=Percussion&email=" + email +" 'class='col-xs-6 col-md-3'>"); %>
				<div class="thumbnail thumbnail_4">
					<h3>Percussion</h3>
				</div>
			</a>
			<%out.print("<a href='results.jsp?search=Brass&email=" + email +" 'class='col-lg-4 col-sm-6'>"); %>
				<div class="thumbnail thumbnail_5">
					<h3>Brass</h3>
				</div>
			</a>
			<%out.print("<a href='results.jsp?search=Strings&email=" + email +" 'class='col-lg-4 col-sm-6'>"); %>
				<div class="thumbnail thumbnail_6">
					<h3>Strings</h3>
				</div>
			</a>
			<%out.print("<a href='results.jsp?search=Woodwind&email=" + email +" 'class='col-lg-4 col-sm-6'>"); %>
				<div class="thumbnail thumbnail_7">
					<h3>Woodwind</h3>
				</div>
			</a>
		</div>
	</div>
	
<script src="http://code.jquery.com/jquery-3.3.1.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>	
	

</body>
</head>