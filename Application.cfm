<cfapplication name="bugtracker"
	clientmanagement="Yes"
	sessionmanagement="Yes"
	sessiontimeout=#createTimeSpan(0,0,30,0)#
	loginStorage = "session">

<cfset homepage="http://127.0.0.1:8500/">
<cfset dsn="bugtracker">
<cfset content=CGI.SCRIPT_NAME>


<cflogin> 
	<cfif NOT isDefined("cflogin")> 
		<cfset content="index.cfm">
		<cfinclude template="template.cfm">
		<cfabort> 
	<cfelse> 
		<cfif cflogin.name IS "" OR cflogin.password IS ""> 
	        <cfcookie name="umessage" value="You must enter text in both the User Name and Password fields.">
			<cflocation addtoken="false" url="index.cfm">
	    <cfelse>
	    	<cfquery name="loginQuery" dataSource="#dsn#"> 
			    SELECT *
			    FROM users 
			    WHERE login=<cfqueryparam value='#cflogin.name#' CFSQLTYPE="CF_SQL_VARCHAR">
	 
		    </cfquery>	
			<cfif loginQuery.login NEQ ""> 
				<cfif loginQuery.password EQ hash(#cflogin.password# & loginQuery.salt, "SHA-512", "utf-8")>
	                <cfloginuser name="#cflogin.name#" Password = "#cflogin.password#" 
	                    roles="user">
	                <cflock timeout=20 scope="Session" type="Exclusive">
						<cfset Session.id = loginQuery.id>
					</cflock>
				<cfelse>
					<cfcookie name="umessage" value="Your login information is not valid.">
					<cflocation addtoken="false" url="index.cfm">
	            </cfif>
            <cfelse> 
                <cfcookie name="umessage" value="Your login information is not valid.">
				<cflocation addtoken="false" url="index.cfm"> 
            </cfif>
		 
		</cfif>
	</cfif> 
</cflogin>

<cflock timeout=20 scope="Session" type="Exclusive">
	<cfset user_id=#session.id#>
</cflock>

<cfinclude template="template.cfm">
<cfabort>