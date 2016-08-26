<!--- called by AppearancesQuery.cfm, FutureScheduledDates.cfm --->
<cfinclude template="queries/qry_GetTeam.cfm">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="LEFT">
			<select name="TID" size="1">
				<cfoutput query="GetTeam" >
					<cfif TIDSelected IS "#ID#">
						<OPTION VALUE="#ID#" selected >#TeamName#</OPTION>
					<cfelse>
						<OPTION VALUE="#ID#">#TeamName#</OPTION>
					</cfif>
				</cfoutput>
				<cfif FindNoCase("AppearancesQuery.cfm", CGI.Script_Name) >
					<cfif TIDSelected IS "ANY CLUB">
						<OPTION VALUE="ANY CLUB" selected >ANY CLUB</OPTION>
					<cfelse>
						<OPTION VALUE="ANY CLUB">ANY CLUB</OPTION>
					</cfif>
					<cfif TIDSelected IS "ANY OTHER CLUB">
						<OPTION VALUE="ANY OTHER CLUB" selected >ANY OTHER CLUB</OPTION>
					<cfelse>
						<OPTION VALUE="ANY OTHER CLUB">ANY OTHER CLUB</OPTION>
					</cfif>
				</cfif>
			</select>
		</td>
	</tr>
</table>
