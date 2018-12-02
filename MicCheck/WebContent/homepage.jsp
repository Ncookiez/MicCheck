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
	<style>
		img {
			max-height: 100%;
			max-width: 100%;
			vertical-align: middle;
		}
		
		.wholeLink {
			cursor: pointer;
			width: 250px;
		}
		
		.subGroup {
			width: 100%;
			background-color: #75472d;
			color: white;
			padding: 15px;
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
	</style>
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
		<%
			try (Connection con = DriverManager.getConnection(url, uid, pw);) {
				NumberFormat currFormat = NumberFormat.getCurrencyInstance();
				//Dynamic suggestions:
				PreparedStatement pstmt = con.prepareStatement("SELECT TOP 4 Instrument.pID, title, price FROM Instrument, (SELECT pID, COUNT(pID) AS numProd FROM PurchasedProduct GROUP BY pID) AS Popular WHERE Instrument.pID=Popular.pID ORDER BY numProd DESC");
				ResultSet rst = pstmt.executeQuery();
				
				out.println("<br><h3>Popular products</h3>");
				out.println("<div class='subGroup'><div class='row'>");
				while(rst.next()){
					int pid = rst.getInt(1);
					String title = rst.getString(2);
					float price = rst.getFloat(3);
					String link = "location.href='item.jsp?pID="+pid+"&email="+email+"'";
					String imgName = "Images/instrument"+pid+".jpg";
					String image = "<div class='imageBack'><img src='"+imgName+"'/></div>";
					
					out.println("<div class='col-xs-6 col-md-3'><div class='wholeLink' onclick="+link+">");
					out.println(image);
					out.println(title);
					out.println("<br><strong>"+currFormat.format(price)+"</strong>");
					out.println("</div></div>");
				}
				out.println("</div></div><br><br>");
			} catch(Exception e) {
				e.printStackTrace();
			}
		%>
	</div>
	
<script src="http://code.jquery.com/jquery-3.3.1.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>	
	

</body>
</head>