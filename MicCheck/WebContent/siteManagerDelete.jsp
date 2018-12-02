<%@ page import="java.sql.*" %>
<%@ page import="triepackage.Trie" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Admin - Item Deleting</title>
</head>
<body>

	<%
	
	// Finding and deleting appropriate item:
	String pid = request.getParameter("pid");
	String url = "jdbc:mysql://173.194.107.58/MicCheck";
	String uid = "Ncookie";
	String pw = "miccheck";
	Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();
	stmt.executeUpdate("DELETE FROM Instrument WHERE pID = '" + pid + "';");
	Trie trie = new Trie(application.getRealPath("/") + "searchTrie.xml");
	trie.remove(Integer.parseInt(pid));
	trie.writeTrie(application.getRealPath("/") + "searchTrie.xml");
	response.setStatus(response.SC_MOVED_TEMPORARILY);
	response.setHeader("Location", "siteManager.jsp");
	
	%>

</body>
</html>