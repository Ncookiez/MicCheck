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
	<title>Purchase History</title>
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
							<%
							out.print("<li><a href='results.jsp?search=Guitar&email=" + email + "'>Guitar</a></li>");
							out.print("<li><a href='results.jsp?search=Bass&email=" + email + "'>Bass</a></li>");
							out.print("<li><a href='results.jsp?search=Keyboard&email=" + email + "'>Keyboard</a></li>");
							out.print("<li><a href='results.jsp?search=Percussion&email=" + email + "'>Percussion</a></li>");
							%>
							<li class="dropdown-submenu">
								<a>Orchestral</a>
								<ul class="dropdown-menu">
									<%
									out.print("<li><a href='results.jsp?search=Brass&email=" + email + "'>Brass</a></li>");
									out.print("<li><a href='results.jsp?search=Strings&email=" + email + "'>Strings</a></li>");
									out.print("<li><a href='results.jsp?search=Woodwind&email=" + email + "'>Woodwind</a></li>");
									%>
								</ul>
							</li>
						</ul>
					</li>
				</ul>
				<%out.print("<form class='navbar-form navbar-left' method='get' action='results.jsp'>"); %>
				<!-- Add 'form-homepage' to the class for the div listed directly below -->
					<div class="form-group form-homepage">
						<input type="text" class="form-control" placeholder="Search for your next instrument" name="search" style="width: 100%; height: 40px;">
					</div>
					<%out.print("<button type='submit' class='btn btn-default submit-btn' href='results.jsp?email=" + email + "'>Search</button>"); %>
					<input type="text" class="form-control" id="email" name="email" <%out.print("value='" + email + "'");%> style="display:none;">       
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
	if(email == null || email.equals("null")) {
		%> <h1 style="padding-top:50px;">No email provided</h1> <%
	} else {
		int orderNum = 0;
		url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_ncukiert;";
		uid = "ncukiert";
		pw = "41776162";
		NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		try {	// Load driver class
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		}
		catch (java.lang.ClassNotFoundException e) {
			out.println("ClassNotFoundException: " +e);
		}
		
		try (Connection con = DriverManager.getConnection(url, uid, pw);) {
			String SQL = "SELECT Purchase.orderNum, totalPrice, title FROM Purchase, PurchasedProduct, Instrument WHERE Purchase.orderNum = PurchasedProduct.orderNum AND Instrument.pID = PurchasedProduct.pID AND email=?";
			PreparedStatement prpStmt = con.prepareStatement(SQL);
			prpStmt.setString(1, email);
			ResultSet rstl = prpStmt.executeQuery();
			
			if(!rstl.next()) {
				out.println("<h1 style='padding-top:50px'>You have no previous orders with us</h1>");
			} else {
				out.println("<h1 style='padding-top:50px;'>Your purchases are: </h1>");
				do {
					out.println("<h4>Order number is: " + rstl.getInt(1) + "</h4><h4>Price of order is: " + currFormat.format(rstl.getDouble(2)) + "</h4><h4>Product purchased is: " + rstl.getString(3) + "</h4>");
				} while(rstl.next());
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	%>
	
</body>
</html>