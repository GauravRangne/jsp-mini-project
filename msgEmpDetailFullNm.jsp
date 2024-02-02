<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Delete Employee List</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
	<link rel="stylesheet" href="CSS/homeStyle.css">
	<style type="text/css">
		.box1 {
		  	display: flex;
		  	max-width: 100vw;
		}
		.rightbox1 {
			padding-left:20px;
			padding-right:20px;
			text-align:center;
		   	width: 85%; 
			box-sizing: border-box; 
		}
		.leftbox1 {
			padding: 20px;
			width: 20%;
		   	box-sizing: border-box; 
		   	word-wrap:break-word;
		}
		#msgTable {
			width: 100%; 
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
			<a href="eDetailByFName.jsp">Employee Details By First-Name</a><br/>
			<a href="eDetailByLName.jsp">Employee Details By Last-Name</a><br/>
			<a href="eDetailByFNameLName.jsp">Employee Details By First-Name and Last-Name</a><br/>
			<a href="eDetailBySalary.jsp">Employee Details By Salary Range</a><br/>
		</div>
		<div class="rightbox1" align="right">
			<%
			try{

				int cnt = 0;
				Class.forName(application.getInitParameter("dbDriver"));
		
				Connection con = DriverManager.getConnection(application.getInitParameter("dbUrl"), application.getInitParameter("dbUser"), application.getInitParameter("dbPass"));
				con.setAutoCommit(false);
				
				String eFn = request.getParameter("fName");
				String eLn = request.getParameter("lName");
				
				String q = "select count(employeeId) as tEmp from employeeList where firstName=? and lastName=?";
				
				PreparedStatement ps = con.prepareStatement(q);
				
				ps.setString(1,eFn);
				ps.setString(2,eLn);
				
				ResultSet rs = ps.executeQuery();
				
				if(rs.next()){
					cnt=rs.getInt("tEmp");
				}
			%>
				
				Search Result By First-Name = <b><% out.print(eFn);%></b> and Last-Name = <b><% out.print(eLn);%></b> Total Employee Found = <b><%out.print(cnt);%></b>
			<%
				String q1 ="select * from employeeList where firstName=? and lastName=?";
				ps = con.prepareStatement(q1);
				
				ps.setString(1,eFn);
				ps.setString(2,eLn);
				
				ResultSet rs1 = ps.executeQuery();
				
			%>
			
			<table class="table table-bordered table-hover">
				<thead>
					<tr>
						<th scope="col">Employee Id</th>
						<th scope="col">First Name</th>
						<th scope="col">Last Name</th>
						<th scope="col">Email</th>
						<th scope="col">Department Name</th>
						<th scope="col">Department-ID</th>
						<th scope="col">Designation</th>
						<th scope="col">Salary</th>
						<th scope="col">Address</th>
					</tr>
				</thead>
			<tbody>
			<%
				while(rs1.next()){	
			%>
			
			<tr>
				<td scope="row"><%= rs1.getString(1) %></td>
				<td><%= rs1.getString(2) %></td>
				<td><%= rs1.getString(3) %></td>
				<td><%= rs1.getString(4) %></td>
				<td><%= rs1.getString(5) %></td>
				<td><%= rs1.getString(6) %></td>
				<td><%= rs1.getString(7) %></td>
				<td><%= rs1.getString(8) %></td>
				<td><%= rs1.getString(9) %></td>
			</tr>
				
			<%
			}
			%>
			</tbody>	
			</table><br><br>
			<%		
				con.commit();
			
				String q2="select * from employeelist";
				
				Statement stat = con.createStatement();
				
				ResultSet rs2 = stat.executeQuery(q2);
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
				while(rs2.next()){	
			%>
			
			<tr>
				<td scope="row"><%= rs2.getString(1) %></td>
				<td><%= rs2.getString(2) %></td>
				<td><%= rs2.getString(3) %></td>
				<td><%= rs2.getString(4) %></td>
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
		<a href="employeeList.jsp" style="text-decoration: none;">Back....</a>
	</div>
	<script>
		var loader = document.getElementById('preloder');
		function lod(){
			loader.style.display = 'none';
		}
	</script>
</body>
</html>