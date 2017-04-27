<cfif trim(form.short_description) eq "" OR trim(form.full_description) eq "">
	<cfcookie name="umessage" value="Please fill all text fields">
	<cfcookie name="short_description" value="#form.short_description#">
	<cfcookie name="full_description" value="#form.full_description#">
	<cfcookie name="status" value="#form.status#">
	<cfcookie name="importance" value="#form.importance#">
	<cfcookie name="criticalness" value="#form.criticalness#">
	<cflocation addtoken="false" url="bug.cfm/?action=edit&id=#form.id#">
</cfif>

<cfquery name="dbStatus" datasource="bugtracker">
	SELECT status FROM bugs WHERE id = <cfqueryparam value="#form.id#"> 
</cfquery>

<cfif #form.status# NEQ dbStatus.status>
	<cfset changed="true">
<cfelse>
	<cfset changed="false">
</cfif>

<!--- check incorrect status change (from any to new) --->
<cfif changed AND (#form.status# EQ "new")>
	<cfcookie name="umessage" value="Cannot change status to new">

	<cflocation addtoken="false" url="bug.cfm/?action=edit&id=#form.id#">
</cfif>

<!--- check incorrect status change (from closed to any) --->
<cfif changed AND (dbStatus.status EQ "closed")>
	<cfcookie name="umessage" value="Cannot change status from closed">
	
	<cflocation addtoken="false" url="bug.cfm/?action=edit&id=#form.id#">
</cfif>

<!--- check status change without comment --->
<cfif changed AND (trim(#form.comment#) EQ "")>
	<cfcookie name="umessage" value="Please enter comment before changing status">
	
	<cflocation addtoken="false" url="bug.cfm/?action=edit&id=#form.id#">
</cfif>
<!---  --->

<!--- at last, write to db --->
<cfquery name="edit_bug" datasource="bugtracker" result="result">
	UPDATE bugs
	SET short_description=<cfqueryparam value="#form.short_description#">,
		full_description=<cfqueryparam value="#form.full_description#">,
		user_id=<cfqueryparam value="#user_id#">,
		status=<cfqueryparam value="#form.status#">,
		importance=<cfqueryparam value="#form.importance#">,
		criticalness=<cfqueryparam value="#form.criticalness#">,
		created_at=NOW()
	WHERE bugs.id = <cfqueryparam value="#form.id#"> 
</cfquery>
<cfif changed>
	<cfquery name="setRecord" datasource="bugtracker">
	INSERT INTO bug_records(
		bug_id,
		action_date,
		action,
		comment,
		user_id
		)
	VALUES (
		<cfqueryparam value="#form.id#">,
		NOW(),
		<cfqueryparam value="#form.status#">,
		<cfqueryparam value="#form.comment#">,
		<cfqueryparam value="#user_id#">
		)
	</cfquery>
</cfif>
<cfcookie name="short_description" expires="now">
<cfcookie name="full_description" expires="now">
<cfcookie name="status" expires="now">
<cfcookie name="importance" expires="now">
<cfcookie name="criticalness" expires="now">
<cfcookie name="umessage" value="Successfully saved, sir!">
<cflocation addtoken="false" url="bug.cfm/?action=read&id=#form.id#">