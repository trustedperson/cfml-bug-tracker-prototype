<cfif trim(form.login) eq "" OR trim(form.firstname) eq "" OR trim(form.lastname) eq ""
	OR trim(form.password) eq "">
	<cfcookie name="umessage" value="Please fill all text fields">
	<cflocation addtoken="false" url="user.cfm/?action=edit">
</cfif>
<cfquery name="check" datasource="bugtracker">
	SELECT login FROM users WHERE id = <cfqueryparam value="#form.id#">
</cfquery>
<cfif check.login NEQ "">
	<cfset salt = hash(GenerateSecretKey("AES"), "SHA-512")>
	<cfset password = hash(#form.password# & #salt#, "SHA-512")>
	<cfquery name="update_user" datasource="bugtracker">
		UPDATE users 
		SET 
		login = <cfqueryparam value="#form.login#">,
		firstname = <cfqueryparam value="#form.firstname#">,
		lastname = <cfqueryparam value="#form.lastname#">,
		password = <cfqueryparam value="#password#">,
		salt = <cfqueryparam value="#salt#">
		WHERE
		id = <cfqueryparam value="#form.id#">
	</cfquery>
	<cfcookie name="umessage" value="User info saved, sir!">
	<cflocation addtoken="false" url="userlist.cfm">
</else>
	<cfcookie name="umessage" value="No such user">
	<cflocation addtoken="false" url="user.cfm/?action=edit">
</cfif>