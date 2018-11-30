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
</head>
<body>
	<h1>Shopping Cart</h1>
	
	<%
	
	int addingToCart = Integer.parseInt(request.getParameter("addingToCart"));
	String email = request.getParameter("email");
	String pID = request.getParameter("pID");
	String sessionID = session.getId();
// Get the current list of products
@SuppressWarnings({"unchecked"})
ArrayList<Object> previousProduct = (ArrayList<Object>)session.getAttribute("currentProduct");
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
if (addingToCart == 1) {
	if (productList.containsKey(pID))
	{	previousProduct = (ArrayList<Object>) productList.get(pID);
		int curAmount = ((Integer) previousProduct.get(3)).intValue();
		previousProduct.set(3, new Integer(curAmount+1));
	}
	else
		productList.put(pID,previousProduct);
	session.setAttribute("productList", productList);
}


String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_hmehain;";
String uid = "hmehain";
String pw = "87189106";

if (productList == null)
{	out.println("<H1>Your shopping cart is empty!</H1>");
	productList = new HashMap<String, ArrayList<Object>>();
	session.setAttribute("productList", productList);
}
else
{
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();

	out.println("<h1>Your Shopping Cart</h1>");
	StringBuilder special = new StringBuilder();
	special.append("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
	special.append("<th>Price</th><th>Subtotal</th></tr>");

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
		
		special.append("<tr><td>"+product.get(0)+"</td>");
		special.append("<td>"+product.get(1)+"</td>");

		special.append("<td align=\"center\">"+product.get(3)+"</td>");
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

		special.append("<td align=\"right\">"+currFormat.format(pr)+"</td>");
		special.append("<td align=\"right\">"+currFormat.format(pr*qty)+"</td></tr>");
		special.append("</tr>");
		total = total +pr*qty;
	}
	special.append("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
			+"<td align=\"right\">"+currFormat.format(total)+"</td></tr>");
	special.append("</table>");
	out.println(special.toString());

	out.println("<h2><a href=\"checkout.jsp?email="+email+"\">Check Out</a></h2>");
	session.setAttribute("prodListFromShowCart",special.toString());
	session.setAttribute("totalFromShowCart",total);
	out.println("<h2><a href=\"results.jsp?email="+email+"\">Continue Shopping</a></h2>");
}
	if (pID != null)
		out.println("<h2><a href=\"item.jsp?pID="+pID+"&email="+email+"\">Go Back To Item</a></h2>");
%>
	
</body>
</html>