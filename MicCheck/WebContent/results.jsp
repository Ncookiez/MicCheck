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
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="MicCheck.css">
	<link href="https://fonts.googleapis.com/css?family=Cairo|Lobster" rel="stylesheet">
	<title>Instrument Results</title>
	
	<style>
		table, th, td {
			border-bottom: 1px solid black;
		}
		
		th, td{
			padding: 15px;
			text-align: left;
		}
		
		th{
			background-color: #75472d;
			color: white;
		}
		
		td {
			height: 50px;
			
		}
		
		tr:hover {
			background-color: #f2f2f2;
			cursor: pointer;
		}
		
		img {
			max-height: 100%;
			max-width: 100%;
			vertical-align: middle;
		}
		
		.imageBack {
			height: 175px;
			width: 250px;
			background-color: #414141;
			background-size: cover;
			border: 1px solid #021a40;
			text-align: center;
			white-space: nowrap;
		}
		
		.imageBack:before,
		.imageBack_before {
		    content: "";
		    display: inline-block;
		    height: 100%;
		    vertical-align: middle;
		}
		
		.wholeLink {
			cursor: pointer;
			width: 250px;
		}
		
		.subGroup {
			width: 100%;
			background-color: #75472d;
			color: white;
			padding: 15px;
		}
	</style>
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
	          	out.print("<li><a href='results.jsp?search=Guitar&email=" + email + "' >Guitar</a></li>");
	    		out.print("<li><a href='results.jsp?search=Bass&email=" + email + "' >Bass</a></li>");
	    		out.print("<li><a href='results.jsp?search=Keyboard&email=" + email + "' >Keyboard</a></li>");
	    		out.print("<li><a href='results.jsp?search=Percussion&email=" + email + "' >Percussion</a></li>");
	          	%>
	            <li class="dropdown-submenu">
	            	<a>Orchestral</a>
	            	<ul class="dropdown-menu">
	            		<%
	            		out.print("<li><a href='results.jsp?search=Brass&email=" + email + "' >Brass</a></li>");
	            		out.print("<li><a href='results.jsp?search=Strings&email=" + email + "' >Strings</a></li>");
	            		out.print("<li><a href='results.jsp?search=Woodwind&email=" + email + "' >Woodwind</a></li>");
	            		%>
	            	</ul>
	            </li>
	          </ul>
	        </li>
	      </ul>
	      <%out.print("<form class='navbar-form navbar-left' method='get' action='results.jsp?email=" + email + "'>"); %>
	    	<!-- Add 'form-homepage' to the class for the div listed directly below -->
	        <div class="form-group form-homepage">
	          <input type="text" class="form-control" placeholder="Search for your next instrument" name="search" style="width: 100%; height: 40px;">
	        </div>
	        <%out.print("<button type='submit' class='btn btn-default submit-btn' href='results.jsp?email=" + email + "'>Search</button>"); %>
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
		
	<script src="http://code.jquery.com/jquery-3.3.1.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>	
		
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

	try (Connection con = DriverManager.getConnection(url, uid, pw);)
	{
		PreparedStatement pstmt;
		ResultSet rst = null;
		HashMap<Integer,Integer> idOrder = null;
		String[] results = null;
		
		if(pIDs != null){
			if(pIDs.length > 0){
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
				rst = pstmt.executeQuery();
			}
		}else{
			pstmt = con.prepareStatement("SELECT * FROM Instrument ORDER BY title ASC;");
			rst = pstmt.executeQuery();
		}

		out.println("<div class='container jumbotron-div'>");//start of page body html
		if(rst != null){
			String contents = "";
			int numLines = 0;
			while (rst.next())
			{	
				int prodID = rst.getInt(1);
				String prodSearch = rst.getString(3);
				String catSearch = rst.getString(5);
				String condSearch = rst.getString(7);
				if(condSearch==null) condSearch = "0";
				float price = rst.getFloat(6);
				String link = "location.href='item.jsp?pID="+prodID+"&email="+email+"'";
				String imgName = "Images/instrument"+prodID+".jpg";
				String image = "<div class='imageBack'><img src='"+imgName+"'/></div>";
				String line = "<tr onclick="+link+"><td>"+image+"</td><td><h4>"+prodSearch+"</h4></td><td>"+catSearch+"</td><td>"+ (condSearch.charAt(0)=='1' ? "New" : "Used") +"</td><td><strong>"+currFormat.format(price)+"</strong></td></tr>";
				if(idOrder != null) results[idOrder.get(prodID)] = line;
				else contents+=line+"\n";
				numLines++;
			}
			out.println("<h3>"+numLines+" results for \""+search+"\":</h3><br><table width='100%'><th></th><th>Instrument</th><th>Category</th><th>Condition</th><th>Price</th>");
			
			if(results != null){
				for(int i = 0; i < results.length; i++){
					out.println(results[i]);
				}
			}else{
				out.println(contents);
			}
			out.println("</table>");
		}else{
			out.println("<h3>Sorry, no results were found for \""+search+"\".</h3>");
		}
		
		//Dynamic suggestions:
		pstmt = con.prepareStatement("SELECT TOP 4 Instrument.pID, title, price FROM Instrument, (SELECT pID, COUNT(pID) AS numProd FROM PurchasedProduct GROUP BY pID) AS Popular WHERE Instrument.pID=Popular.pID ORDER BY numProd DESC");
		rst = pstmt.executeQuery();
		
		out.println("<br><h3>Popular products</h3>");
		out.println("<div class='subGroup'><div class='row'>");
		while(rst.next()){
			int pid = rst.getInt(1);
			String title = rst.getString(2);
			float price = rst.getFloat(3);
			String link = "location.href='item.jsp?pID="+pid+"&email="+email+"'";
			String imgName = "Images/instrument"+pid+".jpg";
			String image = "<div class='imageBack'><img src='"+imgName+"'/></div>";
			
			out.println("<div class='col-xs-6 col-md-3'><div class='wholeLink' onclick="+link+">");
			out.println(image);
			out.println(title);
			out.println("<br><strong>"+currFormat.format(price)+"</strong>");
			out.println("</div></div>");
		}
		out.println("</div></div><br><br>");
		out.println("</div>");//end of page body html
				
	}
	catch (SQLException ex) 
	{ 	
		out.println(ex); 
	}
	%>
</body>
</html>