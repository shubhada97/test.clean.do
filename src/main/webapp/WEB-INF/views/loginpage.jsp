<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
 <link href="css/loginpage.css" rel="stylesheet">
<meta charset="ISO-8859-1">

<title>Login To Salesforce</title>

 
<script>
	$("#checkBoxID").click(function() {
		$(".logBtn").attr("disabled", !this.checked);
	});

	function showLoader() {
		$('.loadTime').hide();
		$(".loader-wrap").css("display", "block");
		//$(".container").css("opacity","0.4");

	}

	$(".logBtn").click(function() {
		//showLoader(); 
		$('.sections-row ').hide();
	});

	$(document)
			.ready(
					function() {

						var url = window.location.href;
						url = new URL(url);

						var codePresent = url.searchParams.get("code");
						var stateNotNull = url.searchParams.get("state");

						if (codePresent != null || stateNotNull != null) {
							$(".loginViaAuthenticationBtn").click();
							showLoader();
						}

						if (readyToshow) {
							$('body')
									.html(
											'<div class="loader-wrap loader"> <img src="images/web.webp" style="display:block; width: 40%;"/> </div>')

							window.location.href = 'showReport';
							$(".loader-wrap").css("display", "block");
							//setTimeout(function(){  window.location.href = 'report'; },300);
						}
					});
	console.log('callfun');
	
	function singleSelectChangeValue() {
        //Getting Value
        //var selValue = document.getElementById("singleSelectDD").value;
        var selObj = document.getElementById("type_of_org").options[selObj.selectedIndex].value;
        var selValue = selObj.options[selObj.selectedIndex].value;
        //Setting Value
        document.getElementById("hrefFieldValueJS").value = selValue;
    }
</script>
</head>
<body>
	<div class="container">

		<div class="row sections-row bgWhite loadTime">
			<div class="sections-row-col col-md-5">

				  <div  class="logo-img-wrapper">
					<img src="https://app.clean.do/assets/img/Salesforce-checkup-logo.png" alt=""
						width="200px" class="img-fluid">
				</div>

				<div class="form-wrapper">

					<div class="card" style="background: #eee;">
						<div class="card-body" style="padding: 0.5rem !important;">
							<p class="text-dark">This application does not save any data
								from your Salesforce.com instance.</p>
						</div>
					</div>

					<div class="type-of-env-and-form-wrapper" style="margin-top: 2%;">
						<div class="env-wrapper"
							>
							<span style="color: #545454; font-size: 18px; font-weight: 600;">Type
								of Environment</span>
						</div>

						<form class="col-sm-12" method="post" action="index">

							<div class="form-inner-wrapper" style="">
								<div class="select-wrapper padding15">
									<select id="type_of_org" name="type_of_org"
										class="custom-select" 
										style="box-shadow: none; height: 55px; margin-top: 5px; max-width: 309px;">
										<option value="salesforce/login" selected="selected">Production</option>
										<option value="salesforce1/login">Sandbox</option>
									</select>

								</div>
								<div class="select-wrapper padding15">
									<input type="checkbox" id="checkBoxID"
										onchange="document.getElementById('loginbutton').disabled = !this.checked;"><span
										class="checkSpan">I authorize this tool to audit to my
										salesforce environment.</span>
								</div>

								<div class="btn-wrapper">
									 <input
										type="url" id="loginbutton" name="authenticate"
										class="btn btn-success logBtn" value="Login and Start"  onclick="location = document.getElementById('type_of_org').value"
										disabled>
										
									
								
								
								</div>
							</div>
						</form>
					</div>

				</div>
			</div>

			<div class="sections-row-col col-md-7 bgImg"></div>
		</div>




	</div>
	
</body>
</html>