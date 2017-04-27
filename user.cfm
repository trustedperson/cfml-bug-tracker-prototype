<!--- default values --->
<cfparam name="url.action" default="edit">
<cfparam name="url.id" default="1">
<cfparam name="button_type" default="save">
<cfparam name="title" default="New user">
<!---  --->

<cfswitch expression="#url.action#">

	<cfcase value="edit">
		<cfset title="Edit user">
		<cfset form_handler="update_user.cfm">
		<cfquery name="getUser" datasource="bugtracker">
			SELECT * FROM users WHERE id = <cfqueryparam value="#url.id#">
		</cfquery>
		<cfset login="#getUser.login#">
		<cfset firstname="#getUser.firstname#">
		<cfset lastname="#getUser.lastname#">
	</cfcase>
	
	<cfcase value="new">
		<cfset form_handler="create_user.cfm">
		<cfset login="">
		<cfset firstname="">
		<cfset lastname="">
		<cfset button_type="create">
	</cfcase>

</cfswitch>

<cfoutput>
	<div class="heading">
		<div class="heading__text">
			#title#
		</div>
	</div>
	<br>
</cfoutput>
<cfoutput>
	<form class="user-form" action="#form_handler#" method="post">
		<input type="hidden" name="id" value="#url.id#">
		<input class="user-form__login" type="text" name="login" value="#login#" placeholder="type login here">
		<input class="user-form__password" type="password" name="password" placeholder="password">
		<input class="user-form__firstname" type="text" name="firstname" value="#firstname#" placeholder="firstname">
		<input class="user-form__lastname" type="text" name="lastname" value="#lastname#" placeholder="lastname">
		<button class="button">#button_type#</button>
	</form>
</cfoutput>