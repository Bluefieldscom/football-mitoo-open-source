<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfinclude template="queries/qry_QPenaltyDeciders.cfm">
<cfif QPenaltyDeciders.RecordCount IS 0>
	<span class="pix13bold"><BR><BR>searched for "pen" in the fixture notes and found none<BR><BR></span>
	<CFABORT>
</cfif>
<table width="100%" border="1" cellpadding="5" cellspacing="1">
	<cfoutput query="QPenaltyDeciders">
		<tr>
			<td><a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DivisionID#&HomeID=#HomeID#&AwayID=#AwayID#&LeagueCode=#LeagueCode#&Whence=PD"><span class="pix10">Update</span></a></td>
			<td width="300"><span class="pix10">#FixtureNotes#</span></td>
			<td><span class="pix10">#DateFormat(Fixturedate, 'DD MMM YY')#<BR>#CompetitionName#<BR>#HomeTeam# #HomeOrdinal# <strong>#HomeGoals#</strong> v <strong>#AwayGoals#</strong> #AwayTeam# #AwayOrdinal#</span></td>
			<td><cfif Result IS "U"><span class="pix10">Home Win on penalties</span><cfelseif Result IS "V"><span class="pix10">Away Win on penalties</span><cfelse><span class="pix13boldred">ERROR</span></cfif></span></td>
		</tr>
	</cfoutput>
</table>