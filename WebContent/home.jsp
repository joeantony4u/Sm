<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- saved from url=(0078)file:///D:/Gears/Programmer/HTML%205/MetaLab/np%20%20%20METATAB.htm -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

<title>Login | STOMAN</title>
<link href="./resources/style.css" rel="stylesheet" type="text/css"	media="all"/>
<script src="dwr/engine.js"	type="text/javascript"></script>
<script src="dwr/interface/Authenticate.js"	type="text/javascript"></script>
<script type="text/javascript">
var onJQueryLoad = function() {
	loadAsyncScripts(['./resources/common.js', './resources/login.js']);	
};
window.onload = function() {
	loadAsyncScripts(['./resources/jquery-1.4.js']);
	document.getElementById('username').focus();
};

function loadAsyncScripts(asyncScripts) {
	var head = document.getElementsByTagName("head")[0];
	for(as in asyncScripts) {
		var script = document.createElement("script");
		script.setAttribute("src", asyncScripts[as]);
		head.appendChild(script);
	}
}
</script>
</head>
<body style="background: #273433;"> <!-- 376d9f -->
<div id="main">
<div id="head">
<div id="head-main">
<div id="head-sup">
<h1><a href="index.htm" class=""></a></h1>
<ul id="menu">
</ul>
</div>
</div>
</div>
<div id="center">
<div id="center-main">
<div id="center-sup">
<div id="bannertop">
<div id="container">
	<img align="left" src="./images/Bulldozer.png"
	style="display: none; padding-top: 135px; padding-left: 100px;"></img>
	<img src="./images/caption.png" 
	style="display: none; padding-top: 280px; padding-left: 50px;"/>
	
</div>
</div>
</div>
</div>
</div>


<div id="btmtext-home">
<div id="btmtext-main">

<form id="login-form" class="login-container" >
<table>
<tbody >
	<tr>
		<td>
		<fieldset>
			<legend onclick="document.getElementById('username').focus();">User { code }</legend>
			<input type="text" class="login-text" spellcheck="false" 
			 id="username" tabindex="1" style="padding-top: 9px;" onfocus="this.select()"/>
		</fieldset>
			
		</td>
		<td style="padding-left: 50px;">
		<fieldset>
			<legend onclick="document.getElementById('password').focus();">Pass { code }</legend>
			<input class="login-text"
				type="password" id="password" tabindex="2" style="padding-top: 9px;" onfocus="this.select()"/>
		</fieldset>
		</td>
		<td valign="middle" style="padding-left: 50px;">
			<a href="javascript:authenticate()"
				id = "login-button" class="login-button" tabindex="3">LOGIN</a>
		</td>
	</tr>
</tbody>
</table>
</form>

<div id="footer" align="center">
<p><font size="1px" color="#C8C6C2">STOMAN. From the minds of Joe &amp; Binu with the help of internet.</font></p>

</div>
</div>
</div>
</div>
</body>
</html>