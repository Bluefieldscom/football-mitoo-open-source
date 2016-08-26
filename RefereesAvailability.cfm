<cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfinclude template="queries/qry_QRefereesAvailability.cfm">
<cfif QRefereesAvailability.RecordCount IS 0>
	<br />
	<span class="pix13bold">No availability</span>
	<cfabort>
</cfif>
<table align="center" border="0" cellpadding="3" cellspacing="1">
	<cfoutput query="QRefereesAvailability" group="MatchDate">
			<tr>
				<td align="left" width="450" height="40" colspan="2" valign="bottom" bgcolor="silver"><span class="pix13bold">#DateFormat( MatchDate , "DDDD DD MMMM YYYY")#</span></td>
			</tr>
		<cfoutput group="Available">
			<cfoutput>
				<tr>
					<td align="left" <cfif Available IS "Yes">bgcolor="LightGreen"<cfelse>bgcolor="Pink"</cfif>  width="150"><span class="pix10">#RefsName#</span></td>
						<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
						<!--- only show the Notes if fully logged in --->
							<td align="left" <cfif Available IS "Yes">bgcolor="LightGreen"<cfelse>bgcolor="Pink"</cfif> width="300"><span class="pix10">#Notes#</span></td>
						</cfif>
				</tr>
			</cfoutput>
		</cfoutput>
	</cfoutput>
</table>
