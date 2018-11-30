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
</head>
<body>
	<h1>Item Page</h1>
	
<% // Get product name to search for
String pID = request.getParameter("pID");
String email = request.getParameter("email");
/* Need on results page:
String productID;
out.println("<a href=\"item.jsp?pID="+productID+"\">Go to item page: </a>");
*/
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null) {	// No products currently in list.  Create a list.
	productList = new HashMap<String, ArrayList<Object>>();
}

try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}
String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_hmehain;";
String uid = "hmehain";
String pw = "87189106";
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
		
		out.println("<h2>"+title+"</h2>");
		out.println("<img src=\"Images/guitar.png\" alt=\""+title+"\"></img>");
		out.println("<br /><h3>"+description+"</h3>");
		out.println("Category: " + category);
		out.println("<br />Seller: <a href=\"seller.jsp?sID="+sID+"\">"+seller+"</a>");
		out.println("<br />Price " + price);
		out.println("<br />Condition: " + condition);
		out.println("<br />Brand: " + brand);
		out.println("<br />Year: " + year);
		if (tags != null) 
			out.println("<br />Tags: " + tags);	// Have not done tags yet
		out.println("<br /><a href=\"shoppingcart.jsp?pID="+pID+"&email="+email+"\">Add to Cart</a>");
		
		// Store product information in an ArrayList
		ArrayList<Object> product = new ArrayList<Object>();
		product.add(pID);
		product.add(title);
		product.add(price);
		product.add(new Integer(1)); // quantity
		
		// Update quantity if add same item to order again
		if (productList.containsKey(pID))
		{	product = (ArrayList<Object>) productList.get(pID);
			int curAmount = ((Integer) product.get(3)).intValue();
			product.set(3, new Integer(curAmount+1));
		}
		else
			productList.put(pID,product);

		session.setAttribute("productList", productList);
		
	}
	
	
} catch (SQLException ex) {
	out.println(ex);
}

out.close();


%>
</body>
</html>