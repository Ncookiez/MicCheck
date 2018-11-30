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
	<h1>Item Page</h1>
	
<% // Get product name to search for
String pID = request.getParameter("pID");
/* Need on results page:
String productID;
out.println("<a href=\"item.jsp?pID="+productID+"\">Go to item page: </a>");
*/

try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}
/*
String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_hmehain;";
String uid = "hmehain";
String pw = "87189106";
*/
//Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
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
		
		out.println("<h2 style=\"padding-top:85px\">"+title+"</h2>");
		String imgName = "Images/instrument"+pID+".jpg";
		out.println("<img src="+imgName+" alt=\""+title+"\"></img>");
		out.println("<br /><h3>"+description+"</h3>");
		out.println("Category: " + category);
		out.println("<br />Seller: <a href=\"seller.jsp?sID="+sID+"&email="+email+"\">"+seller+"</a>");
		out.println("<br />Price " + price);
		out.println("<br />Condition: " + condition);
		out.println("<br />Brand: " + brand);
		out.println("<br />Year: " + year);
		if (tags != null) 
			out.println("<br />Tags: " + tags);	// Have not done tags yet
		out.println("<br /><a href=\"shoppingcart.jsp?pID="+pID+"&email="+email+"&addingToCart=1\">Add to Cart</a>"); // 1 is true
		out.println("<br /><a href=\"shoppingcart.jsp?pID="+pID+"&email="+email+"&addingToCart=0\">Go to Cart</a>"); // 0 is false
		
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

out.close();


%>
</body>
</html>