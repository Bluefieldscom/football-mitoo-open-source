<!--- called by AppearancesQuery.cfm, FutureScheduledDates.cfm --->
<cfinclude template="queries/qry_GetOrdinal.cfm">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<select name="OID" size="1">
				<cfoutput query="GetOrdinal" >
					<cfif TRIM(OrdinalName) IS "">
						<cfset ThisOrdinalName = "1st Team">
					<cfelse>
						<cfset ThisOrdinalName = "#OrdinalName#">
					</cfif>
					<cfif OIDSelected IS "#ID#">
						<OPTION VALUE="#ID#" selected >#ThisOrdinalName#</OPTION>
					<cfelse>
						<OPTION VALUE="#ID#">#ThisOrdinalName#</OPTION>
					</cfif>
				</cfoutput>
				<cfif FindNoCase("AppearancesQuery.cfm", CGI.Script_Name) >
					<cfif OIDSelected IS "ANY TEAM">
						<OPTION VALUE="ANY TEAM" selected>ANY TEAM</OPTION>
					<cfelse>
						<OPTION VALUE="ANY TEAM">ANY TEAM</OPTION>
					</cfif>
				</cfif>
			</select>
		</td>
	</tr>
</table>
