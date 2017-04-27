<cfif trim(form.login) eq "" OR trim(form.firstname) eq "" OR trim(form.lastname) eq ""
	OR trim(form.password) eq "">
	<cfcookie name="umessage" value="Please fill all text fields">
	<cflocation addtoken="false" url="user.cfm/?action=new">
</cfif>

	<cfset salt = hash(GenerateSecretKey("AES"), "SHA-512")>
	<cfset password = hash(#form.password# & #salt#, "SHA-512")>
	<cfquery name="create_user" datasource="bugtracker">
		INSERT INTO users(
			login,
			firstname,
			lastname,
			password,
			salt,
			created_at
			) 
		VALUES (
			<cfqueryparam value="#form.login#">,
			<cfqueryparam value="#form.firstname#">,
			<cfqueryparam value="#form.lastname#">,
			<cfqueryparam value="#password#">,
			<cfqueryparam value="#salt#">,
			NOW()
			)
	</cfquery>
	<cfcookie name="umessage" value="New user added, sir!">
	<cflocation addtoken="false" url="userlist.cfm">
