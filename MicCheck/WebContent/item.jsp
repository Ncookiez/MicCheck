<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Item</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="MicCheck.css">
	<link href="https://fonts.googleapis.com/css?family=Cairo|Lobster" rel="stylesheet">
	<style>
		img {
			max-width: 100%;
			max-height: 100%;
			vertical-align: middle;
		}
		
		.imageMain {
			width: 100%;
			height: 550px;
			background-color: #414141;
			background-size: cover;
			border: 1px solid #021a40;
			text-align: center;
			white-space: nowrap;
		}
		
		.imageMain:before,
		.imageMain_before {
		    content: "";
		    display: inline-block;
		    height: 100%;
		    vertical-align: middle;
		}
		
		.imageBack {
			height: 175px;
			width: 250px;
			background-color: #414141;
			background-size: cover;
			border: 1px solid #021a40;
			text-align: center;
			white-space: nowrap;
		}
		
		.imageBack:before,
		.imageBack_before {
		    content: "";
		    display: inline-block;
		    height: 100%;
		    vertical-align: middle;
		}
		
		.textBack {
			height: 100%;
			width: 100%;
			background-color: white;
			background-size: cover;
			padding: 15px;
		}
		
		.subText{
			padding: 15px;
		}
		
		table {
			width: 100%;
		}
		
		th, td{
			padding: 5px;
			text-align: left;
			border
		}
		
		th{
			background-color: white;
			color: black;
		}
		
		td {
			height: 40px;
		}
	</style>
</head>
<body class="background">
	<%
	String email = request.getParameter("email");
	try
	{	// Load driver class
		Class.forName("com.mysql.jdbc.Driver");
	}
	catch (java.lang.ClassNotFoundException e)
	{
		out.println("ClassNotFoundException: " +e);
	}
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
	
	<% // Get product name to search for
	String pID = request.getParameter("pID");
	
	try
	{	// Load driver class
		Class.forName("com.mysql.jdbc.Driver");
	}
	catch (java.lang.ClassNotFoundException e)
	{
		out.println("ClassNotFoundException: " +e);
	}
	
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	
	//Start of page content:
	out.println("<div class='container jumbotron-div'>");
	
	try (Connection con = DriverManager.getConnection(url, uid, pw); Statement stmt = con.createStatement();) {
		String SQL = "SELECT * FROM Instrument WHERE pID=?;";
		PreparedStatement pstm = con.prepareStatement(SQL);
		pstm.setString(1,pID);
		ResultSet rst = pstm.executeQuery();
		StringBuilder s = new StringBuilder();
		if (!rst.next()) {
			out.println("No instrument exists.");
			out.println("<form>" +
			  "<button formaction=\"results.jsp?\">Go Back</button></form>");
		}
		else {
			int sID = rst.getInt(2);
			String title = rst.getString(3);
			String description = rst.getString(4);
			String category = rst.getString(5);
			double price = rst.getDouble(6);
			int condition = rst.getInt(7);
			String brand = rst.getString(8);
			int year = rst.getInt(9);
			String tags = rst.getString(10);
			
			String SQL2 = "SELECT * FROM Seller WHERE sID=?;";
			PreparedStatement pstm2 = con.prepareStatement(SQL2);
			pstm2.setInt(1,sID);
			ResultSet rst2 = pstm2.executeQuery();
			String seller = null;
			if (rst2.next()) {
				seller = rst2.getString(2);
			}
			
			out.println("<h2>"+title+"</h2>");
			String imgName = "Images/instrument"+pID+".jpg";
			out.println("<div class='row'>");
			out.println("<div class='col-xs-12 col-md-6'>");
			out.println("<div class='imageMain'><img src="+imgName+" alt=\""+title+"\"></img></div>");
			out.println("</div>");
			out.println("<div class='col-xs-12 col-md-6'>");
			out.println("<div class='textBack'>");
			out.println("<h4>Description</h4>");
			out.println("<div class='subText'>"+description+"</div>");
			
			out.println("<table><th><h4>Brand</h4></th><th><h4>Condition</h4></th><th><h4>Year</h4></th><th><h4>Category</h4></th><tr>");
			out.println("<td>"+brand+"</td>");
			out.println("<td>"+(condition==1 ? "New" : "Used")+"</td>");
			out.println("<td>"+year+"</td>");
			out.println("<td>"+category+"</td>");
			out.println("</tr></table><br/>");
			
			out.println("<h4>Price: <strong>"+currFormat.format(price)+"</strong></h4><br/>");
			out.println("<h4>Seller: <a href='seller.jsp?sID="+sID+"&email="+email+"'>"+seller+"</a></h4><br/>");
			if (tags != null) 
				out.println("Tags: <i>" + tags +"</i>");	// Have not done tags yet
			out.println("</div>");
			out.println("<br/><button type='button' class='btn btn-default search-btn' onclick='location.href=\"shoppingcart.jsp?pID="+pID+"&email="+email+"&addingToCart=1\"'>Add to Cart</button>");
			out.println("<button type='button' class='btn btn-default search-btn' onclick='location.href=\"shoppingcart.jsp?pID="+pID+"&email="+email+"&addingToCart=0\"'>View Cart</button>");
			
			out.println("</div></div></div>");
			
			// Store product information in an ArrayList
			ArrayList<Object> currentProduct = new ArrayList<Object>();
			currentProduct.add(pID);
			currentProduct.add(title);
			currentProduct.add(price);
			currentProduct.add(new Integer(1)); // quantity
			
			session.setAttribute("currentProduct", currentProduct);
			
		}
		
		
	} catch (SQLException ex) {
		out.println(ex);
	}
	
	out.println("</div>");
	
	%>
	
	<script src="http://code.jquery.com/jquery-3.3.1.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>	

</body>
</html>