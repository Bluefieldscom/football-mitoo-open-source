<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfinclude template="queries/qry_PlayedWhileSuspended.cfm">
<cfif PlayedWhileSuspended.RecordCount GT "0">
	<table border="1" align="center" cellpadding="8" cellspacing="1" class="loggedinScreen">
		<cfoutput query="PlayedWhileSuspended">
		<tr bgcolor="silver">	
			<td colspan="2"><span class="pix13bold">#DateFormat(FixtureDate, 'DDDD, DD MMMM YYYY')# - #HomeClub# #HomeOrdinal# v #AwayClub# #AwayOrdinal#</span></td>
		</tr>	
		<tr>	
			<td><span class="pix13">#Forename# <strong>#Surname#</strong> of #RegTeam#</span></td>
			<td><span class="pix10"><a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=#HomeAway#">see Team Sheet</a></span><span class="pix13"> Played while suspended from #DateFormat(FirstDay, 'DD MMM YYYY')# to #DateFormat(LastDay, 'DD MMM YYYY')#</span></td>
		</tr>	
		

		</cfoutput>
	</table>
<cfelse>
		<span class="pix13bold"><BR><BR>There are no matches where suspended players made appearances.</span>
</cfif>	