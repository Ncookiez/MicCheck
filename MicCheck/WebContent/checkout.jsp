<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Checkout Page</title>
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
	          	<%
	          	out.print("<li><a href='results.jsp?search=Guitar&email= " + email + "' >Guitar</a></li>");
	    		out.print("<li><a href='results.jsp?search=Bass&email= " + email + "' >Bass</a></li>");
	    		out.print("<li><a href='results.jsp?search=Keyboard&email= " + email + "' >Keyboard</a></li>");
	    		out.print("<li><a href='results.jsp?search=Percussion&email= " + email + "' >Percussion</a></li>");
	          	%>
	            <li class="dropdown-submenu">
	            	<a>Orchestral</a>
	            	<ul class="dropdown-menu">
	            		<%
	            		out.print("<li><a href='results.jsp?search=Brass&email= " + email + "' >Brass</a></li>");
	            		out.print("<li><a href='results.jsp?search=Strings&email= " + email + "' >Strings</a></li>");
	            		out.print("<li><a href='results.jsp?search=Woodwind&email= " + email + "' >Woodwind</a></li>");
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
	<%
	@SuppressWarnings({"unchecked"})
	HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

	if (email == null || email.equals("null")) {
		out.println("<h2 style=\"padding-top:130px\">You need to login before you checkout</h2><br /><a href=\"login.jsp\">Login</a>");
		
	} else {

	
	//Determine if there are products in the shopping cart
	//If either are not true, display an error message

	if (productList == null || productList.isEmpty()) {
		out.println("<h1 style=\"padding-top:130px\">Your shopping cart is empty!</h1>");
	}
	
		// Make connection
		try (Connection con = DriverManager.getConnection(url, uid, pw); Statement stmt = con.createStatement();) {
	
			String sql = "INSERT INTO Purchase (totalPrice, email) VALUES ( ?, ?);";
			// Use retrieval of auto-generated keys.
			PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);			
			//***************Saved total from shoppingcart.jsp******************
			double total = (double)session.getAttribute("totalFromShowCart");
			pstmt.setDouble(1, total);
			pstmt.setString(2, email);
			pstmt.executeUpdate();
			ResultSet keys = pstmt.getGeneratedKeys();
			keys.next();
			int orderId = keys.getInt(1);
			
			
			// Insert each item into OrderedProduct table using OrderId from previous INSERT

			// Update total amount for order record

			// Here is the code to traverse through a HashMap
			// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price
			
			Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
			while (iterator.hasNext())
			{ 
				Map.Entry<String, ArrayList<Object>> entry = iterator.next();
				
				ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
				String pId = (String) product.get(0);
				 double price = (double) product.get(2);
					double pr = price;
				
				int qty = ( (Integer)product.get(3)).intValue();
				String pname = (String) product.get(1);
				String sql2 = "INSERT INTO PurchasedProduct (orderNum, pId, quantity, price) VALUES ( ?, ?, ?, ?);";
				// Use retrieval of auto-generated keys.
				PreparedStatement pstmt2 = con.prepareStatement(sql2, Statement.RETURN_GENERATED_KEYS);			
				pstmt2.setInt(1,orderId);
				pstmt2.setString(2, pId);
				pstmt2.setInt(3,qty);
				pstmt2.setDouble(4, pr*qty);
				pstmt2.executeUpdate();
		          
			}
			
			out.println("<h1 style=\"padding-top:85px\">Your Order Summary</h1>");
			//*******Modified showcart.jsp so that don't have to create the table again*****
			String table = (String)session.getAttribute("prodListFromShowCart");
			out.println(table);
			out.println("<h1>Order completed. Will be shipped soon...</h1>");
			out.println("<h1>Your order reference number is: " + orderId + "</h1>");
			PreparedStatement pstm3 = con.prepareStatement("SELECT name FROM Customers WHERE email=?");
			pstm3.setString(1,email);
			ResultSet rst3 = pstm3.executeQuery();
			rst3.next();
			out.println("<h1>Shipping to customer: "+rst3.getString(1)+"</h1>");
		} catch (SQLException ex) {
			out.println(ex);
		}
		// Save order information to database
		// Print out order summary
	}
	out.close();
	%>
</body>
</html>