<cfparam name="url.page" default="0">
<cfparam name="sort_param" default="created_at">
<cfparam name="sql_order" default="DESC">
<cfparam name="column_order" default="ASC">


<cfif structKeyExists(url, "sort")>
	<cfif structKeyExists(url, "order")>	
		<cfif url.order eq "DESC">
			<cfset column_order = "ASC">	 
			<cfset sql_order = "DESC">	 
		<cfelse> 
			<cfset column_order = "DESC">
			<cfset sql_order = "ASC">
		</cfif>
	</cfif>
	<cfset cookie.sql_order = sql_order>
	<cfset sort_param = url.sort>
	<cfset cookie.sort = url.sort>

<cfelseif structKeyExists(cookie, "sort")>
	<cfset sort_param = cookie.sort>
</cfif>
<cfset sort_param = "bugs." & "#sort_param#">
<cfset url.page=val(url.page) * 10>
<cfquery name="buglist" datasource="bugtracker">
	SELECT *, firstname, lastname
	FROM bugs, users 
	WHERE bugs.user_id = users.id 
	ORDER BY #sort_param# #sql_order#
	LIMIT 10 OFFSET <cfqueryparam value='#url.page#' CFSQLTYPE="integer"> 

</cfquery>
<cfquery name="bugs" datasource="bugtracker">
	SELECT COUNT(id) as id FROM bugs
</cfquery>
<cfobject action="CREATE" type="JAVA" class="coldfusion.server.ServiceFactory" name="ServiceFactory">

<cfoutput>#ServiceFactory.LicenseService.getAllowedIp()#</cfoutput>
<cfoutput>
	<table class="table-bugs">
		<tr>
			<th class="table-bugs__cell-head">
				<a class="table-bugs__head" href="buglist.cfm/?sort=short_description&order=#column_order#">
					description
				</a>
			</th>
			<th class="table-bugs__cell-head">
				<a class="table-bugs__head" href="buglist.cfm/?sort=user_id&order=#column_order#">
					user
				</a>
			</th>
			<th class="table-bugs__cell-head">
				<a class="table-bugs__head" href="buglist.cfm/?sort=status&order=#column_order#">
					status
				</a>
			</th>
			<th class="table-bugs__cell-head">
				<a class="table-bugs__head" href="buglist.cfm/?sort=importance&order=#column_order#">
					importance
				</a>
			</th>
			<th class="table-bugs__cell-head">
				<a class="table-bugs__head" href="buglist.cfm/?sort=criticalness&order=#column_order#">
					critical
				</a>
			</th>
			<th class="table-bugs__cell-head">
				<a class="table-bugs__head" href="buglist.cfm/?sort=created_at&order=#column_order#">
					date
				</a>
			</th>
		</tr>
</cfoutput>
		<cfoutput query="buglist">
			<tr>
				<td class="table-bugs__cell table-bugs__cell-description">
					<a class="table-bugs__description" href="bug.cfm/?action=read&id=#buglist.id#">
						#short_description#
					</a>
				</td>
				<td class="table-bugs__cell">
					#firstname# #lastname#
				</td>
				<td class="table-bugs__cell">
					#status#
				</td>
				<td class="table-bugs__cell">
					#importance#
				</td>
				<td class="table-bugs__cell">
					#criticalness#
				</td>
				<td class="table-bugs__cell table-bugs__cell-date">
					#created_at#
				</td>
			</tr>
		</cfoutput>
	</table>
<br>

<cfif bugs.id gte 10>
	<cfoutput>
		<p class="pages">Pages</p>
	</cfoutput>
	<cfset pages = bugs.id / 10>
	<cfif (bugs.id % 10)>
			<cfset pages += 1>
	</cfif>	
	<cfset i=0>
	<cfloop condition="i lt pages-1">
		<cfoutput>
			
			<a class="page" href="buglist.cfm/?page=#i#"> #i+1# </a>
		</cfoutput>	
		<cfset i+=1>
	</cfloop>
</cfif>