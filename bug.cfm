<!--- default values --->
<cfparam name="url.action" default="new">
<cfparam name="url.id" default="1">
<cfparam name="short_description" default="">
<cfparam name="full_description" default="">
<cfparam name="real_status" default="">
<cfparam name="real_importance" default="">
<cfparam name="real_criticalness" default="">
<cfparam name="readonly" default="">
<cfparam name="show_form_button" default="true">
<cfparam name="button_text" default="Create">
<cfparam name="show_edit_button" default="false">
<cfparam name="show_status_selector" default="false">
<cfparam name="show_bug_records" default="true">
<cfparam name="title" default="New bug">
<cfparam name="disable_list" default="">
<!---  --->

<!--- read case --->
<cfif url.action eq "read">
	<cfset show_status_selector="true">
	<cfset button_text="">
	<cfset title="Bug info">
	<cfset form_handler="">
	<cfset show_edit_button="true">
	<cfset readonly="readonly">
	<cfquery name="bugQuery" datasource="bugtracker">
		SELECT * FROM bugs WHERE id = <cfqueryparam value="#url.id#">
	</cfquery>
	<cfset short_description="#bugQuery.short_description#">
	<cfset full_description="#bugQuery.full_description#">
	<cfset real_status="#bugQuery.status#">
	<cfset real_importance="#bugQuery.importance#">
	<cfset real_criticalness="#bugQuery.criticalness#">
	<cfset real_criticalness="#bugQuery.criticalness#">
	<cfset show_form_button="false">
	<cfset disable_list="disabled">

<!--- create case --->
<cfelseif url.action eq "new">
	<cfset show_bug_records="false">
	<cfset form_handler="create_bug.cfm">
	<cfif structKeyExists(cookie, "short_description")>
		<cfset short_description="#cookie.short_description#">
	</cfif>
	<cfif structKeyExists(cookie, "full_description")>
		<cfset full_description="#cookie.full_description#">
	</cfif>
	<cfif structKeyExists(cookie, "status")>
		<cfset real_status="#cookie.status#">
	</cfif>
	<cfif structKeyExists(cookie, "importance")>
		<cfset real_importance="#cookie.importance#">
	</cfif>
	<cfif structKeyExists(cookie, "criticalness")>
		<cfset real_criticalness="#cookie.criticalness#">
	</cfif>

<!--- edit case --->
<cfelseif url.action eq "edit">
	<cfset show_status_selector="true">
	<cfset button_text="Save">
	<cfset title="Edit bug">
	<cfset form_handler="edit_bug.cfm">
	<cfquery name="bugQuery" datasource="bugtracker">
		SELECT * FROM bugs WHERE id = <cfqueryparam value="#url.id#">
	</cfquery>
	<cfset short_description="#bugQuery.short_description#">
	<cfset full_description="#bugQuery.full_description#">
	<cfset real_status="#bugQuery.status#">
	<cfset real_importance="#bugQuery.importance#">
	<cfset real_criticalness="#bugQuery.criticalness#">

</cfif>



<cfquery name="criticalness_list" datasource="bugtracker"> SELECT * FROM criticalness_list </cfquery>
<cfquery name="importance_list" datasource="bugtracker"> SELECT * FROM importance_list </cfquery>
<cfquery name="status_list" datasource="bugtracker"> SELECT * FROM status_list </cfquery>

<cfoutput>
	<div class="heading">
		<p class="heading__text">
			#title#
		</p>
	</div>
	<br>
</cfoutput>
<cfif show_edit_button>
	<cfoutput>
		<br>
		<a class="edit-button" href="bug.cfm/?action=edit&id=#url.id#">edit bug</a>
		<br>
	</cfoutput>
</cfif>

	<cfoutput>
		<form class="bug-form" action="#form_handler#" method="post">
			<input type="hidden" name="id" value="#url.id#">
			<input class="bug-form__short-description" type="text" name="short_description" #readonly# value="#short_description#" placeholder="short description">
			<textarea class="bug-form__full-description" name="full_description" #readonly# placeholder="type here please" autocomplete="off">#full_description#</textarea>
	</cfoutput>
		

		<select class="bug-form__select" name="importance">
			<cfoutput query="importance_list">
				<option value="#importance#"
					<cfif #real_importance# eq #importance#>
						selected
					</cfif>
				#disable_list#>
					#importance#
				</option>
			</cfoutput>
		</select>

		<select class="bug-form__select" name="criticalness">
			<cfoutput query="criticalness_list">
				<option value="#criticalness#"
					<cfif #real_criticalness# eq #criticalness#>
						selected
					</cfif>
				#disable_list#>
					#criticalness#
				</option>
			</cfoutput>
		</select>
		
		<cfif #show_status_selector#>
			<select class="bug-form__select" name="status">
				<cfoutput query="status_list">
					<option value="#status#" 
						<cfif #real_status# eq #status#>
							selected
						</cfif>
					#disable_list#>
							#status#
					</option>

				</cfoutput>
			</select>
		</cfif>

		<cfif #show_form_button#>
			<cfoutput>
				<button class="bug-form__button">#button_text#</button>
			</cfoutput>
		</cfif>
		<br>
		<textarea class="bug-form__comment" name="comment" placeholder="leave comment"></textarea>
	</form>

<cfif show_bug_records>
	<cfquery name="getBugRecords" datasource="bugtracker">
		SELECT *, firstname, lastname 
		FROM bug_records as br, users as u 
		WHERE bug_id = <cfqueryparam value="#url.id#"> AND br.user_id = u.id 
		ORDER BY action_date ASC

	</cfquery>
	<br>
		<div class="bug-records">
			<cfoutput query="getBugRecords">
					<span class="bug-records__status">
						#action#
					</span>
					
					<span class="bug-records__date">
						#action_date# 
					</span>
					<span class="bug-records__status">
						by 
					</span>
					<span class="bug-records__name">
						#firstname# #lastname#
					</span>
					<br>

					<div class="bug-records__comment">
						#comment#
					</div>
			<br>
			<hr>
			</cfoutput>
		</div>
</cfif>
<!---  erase cookies --->
<cfcookie name="short_description" expires="now">
<cfcookie name="full_description" expires="now">
<cfcookie name="importance" expires="now">
<cfcookie name="criticalness" expires="now">