<cfif trim(form.short_description) eq "" OR trim(form.full_description) eq "">
	<cfcookie name="umessage" value="Please fill all text fields">
	<cfcookie name="short_description" value="#form.short_description#">
	<cfcookie name="full_description" value="#form.full_description#">
	<cfcookie name="importance" value="#form.importance#">
	<cfcookie name="criticalness" value="#form.criticalness#">
	<cflocation addtoken="false" url="bug.cfm/?action=new">
</cfif>

<cfquery name="create_bug" datasource="bugtracker" result="result">
	INSERT INTO bugs (short_description, full_description, user_id, status, importance, criticalness, created_at) 
	VALUES (
		<cfqueryparam value="#form.short_description#">,
		<cfqueryparam value="#form.full_description#">,	
		<cfqueryparam value="#user_id#">,	
		<cfqueryparam value="new">,
		<cfqueryparam value="#form.importance#">,
		<cfqueryparam value="#form.criticalness#">,
		NOW()
		)
</cfquery>
<cfquery name="setRecord" datasource="bugtracker">
	INSERT INTO bug_records (
		bug_id,
		action_date,
		action,
		comment,
		user_id
		)
	VALUES (
		<cfqueryparam value="#result.GENERATEDKEY#">,
		NOW(),
		<cfqueryparam value="created">,
		<cfqueryparam value="initial comment">,
		<cfqueryparam value="#user_id#">
		)
</cfquery>
<cfcookie name="short_description" expires="now">
<cfcookie name="full_description" expires="now">
<cfcookie name="importance" expires="now">
<cfcookie name="criticalness" expires="now">
<cfcookie name="umessage" value="Successfully created, sir!">
<cflocation addtoken="false" url="bug.cfm/?id=#result.GENERATEDKEY#&action=read">
