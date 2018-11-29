<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
    <title>MicCheck Home Page</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="MicCheck.css">
	<link href="https://fonts.googleapis.com/css?family=Cairo|Lobster" rel="stylesheet">
</head>
<body>
<!-- <form method="get" action="products.jsp">
		<h1><a href="homepage.jsp">MicCheck</a></h1>
		<input type="text" name="searchResult" placeholder="Search..">
		<ul>
			<li><a href="#" name="Guitar">Guitar</a></li>
			<li><a href="#" name="Bass">Bass</a></li>
			<li><a href="#" name="Keyboard">Keyboard</a></li>
			<li><a href="#" name="Percussion">Percussion</a></li>
			<li>Orchestral</li>
			<ul>
				<li><a href="#" name="Brass">Brass</a></li>
				<li><a href="#" name="String">String</a></li>
				<li><a href="#" name="Woodwind">Woodwind</a></li>
			</ul>
		</ul>
	</form>
	<ul>
		<li><a href="shoppingcart.jsp">Cart</a></li>
		<li><a href="signup.jsp">Sign Up</a></li>
		<li><a href="login.jsp">Login</a></li>
	</ul>  -->
	
	<nav class="navbar navbar-default">
	  <div class="container-fluid">
	    <!-- Brand and toggle get grouped for better mobile display -->
	    <div class="navbar-header">
	      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
	        <span class="sr-only">Toggle navigation</span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	      </button>
	      <a class="navbar-brand navbar-title" href="#">MicCheck</a>
	    </div>

	    <!-- Collect the nav links, forms, and other content for toggling -->
	    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	      <ul class="nav navbar-nav">
	        <li class="dropdown">
	          <a href="#" class="dropdown-toggle instruments-dropdown dropbtn" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Instruments <span class="caret"></span></a>
	          <ul class="dropdown-menu">
	            <li><a href="#">Guitar</a></li>
	            <li><a href="#">Bass</a></li>
	            <li><a href="#">Keyboard</a></li>
	            <li><a href="#">Percussion</a></li>
	            <li class="dropdown-submenu">
	            	<a href="#">Orchestral</a>
	            	<ul class="dropdown-menu">
	            		<li><a href="#">Brass</a></li>
	            		<li><a href="#">Strings</a></li>
	            		<li><a href="$">Woodwind</a></li>
	            	</ul>
	            </li>
	          </ul>
	        </li>
	      </ul>
	      <form class="navbar-form navbar-left">
	        <div class="form-group">
	          <input type="text" class="form-control" placeholder="Search for your next instrument" style="width: 599px; height: 40px;">
	        </div>
	        <button type="submit" class="btn btn-default submit-btn">Submit</button>
	      </form>
	      <ul class="nav navbar-nav navbar-right">
	      	<li><a href="shoppingcart.jsp"><span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span> Cart </a></li>
	      	<li><a href="signup.jsp"> Sign Up </a></li>
	        <li><a href="login.jsp"><span class="glyphicon glyphicon-user" aria-hidden="true"></span> Log in </a></li>
	      </ul>
	    </div><!-- /.navbar-collapse -->
	  </div><!-- /.container-fluid -->
	</nav>

	<div class="container">
		<div class="jumbotron center-picture">
  			<h1 class="micCheck-title" type="text">MicCheck</h1>
		</div>

		<div class="row">
			<a class="col-xs-6 col-md-3">
				<div class="thumbnail thumbnail_1">
					<h3>Guitar</h3>
				</div>
			</a>
		</div>
	</div>
	
<script src="http://code.jquery.com/jquery-3.3.1.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>	
	

</body>
</head>