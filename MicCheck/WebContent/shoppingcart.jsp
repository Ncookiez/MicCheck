<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Shopping Cart</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="MicCheck.css">
	<link href="https://fonts.googleapis.com/css?family=Cairo|Lobster" rel="stylesheet">
</head>
<body class="background">
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
		out.println("<div class='container jumbotron-div'><h1>Your Shopping Cart</h1>");
		int addingToCart = Integer.parseInt(request.getParameter("addingToCart"));
		
		String pID = request.getParameter("pID");
		String sessionID = session.getId();
		// Get the current list of products
		@SuppressWarnings({"unchecked"})
		ArrayList<Object> previousProduct = (ArrayList<Object>)session.getAttribute("currentProduct");
		HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
		if(productList==null) productList = new HashMap<String, ArrayList<Object>>();
		if (addingToCart == 1) {
			if (!(pID == null || pID.equals("null"))) {
				if (productList.containsKey(pID))
				{	previousProduct = (ArrayList<Object>) productList.get(pID);
					int curAmount = ((Integer) previousProduct.get(3)).intValue();
					previousProduct.set(3, new Integer(curAmount+1));
				}
				else
					productList.put(pID,previousProduct);
				session.setAttribute("productList", productList);
			}
		}
		if(addingToCart == 2){
			if (!(pID == null || pID.equals("null"))) {
				productList.remove(pID);
			}
		}
		if(productList.isEmpty()) productList = null;
		
		if (productList == null)
		{	out.println("<br/><h4>There's nothing here! Use the search bar at the top to find your next instrument.</h4>");
			productList = new HashMap<String, ArrayList<Object>>();
			session.setAttribute("productList", productList);
		}
		else
		{
			NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		
			StringBuilder special = new StringBuilder();
			StringBuilder tableSave = new StringBuilder();
			special.append("<table width='100%'><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th><th></th></tr>");
			tableSave.append("<table width='100%'><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");
		
			double total =0;
			Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
			while (iterator.hasNext()) 
			{	Map.Entry<String, ArrayList<Object>> entry = iterator.next();
				ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
				if (product.size() < 4)
				{
					special.append("Expected product with four entries. Got: "+product);
					continue;
				}
				
				Object pid = product.get(0);
				Object name = product.get(1);
				special.append("<tr><td>"+pid+"</td>");
				tableSave.append("<tr><td>"+pid+"</td>");
				try{
					special.append("<td><a href='item.jsp?pID="+Integer.parseInt(pid.toString())+"&email=" + email + "'>"+name+"</a></td>");
					tableSave.append("<td><a href='item.jsp?pID="+Integer.parseInt(pid.toString())+"&email=" + email + "'>"+name+"</a></td>");
				}catch(Exception e){
					special.append("<td>"+name+"</td>");
					tableSave.append("<td>"+name+"</td>");
				}
		
				special.append("<td>"+product.get(3)+"</td>");
				tableSave.append("<td>"+product.get(3)+"</td>");
				Object price = product.get(2);
				Object itemqty = product.get(3);
				double pr = 0;
				int qty = 0;
				
				try
				{
					pr = Double.parseDouble(price.toString());
				}
				catch (Exception e)
				{
					special.append("Invalid price for product: "+product.get(0)+" price: "+price);
				}
				try
				{
					qty = Integer.parseInt(itemqty.toString());
				}
				catch (Exception e)
				{
					special.append("Invalid quantity for product: "+product.get(0)+" quantity: "+qty);
				}		
		
				special.append("<td>"+currFormat.format(pr)+"</td>");
				tableSave.append("<td>"+currFormat.format(pr)+"</td>");
				special.append("<td><strong>"+currFormat.format(pr*qty)+"</strong></td>");
				tableSave.append("<td><strong>"+currFormat.format(pr*qty)+"</strong></td></tr>");
				total = total + pr*qty;
				
				special.append("<td><a href='shoppingcart.jsp?pID="+pid+"&email="+email+"&addingToCart="+2+"'>Remove</a></td></tr>");
			}
			special.append("<tr><td colspan='4'><strong>Order Total</strong></td>"
					+"<td colspan='2'><strong>"+currFormat.format(total)+"</strong></td></tr>");
			tableSave.append("<tr><td colspan='4'><strong>Order Total</strong></td>"
					+"<td><strong>"+currFormat.format(total)+"</strong></td></tr>");
			special.append("</table>");
			tableSave.append("</table>");
			out.println(special.toString());
		
			out.println("<br/><button type='button' class='btn btn-default search-btn' onclick='location.href=\"checkout.jsp?email="+email+"\"'>Check Out</button>");
			session.setAttribute("prodListFromShowCart", tableSave.toString());
			session.setAttribute("totalFromShowCart",total);
			out.println("<button type='button' class='btn btn-default search-btn' onclick='location.href=\"results.jsp?email="+email+"\"'>Continue Shopping</button>");
		}
		
		out.println("</div>");
	%>
	
	<script src="http://code.jquery.com/jquery-3.3.1.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>