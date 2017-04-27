<cfquery name="userlist" datasource="bugtracker">
	SELECT * FROM users
</cfquery>
<div class="heading">
	<div class="heading__text">
		User list
	</div>
</div>
<br>
<table class="table-users table-bugs">
	<tr>
		<th class="table-users__cell-head">
			name
		</th>
		<th class="table-users__cell-head">
			creation date
		</th>
	</tr>
	<cfoutput query="userlist">
		<tr>
			<td class="table-users__cell-description">
				<a class="table-users__description" href="user.cfm/?action=edit&id=#id#">
					#firstname# #lastname#	
				</a>
			</td>
			<td class="table-users__cell">
				#created_at#
			</td>
		</tr>
	</cfoutput>
</table>