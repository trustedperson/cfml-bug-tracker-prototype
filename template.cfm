<!DOCTYPE html>
<html lang="ru">
	<head>
		<base href="http://127.0.0.1:8500/">
		<meta charset="UTF-8">
    	<title>bugtracker</title>
    	<link rel="stylesheet" type="text/css" href="css/all_in.css">
    	<script type="text/javascript" src="js/ui.js"></script>
	</head>
	<body>
	<cfif GetAuthUser() NEQ "">
		<div class="menu">
			<div class="menu__element">
				<a class="menu__link" href="bug.cfm/?action=new">
					New bug
				</a>
			</div>
			<div class="menu__element">
				<a class="menu__link" href="buglist.cfm">
					Bug list
				</a>
			</div>
			<div class="menu__element">
				<a class="menu__link" href="user.cfm/?action=new">
					New user
				</a>
			</div>
			<div class="menu__element">
				<a class="menu__link" href="userlist.cfm">
					Users
				</a>
			</div>
			<div class="menu__element">
				<a class="menu__link" href="logout.cfm">
					Exit
				</a>
			</div>
		</div>
	</cfif>
	<!--- show user message, cookie based --->
	<cfif structKeyExists(cookie, "umessage")>
		<cfoutput>
			<div class="umessage">#cookie.umessage#</div>
		</cfoutput>
	</cfif>
	<cfcookie name="umessage" expires="now">
		<br>
	<!---  --->

		<cfinclude template="#content#">

	</body>
</html>