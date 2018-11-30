<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="triepackage.Trie" %>
<%@ page import="java.util.HashMap" %>
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
	
	//Find results using the searchTrie:
	int[] pIDs = new Trie(application.getRealPath("/") + "searchTrie.xml").search(search);
	
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
		PreparedStatement pstmt;
		HashMap<Integer,Integer> idOrder = null;
		String[] results = null;
		
		if(pIDs != null){
			//set up results array for later
			results = new String[pIDs.length];
			//prepare the statement to search for the pids
			String pidStr = "";
			for(int i = 0; i < pIDs.length; i++){
				if(i!=0) pidStr+=",";
				pidStr+="?";
			}
			String sql = "SELECT * FROM Instrument WHERE pID IN (" + pidStr + ")";
			pstmt = con.prepareStatement(sql);
			
			idOrder = new HashMap<Integer,Integer>(); //pID will point to its index since they are in order of relevance and need to be organized later.
			for(int i = 0; i < pIDs.length; i++){
				pstmt.setInt(i+1, pIDs[i]);
				idOrder.put(pIDs[i], i);
			}
		}else{
			pstmt = con.prepareStatement("SELECT * FROM Instrument ORDER BY title ASC;");
		}
		
		
		ResultSet rst = pstmt.executeQuery();

		out.println("<h2>Results:</h2><br><table><th></th><th>Instrument</th><th>Category</th><th>Condition</th><th>price</th>");
		while (rst.next())
		{	
			int prodID = rst.getInt(1);
			String prodSearch = rst.getString(3);
			String catSearch = rst.getString(5);
			String condSearch = rst.getString(7);
			float price = rst.getFloat(6);
			String link = "<a href='item.jsp?pID="+prodID+"'>View Item</a>";
			String line = "<tr><td>"+link+"</td><td>"+prodSearch+"</td><td>"+catSearch+"</td><td>"+ (condSearch.charAt(0)=='1' ? "New" : "Used") +"</td><td>"+currFormat.format(price)+"</td></tr>";
			if(idOrder != null) results[idOrder.get(prodID)] = line;
			else out.println(line);
		}
		
		if(results != null){
			for(int i = 0; i < results.length; i++){
				out.println(results[i]);
			}
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