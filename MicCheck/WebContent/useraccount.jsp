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
	
</head>
<body class="background">
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
			
			try
			{	// Load driver class
				Class.forName("com.mysql.jdbc.Driver");
			}
			catch (java.lang.ClassNotFoundException e)
			{
				out.println("ClassNotFoundException: " +e);
			}
			
			String url = "jdbc:mysql://173.194.107.58/MicCheck";
			String uid = "Ncookie";
			String pw = "miccheck";
			
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
		String name = null;
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
			<div class = "row">
				<div class="col-lg-6">
					<%out.println("<h1 class='account-name'>" + name + "'s Account</h1>"); %>
				</div>
				<div class="col-lg-6 btn-div">
					<%
					if(email != null && !email.equals("null")) {
						out.print("<a href='homepage.jsp' class='btn btn-default log-out-button'><h4>Log out</h4></a>");
					}
					%>
				</div>
			</div>			
		<br>
		</div>
	
		<div class="row">
			<%out.print("<a href='shoppingcart.jsp?email=" + email + "&addingToCart=0' class='col-sm-6'>");%>
				<div class="row inner-row">
					<div class="column cart-thumbnail col-sm-3"></div>
					<div class="column_1">
						<h3>View items in cart</h3>
					</div>
				</div>
			</a> 
			<%out.print("<a href='orderHistory.jsp?email=" + email + "&addingToCart=0' class='col-sm-6' style='padding-bottom:20px;'>");%>
				<div class="row inner-row">
					<div class="column orders-thumbnail col-sm-3"></div>
					<div class="column_1">
						<h3>View previous orders</h3>
					</div>
				</div>
			</a> 
			<%out.print("<a href='userinfo.jsp?email=" + email + "' class='col-sm-6'>"); %>
				<div class="row inner-row">
					<div class="column info-thumbnail col-sm-3"></div>
					<div class="column_1">
						<h3>Shipping and Billing info</h3>
					</div>
				</div>
			</a>
			<%out.print("<a href='editinfo.jsp?email=" + email + "' class='col-sm-6'>"); %>
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