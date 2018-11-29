<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
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
		
		out.println("<h1>"+title+"</h1>");
		out.println("<img src=\"Images/guitar.png\" alt=\""+title+"\"></img>");
		out.println("<br /><h3>"+description+"</h3>");
		out.println("Category: " + category);
		out.println("<br />Seller: <a href=\"seller.jsp?sID="+sID+"\">"+seller+"</a>");
		out.println("<br />Price " + price);
		out.println("<br />Condition: " + condition);
		out.println("<br />Brand: " + brand);
		out.println("<br />Year: " + year);
		// Have not done tags yet
		
	}
	
	
} catch (SQLException ex) {
	out.println(ex);
}

out.close();


%>
</body>
</html>