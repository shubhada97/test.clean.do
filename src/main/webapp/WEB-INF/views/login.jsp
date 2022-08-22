<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style type="text/css">
body {
    margin: 0;
    overflow-x: hidden;
    width: 100%;
}
.main_area{
display:flex;
min-width:100vw;
min-height:100vh;
}

.img_area {
    width: 50%;
    padding: 50px;
    background-image: url(//www.salesforce.com/content/dam/web/en_us/www/images/login-promos/login-df-2022-registration-bg.png);
    background-size: cover;
    background-repeat: no-repeat;
}
.login_area {
    font-family: sans-serif;
        background: #fbfbfb;
}
.login_area h1 {
    text-align: center;
    margin: 15px 0 30px;
    color: #000;
    font-size: 26px;
    font-weight: 400;
}
.bg_blue {
    padding: 0 ;
    border-radius: 10px;
    display: flex;
    width:max-content;
    margin:0 auto;
}
.login_area{

width:50%;
padding:13% 50px;
}
.bg_blue a {
    text-decoration: none;
    display: block;
   min-width: 100px;
    color: #585858;
    padding: 8px 25px;margin: 10px;
    font-size: 15px;
    text-align:center;
    background: white;
    border-radius: 5px;
    border: 1px solid #ddd;
    box-shadow: 0 0 6px #ddd;
}
.bg_blue a:hover {
    background: #00a1e0;
    color: #fff;
    border-color: #00a1e0;
}
.login_area .inner_area {
    padding: 35px 20px 35px;
    border: 1px solid #00a1e0;
    background: #00a1e003;
    border-radius: 10px;
}
</style>

</head>
    <body>
    <div class="main_area">
		<div class="login_area">
			<div class="inner_area">
			<h1>Login to Salesforce</h1>
   			<div class="bg_blue">
            <a href="salesforce/login">Production</a>
            <a href="salesforce1/login">Sandbox</a>
			</div>
        </div>
        </div>
        <div class="img_area">
        </div>
        </div>
     
    </body>
</html>