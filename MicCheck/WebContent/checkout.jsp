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
</head>
<body>
	<%
	String email = request.getParameter("email");
	@SuppressWarnings({"unchecked"})
	HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

	if (email == null) {
		out.println("<h2>You need to login before you checkout</h2><br /><a href=\"login.jsp\">Login</a>");
		out.println("<br />" + email);
		
	} else {

	
	//Determine if there are products in the shopping cart
	//If either are not true, display an error message

	if (productList == null || productList.isEmpty()) {
		out.println("<h1>Your shopping cart is empty!</h1>");
	}
	
		// Make connection
		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_hmehain;";
		String uid = "hmehain";
		String pw = "87189106";
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
			
			out.println("<h1>Your Order Summary</h1>");
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