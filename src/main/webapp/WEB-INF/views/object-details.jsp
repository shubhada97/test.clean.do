<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Object Details</title>


<script
	src="https://www.kryogenix.org/code/browser/sorttable/sorttable.js"></script>

<script type="text/javascript">
	function myFunction() {
		// Declare variables
		var input, filter, table, tr, td, i, txtValue,table1;
		input = document.getElementById("myInput");
		filter = input.value.toUpperCase();
		table = document.getElementById("myTable");
		tr = table.getElementsByTagName("tr");

		// Loop through all table rows, and hide those who don't match the search query
		for (i = 0; i < tr.length; i++) {
			td = tr[i].getElementsByTagName("td")[0];
			if (td) {
				txtValue = td.textContent || td.innerText;
				if (txtValue.toUpperCase().indexOf(filter) > -1) {
					tr[i].style.display = "";
				} else {
					tr[i].style.display = "none";
				}
			}
		}
	}
</script>


<style type="text/css">
tr:nth-child(even) {
	background: #FFFFFF
}

tr:nth-child(odd) {
	background: #f0f2f1
}

tr:hover {
	background-color: #89ae37;
}
circle {
  position: relative;
  width: 150px;
  height: 150px;
  margin: 0.5rem;
  border-radius: 50%;
  background: #FFCDB2;
  overflow: hidden;
}
circle:inner {
  display: flex;
  justify-content: center;
  align-items: center;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 115px;
  height: 115px;
  background: #000;
  border-radius: 50%;
  font-size: 1.85em;
  font-weight: 300;
  color: rgba(255, 255, 255, 0.75);
}
table {
	border-collapse: collapse;
	border-bottom: 1px solid gray;
	font-family: Tahoma, Verdana, Segoe, sans-serif;
	width: 100%;
	table-layout: fixed;
}
#Firsttable
{
border-collapse: collapse;
	border-bottom: 1px solid gray;
	font-family: Tahoma, Verdana, Segoe, sans-serif;
	width: 50%;
	table-layout: fixed;
}

tr {
	border-top: 1px solid gray;
	text-align: left;
}

th {
	border-bottom: 1px solid gray;
	background: none repeat scroll 0 0 #c0c0c0;
	padding: 10px;
	color: #7872f8;
}

#myInput {
	background-image: url('/css/searchicon.png');
	/* Add a search icon to input */
	background-position: 10px 12px; /* Position the search icon */
	background-repeat: no-repeat; /* Do not repeat the icon image */
	width: 100%; /* Full-width */
	font-size: 16px; /* Increase font-size */
	padding: 12px 20px 12px 40px; /* Add some padding */
	border: 1px solid #ddd; /* Add a grey border */
	margin-bottom: 12px; /* Add some space below the input */
}

#wrapper {
	width: 100%;
	margin-top: 0px;
}

#header {
	width: 100%;
	background: #c0c0c0;
	margin-top: 0px;
	padding: 15px 0px 15px 15px;
}

#header h2 {
	width: 100%;
	margin: auto;
	color: #FFFFFF;
}

#container {
	width: 100%;
	margin: auto
}

#container h3 {
	color: #000;
}

#container #content {
	margin-top: 20px;
}
.range_cust_input{
pointer-events:none;
}
</style>



</head>
<body>
	
	<div align="center" id="wrapper">
		<div id="header">
        <div>
            <h2 align="center" >${objectName}</h2>
            <div>Name: ${user.name}</div>
            <div>Email: ${user.email}</div>
           
        </div>
        
        <form id="logoutForm" method="POST" action="/logout">
            <button type="submit" style="margin-top: 2rem; align-items: flex-end;">Log Out</button>
        </form>
			
		</div>
	</div>
	<div align="center" id="container">
		<div id="content">
			<input type="text" id="myInput" onkeyup="myFunction()"
				placeholder="Search for field..">
			<div >
				<!-- Table here -->
				<table id="myTable"  style="float: left">

					<tr>
						<th>Field Name</th>
						<th>Type</th>
						<th>Populated</th>
						
						
					</tr>
						
					<c:forEach var="temp" items="${fields}" varStatus="status">

						<tr>

							
							<td>${temp.getKey()}</td>
							<td>${temp.getValue()}</td>
					 <td>
					 <input class="range_cust_input" min="0" max="60" type="range" value=${percentage.get(status.index)} /> ${percentage.get(status.index)}%
					 </td>

						</tr>

					</c:forEach>
				
					

				</table>
			</div>
		
		</div>


	</div>
</body>
</html>