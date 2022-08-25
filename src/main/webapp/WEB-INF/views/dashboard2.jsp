<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Salesforce Checkup By Techilla</title>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.7.2.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js">
	
</script>
<script
	src="https://cdn.rawgit.com/edenspiekermann/a11y-toggle/master/a11y-toggle.min.js">
	
</script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js">
	
</script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="https://use.fontawesome.com/releases/v5.6.3/css/all.css">
	 <link rel="stylesheet" href=
"https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script>
	$(document).ready(
			function() {
				$('.nav-tabs > li > a').click(
						function(event) {
							event.preventDefault();//stop browser to take action for clicked anchor

							//get displaying tab content jQuery selector
							var active_tab_selector = $(
									'.nav-tabs > li.active > a').attr('href');

							//find actived navigation and remove 'active' css
							var actived_nav = $('.nav-tabs > li.active');
							actived_nav.removeClass('active');

							//add 'active' css into clicked navigation
							$(this).parents('li').addClass('active');

							//hide displaying tab content
							$(active_tab_selector).removeClass('active');
							$(active_tab_selector).addClass('hide');

							//show target tab content
							var target_tab_selector = $(this).attr('href');
							$(target_tab_selector).removeClass('hide');
							$(target_tab_selector).addClass('active');
						});
			});
	function myFunction() {
		// Declare variables
		var input, filter, table, tr, td, i, txtValue;
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

	function showHideRow(row) {
		$("#" + row).toggle();
	}
	
	$(document).ready(function(){

	    // code to read selected table row cell data (values).
	    $("#myTable").on('click','.btnSelect',function(){
	         // get the current row
	         var currentRow=$(this).closest("tr"); 
	         
	         var col1=currentRow.find("td:eq(0)").text(); // get current row 1st TD value
	         var col2=currentRow.find("td:eq(1)").text(); // get current row 2nd TD
	         var col3=currentRow.find("td:eq(2)").text(); // get current row 3rd TD
	         var data=col1+"\n"+col2+"\n"+col3;
	         
	         alert(data);
	    });
	});
	
	
	

	
</script>
<style type="text/css">
.header {
	min-height: 10vh;
	background: #009FFF;
	color: white;
	clip-path: ellipse(100vw 60vh at 50% 50%);
	display: flex;
	align-items: center;
	justify-content: right;
}

.details {
	text-align: center;
}

.heading {
	font-weight: 400;
	font-size: 1.3rem;
	margin: 1rem 0;
	right: 10px;
}
/** Start: to style navigation tab **/
.nav {
	margin-bottom: 18px;
	margin-left: 0;
	list-style: none;
}

.nav>li>a {
	display: block;
}

.nav-tabs {
	*zoom: 1;
}

.nav-tabs:before, .nav-tabs:after {
	display: table;
	content: "";
}

.nav-tabs:after {
	clear: both;
}

.nav-tabs>li {
	float: left;
}

.nav-tabs>li>a {
	padding-right: 12px;
	padding-left: 12px;
	margin-right: 2px;
	line-height: 14px;
}

.nav-tabs {
	border-bottom: 1px solid white;
}

.nav-tabs>li {
	margin-bottom: -1px;
}

.nav-tabs>li>a {
	padding-top: 8px;
	padding-bottom: 8px;
	line-height: 18px;
	border: 1px solid transparent;
	-webkit-border-radius: 4px 4px 0 0;
	-moz-border-radius: 4px 4px 0 0;
	border-radius: 4px 4px 0 0;
}
/*
.nav-tabs>li>a:hover {
	border-color: #eeeeee #eeeeee #dddddd;
}*/

.nav-tabs>.active>a, .nav-tabs>.active>a:hover {
	color: #555555;
	cursor: default;
	
	
}

li {
	line-height: 18px;
}

.tab-content.active {
	display: block;
}

.tab-content.hide {
	display: none;
}

/** End: to style navigation tab **/

/** Object tab Start tr:nth-child(odd) {
	background: #f0f2f1
}
tr:nth-child(even) {
	background: #FFFFFF
}**/



tr:hover {
	background-color: #7872f8;
}

table, td {
	 
  border-collapse: collapse;
	font-family: Tahoma, Verdana, Segoe, sans-serif;
	width: 100%;
	table-layout: fixed;
}

.hidden_row {
	display: none;
}

tr {
	 background-color: White;
 padding: 15px;
	text-align: left;
}

th {
	
  border-collapse: collapse;
	background: none repeat scroll 0 0 #c0c0c0;
	  background-color: #f6f9fc;
 padding: 15px;
	color: #7872f8;
}
td
{
  background-color: White;
 padding: 15px;
}
#hidden_table_row, #hidden_table_header 
{

  border-collapse: collapse;
}
#hidden_table_data
{
 background-color:white;
 padding: 15px;
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

/** Object tab End**/

/** Dashboard tab**/

/** Progress Bar**/
@keyframes growProgressBar {
  0%, 33% { --pgPercentage: 0; }
  100% { --pgPercentage: var(--value); }
}

@property --pgPercentage {
  syntax: '<number>';
  inherits: false;
  initial-value: 0;
}

div[role="progressbar"] {
  --size: 12rem;
  --fg: #369;
  --bg: #def;
  --pgPercentage: var(--value);
  animation: growProgressBar 3s 1 forwards;
  width: var(--size);
  height: var(--size);
  border-radius: 50%;
  display: grid;
  place-items: center;
  background: 
    radial-gradient(closest-side, white 80%, transparent 0 99.9%, white 0),
    conic-gradient(var(--fg) calc(var(--pgPercentage) * 1%), var(--bg) 0)
    ;
  font-family: Helvetica, Arial, sans-serif;
  font-size: calc(var(--size) / 5);
  color: var(--fg);
}

div[role="progressbar"]::before {
  counter-reset: percentage var(--value);
  content: counter(percentage) '%';
}

/** Progress Bar**/

<style>
* {
  box-sizing: border-box;
}

body {
  font-family: Arial, Helvetica, sans-serif;
}

/* Float four columns side by side */
.column {
  float: left;
  width: 25%;
  padding: 0 20px;
}

/* Remove extra left and right margins, due to padding */
.row {margin: 0 -5px;}

/* Clear floats after the columns */
.row:after {
  content: "";
  display: table;
  clear: both;
}

/* Responsive columns */
@media screen and (max-width: 600px) {
  .column {
    width: 100%;
    display: block;
    margin-bottom: 20px;
  }
}

/* Style the counter cards */
.card {
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
  padding: 16px;
  text-align: center;
  background-color: #f1f1f1;
}

.card1 {
    margin-bottom: 30px;
    border: 0;
    box-shadow: 0 0 2rem 0rgba (136,152,170,.15);
    position: relative;
    display: flex;
    flex-direction: column;
    min-width: 0;
    word-wrap: break-word;
    border: 1pxsolidrgba (0,0,0,.05);
    border-radius: 0.375rem;
    background-color: white;
    background-clip: border-box;
}
.sidebar
{
 width: 250px;
  background-color: white;
  position: fixed;
  
  overflow: auto;
  height: 100%;
      padding-right: 0;
    padding-left: 0;
}
.tabcontent
{
 margin-left: 250px;
  padding: 1px 16px;
  height: 1000px;
 margin-top: 30px;
 
  
}
.profile
{
 margin-left: 250px;

}
.logo-img-wrapper {
	   position: fixed;
  
  overflow: auto;  
	top: 5%;
	display: flex;
	justify-content: left;
	align-items: left;
	width: 250px;
}

/* Header*/
.text-sm {
    margin: 20px;
    font-size: .875rem!important;
}

.font-weight-bold {
    font-weight: 600!important;
}
.mb-0, .my-0 {
    margin-bottom: 0!important;
}
.button {
  background-color: #4CAF50; /* Green */
  border: none;
  color: white;
  padding: 5px 10px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 10px 2px;
  transition-duration: 0.4s;
  cursor: pointer;
}


.button2 {
  background-color: #009FFF; 
  color: black; 
  border: 2px solid #008CBA;
}

.button2:hover {
  background-color: #008CBA;
  color: white;
}
</style>
</head>
<body>

	 <div  class="logo-img-wrapper">
					<img src="https://app.clean.do/assets/img/Salesforce-checkup-logo.png" alt=""
						width="200px" class="img-fluid">
				</div>

       
	<section class="profile">
	
		<header class="header">
		
			<div class="details">

				<h1 class="mb-0 text-sm  font-weight-bold">${user.name}</h1>
				<!--  <h1 class="mb-0 text-sm  font-weight-bold">${user.email}</h1>-->
				<form id="logoutForm" method="POST" action="/logout">
					<button class="button button2"
						style=" align-items: flex-end;">Sign Out</button>
				</form>
			</div>
		</header>
	</section>
	<div  class="sidebar">
		<ul class="nav nav-tabs nav nav-tabs flex-column">
			<li class="active"><a href="#tab1">Dashboard</a></li>
			<li><a href="#tab2">Objects</a></li>

		</ul>
	</div>
	
	
	<div class="tabcontent">
	<div class="card1">
	<section id="tab1" class="tab-content active">
		
		
		
		
		<div>
<div class="row">
  <div class="column">
    <div class="card">
      <h3> Objects</h3>
      <p>${ObjectCount}</p>
      
    </div>
  </div>

  <div class="column">
    <div class="card">
      <h3>Fields</h3>
      <p>${FieldCount}</p>
      
    </div>
  </div>
  
  <div class="column">
    <div class="card">
      <h3>Overall Percentage</h3>
      <div role="progressbar" aria-valuenow="65" aria-valuemin="0"
				aria-valuemax="100" style="--value:${overallPercentage}"></div>
    </div>
  </div>
  
  
</div>

		</div>
	

	</section>


	<section id="tab2" class="tab-content hide">

		<table >
			
				<tr>
					<th style="width: 20%;">Total</th>
					<th>Description</th>

				</tr>
			
			<tbody >
				<tr>
					<td>${size}</td>
					<td>All Custom objects</td>

				</tr>
				<tr></tr>
			</tbody>
		</table>

		<!-- detailed table -->
		<div align="center" id="container">
			<div id="content">
				<input type="text" id="myInput" onkeyup="myFunction()"
					placeholder="Search for object...">

				<!-- Table here -->
				<table id="myTable" class="sortable">
<thead>
					<tr style="background: #f6f9fc">

						<th>Label</th>
						<th>API NAME</th>
						<th>Populated</th>

					</tr>
</thead>
<tbody>
					<c:forEach items="${allObjects}" var="stop" varStatus="status">

						<tr   data-toggle="collapse" data-target="#${stop.getValue() }" aria-controls="collapseExample" >
							<td style="color: #cbcdcf;"> <c:out
										value="${stop.getKey()}" /></td>
							<td style="color: #cbcdcf;"><c:out value="${stop.getValue()}" /></td>
							<td style="color: #cbcdcf;"><c:out value="${result.get(stop.getValue())}%" /></td>
							</tr >
							
	

<tbody id=${ stop.getValue()} class="collapse " >
<tr class="hidden_table_row" >
						<th class="hidden_table_header">Field Name</th>
						<th class="hidden_table_header"></th>
						<th class="hidden_table_header">Populated</th>
						
						
					</tr>
				
</tbody>

<tbody >	


<c:forEach items="${MapObject.get(stop.getValue())}" var="stop1" varStatus="status"  >


<tr  id=${ stop.getValue()}  class="collapse " >

							
							<td class="hidden_table_data">${stop1.getKey()}</td>
							<td class="hidden_table_data"></td>
							<td class="hidden_table_data">${stop1.getValue()} %</td>
			<!-- <td>${stop.getValue()}</td> -->
						</tr>



</c:forEach>

</tbody>							


	</c:forEach>				
</tbody>

				</table>
				



			</div>
</section>

		</div>
		
		</div>
	
</div>
	



</body>
</html>