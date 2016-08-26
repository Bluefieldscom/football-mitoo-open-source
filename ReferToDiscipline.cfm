<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfinclude template="queries/qry_QReferToDiscipline.cfm">
<cfif QReferToDiscipline.RecordCount IS 0>
	<span class="pix18">"discip" was not found anywhere in the fixture notes.<BR><BR></span>
	<cfabort>
</cfif>
<table width="100%" border="0" cellpadding="2" cellspacing="2">
	<tr>
		<td colspan="5"><span class="pix18">Found "discip" <cfoutput>#QReferToDiscipline.RecordCount#</cfoutput> times in the fixture notes.<BR><BR></span></td>
	</tr>
<cfoutput query="QReferToDiscipline">
	<tr>
		<td><a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DID#&HomeID=#HomeID#&AwayID=#AwayID#&LeagueCode=#LeagueCode#&Whence=RD"><span class="pix13">Update</span></a></td>
		<td width="600"><span class="pix13">#FixtureNotes# #PrivateNotes#</span></td>
		<td><span class="pix13">#HomeTeamName# #HomeTeamOrdinal# #HomeGoals# v #AwayGoals# #AwayTeamName# #AwayTeamOrdinal#</span>
	</tr>
</cfoutput>
</table>