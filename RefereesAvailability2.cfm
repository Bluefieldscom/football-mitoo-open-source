<cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfinclude template="queries/qry_QRefereesAvailability2.cfm">
<cfif QRefereesAvailability2.RecordCount IS 0 >
	<br />
	<span class="pix13bold">No availability</span>
	<cfabort>
</cfif>
<table align="center" border="0" cellpadding="3" cellspacing="1">
	<cfoutput query="QRefereesAvailability2" group="RefsName">
		<tr align="center">
			<td align="left" width="450" height="40" colspan="2" valign="bottom"><span class="pix13bold">#RefsName#</span></td>
		</tr>
			<cfoutput group="MatchYear">
				<tr>
					<td align="left" height="15" colspan="2" valign="bottom"  bgcolor="LightGreen"><span class="pix10bold">#MatchYear#</span></td>
				</tr>
				<cfoutput group="MatchMonth">
					<tr>
						<td align="left" height="15" colspan="2" valign="bottom" bgcolor="LightGreen"><span class="pix10bold">#MatchMonth#</span></td>
					</tr>
					<cfoutput>
						<tr>
							<td align="left" <cfif Available IS "Yes">bgcolor="LightGreen"<cfelse>bgcolor="Pink"</cfif> width="150"><span class="pix10">#DateFormat( MatchDate , "DDDD DD")#</span></td>
							<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
							<!--- only show the Notes if fully logged in --->
								<td align="left" <cfif Available IS "Yes">bgcolor="LightGreen"<cfelse>bgcolor="Pink"</cfif> width="300" ><span class="pix10">#Notes#</span></td>
							</cfif>
						</tr>
					</cfoutput>
				</cfoutput>
			</cfoutput>
	</cfoutput>
</table>
