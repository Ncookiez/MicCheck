<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="triepackage.Trie" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Results Page</title>
</head>
<body>
	<%
	//Getting the instrument type passed by pressing the button from the dropdown menu
	String search = request.getParameter("search");
	out.println("<h1>" + search + "</h1>");
	
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	
	try
	{	// Load driver class
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	}
	catch (java.lang.ClassNotFoundException e)
	{
		out.println("ClassNotFoundException: " +e);
	}
	
	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;Databasesearch=db_trichard;";
	String uid = "trichard";
	String pw = "27307164";

	try (Connection con = DriverManager.getConnection(url, uid, pw);)
	{
		PreparedStatement pstmt = con.prepareStatement("SELECT * FROM Instrument WHERE title LIKE ? OR category LIKE ? ORDER BY title ASC;");
		
		if(search == null) search = "";
		pstmt.setString(1, "%"+search+"%");
		pstmt.setString(2, "%"+search+"%");
		ResultSet rst = pstmt.executeQuery();

		out.println("<h2>Results:</h2><br><table><th></th><th>Instrument</th><th>Category</th><th>price</th>");
		while (rst.next())
		{	
			int prodID = rst.getInt(1);
			String prodSearch = rst.getString(3);
			String catSearch = rst.getString(5);
			float price = rst.getFloat(6);
			String link = "<a href='item.jsp?pID="+prodID+"'>View Item</a>";
			out.println("<tr><td>"+link+"</td><td>"+prodSearch+"</td><td>"+catSearch+"</td><td>"+currFormat.format(price)+"</td></tr>");
			
		}
		out.println("</table>");
				
	}
	catch (SQLException ex) 
	{ 	
		out.println(ex); 
	}
	%>
</body>
</html>