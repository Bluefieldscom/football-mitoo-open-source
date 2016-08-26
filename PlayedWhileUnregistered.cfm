<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfinclude template="queries/qry_PlayedWhileUnregistered.cfm">
<cfif PlayedWhileUnregistered.RecordCount GT "0">
	<table border="0" align="center" cellpadding="3" cellspacing="1" class="loggedinScreen">
		<cfoutput query="PlayedWhileUnregistered" group="PlayerDescription">
		<tr>
			<td height="40" valign="bottom" >
			<a href="LUList.cfm?LeagueCode=#LeagueCode#&TblName=Player&FirstNumber=#PlayerRegNo#&LastNumber=#PlayerRegNo#"><span class="pix13bold">#PlayerDescription#</span></a>
			</td>
		</tr>
		<!---    <a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=#HomeAway#">see Team Sheet</a> --->
		<cfoutput>
			<cfif CurrentRow Mod 2 IS 0 >
				<tr>
					<cfif HomeAway IS 'H'>
						<td colspan="2"><span class="pix13">#DateFormat(FixtureDate, 'DDDD, DD MMMM YYYY')# - <strong>#HomeTeam# #HomeOrdinal#</strong> v #AwayTeam# #AwayOrdinal# </span></td>
					<cfelse>
						<td colspan="2"><span class="pix13">#DateFormat(FixtureDate, 'DDDD, DD MMMM YYYY')# - #HomeTeam# #HomeOrdinal# v <strong>#AwayTeam# #AwayOrdinal#</strong> </span></td>
					</cfif>	
				</tr>	
			<cfelse>
				<tr>
					<cfif HomeAway IS 'H'>
						<td colspan="2"><span class="pix13">#DateFormat(FixtureDate, 'DDDD, DD MMMM YYYY')# - <strong>#HomeTeam# #HomeOrdinal#</strong> v #AwayTeam# #AwayOrdinal# </span></td>
					<cfelse>
						<td colspan="2"><span class="pix13">#DateFormat(FixtureDate, 'DDDD, DD MMMM YYYY')# - #HomeTeam# #HomeOrdinal# v <strong>#AwayTeam# #AwayOrdinal#</strong> </span></td>
					</cfif>	
				</tr>	
			</cfif>
		</cfoutput>
		
		</cfoutput>
	</table>
<cfelse>
		<span class="pix13bold"><BR><BR>There are no matches where unregistered players made appearances.</span>
</cfif>	


