<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
	<meta charset="UTF-8">
	<title>Show Employee List</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
	<link rel="stylesheet" href="CSS/homeStyle.css">
	<style type="text/css">
	.box1 {
	  	display: flex;
	  	max-width: 100vw;
	}
	.rightbox1 {
		padding-left:150px;
		padding-right:10px;
		text-align:center;
	   	width: 50%;
	   	box-sizing: border-box;
	}
	.leftbox1 {
		padding-left:25px;
		padding-right:25px;
		width: 35%;		   	
		box-sizing: border-box;
	   	word-wrap:break-word;
	}
	#msgTable {
		width: 100%;container
	}
	</style>
	<script>
		function updateDateTime() {
	        var now = new Date();
	        var options = { day: 'numeric', month: 'short',year: 'numeric', hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: true };
	        var formattedDateTime = now.toLocaleDateString('en-US', options);
	        document.getElementById("currentDateTime").innerHTML = formattedDateTime;
	    }
    	// Update the time every second
    	setInterval(updateDateTime, 1000);
  	</script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</head>
<body onLoad="lod()">
	<div id="preloder"></div>
	<nav class="navbar navbar-expand-lg bg-body-tertiary bg-primary" data-bs-theme="dark">
		<div class="container-fluid">
			<a class="navbar-brand" href="home.html">Home</a>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item">
						<a class="nav-link active" aria-current="page" href="employeeList.jsp">Employee List</a>
					</li>
 					<li class="nav-item">
          				<a class="nav-link active" aria-current="page" href="home.html">Add New Employee</a>
        			</li>
      			</ul>
      			<form class="d-flex" role="search">
        			<input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
        			<button class="btn btn-outline-success" type="submit">Search</button>
      			</form>
    		</div>
  		</div>
	</nav>

	<div class="d-flex bg">
		<div class="p-2 flex-grow-1"><span style="font-size:25px; padding-left: 15px;">&#x1F468;&#x200D;&#x1F4BC;</span>Employee Management System</div>
		<div class="p-2"><p id="currentDateTime" style="color: darkmagenta; padding-right: 15px;"></p></div>
	</div><br>

	<div class="box1">
		<div class="leftbox1" align="left">
			<form action="msgEmpDetailLName.jsp" method="post">
				<div class="form-group">
					<label for="lName">Enter Employee Last-Name</label>
     					<input type="text" id="lName" name="lName" class="form-control" placeholder="Enter Employee Last-Name">
   				</div>
   				<div class="form-group">
   					<button type="submit" class="btn3 form-control" value="Submit">Submit</button>
   				</div>
   			</form>
		</div>
		<div class="rightbox1" align="center">
			<%
			try{
	
				Class.forName(application.getInitParameter("dbDriver"));

				Connection con = DriverManager.getConnection(application.getInitParameter("dbUrl"), application.getInitParameter("dbUser"), application.getInitParameter("dbPass"));
				
				String q = "select * from employeelist";

				Statement stat = con.createStatement();

				ResultSet rs = stat.executeQuery(q);
			%>
			
			<table class="table table-bordered table-hover">
			<thead>
				<tr>
					<th scope="col">Employee Id</th>
					<th scope="col">First Name</th>
					<th scope="col">Last Name</th>
					<th scope="col">Email</th>
				</tr>
			</thead>
			<tbody>
			<%
				while(rs.next()){	
			%>
			
			<tr>
				<td scope="row"><%= rs.getString(1) %></td>
				<td><%= rs.getString(2) %></td>
				<td><%= rs.getString(3) %></td>
				<td><%= rs.getString(4) %></td>
			</tr>
				
			<%
			}
			%>
			
			</tbody>	
			</table>
				
			<%	
				con.close();					
			}catch(Exception e){
				e.printStackTrace();
			}
			%>
		</div>
	</div>
	
	<div style="padding: 20px;">
		<a href="moreOption.jsp" style="text-decoration: none;">Back....</a>
	</div>
	
	<script>
		var loader = document.getElementById('preloder');
		function lod(){
			loader.style.display = 'none';
		}
	</script>
	
</body>
</html>