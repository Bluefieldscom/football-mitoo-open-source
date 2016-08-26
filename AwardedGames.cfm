<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfinclude template="queries/qry_QAwardedGames.cfm">
<cfif QAwardedGames.RecordCount IS 0>
	<span class="pix18">No awarded games found<BR><BR></span>
	<cfabort>
</cfif>
<cfset ThisColSpan = 4>
<table width="80%" border="0" cellpadding="3" cellspacing="3">
<cfoutput query="QAwardedGames" group="FixtureDate">
	<tr>
		<td colspan="#ThisColSpan#"><span class="pix13bold">#DateFormat(FixtureDate,'DDDD, DD MMMM YYYY')#</span></td>
	</tr>
	<cfset ThisCount = 0>
	<cfoutput>
		<tr class="bg_highlight0" onmouseover="this.className='bg_highlight2';" onmouseout="this.className='bg_highlight0';" >
		<td><a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DID#&HomeID=#HomeID#&AwayID=#AwayID#&LeagueCode=#LeagueCode#"><span class="pix10"><u>upd/del</u></span></a></td>
		<td><span class="pix10bold">#DivName#</span></td>
		<td><span class="pix10bold">#Result#</span></td>
		<cfif Result IS "H"><td><span class="pix10"><u>#HomeTeamName#</u> v #AwayTeamName#</span></td>
		<cfelseif Result IS "A"><td><span class="pix10">#HomeTeamName# v <u>#AwayTeamName#</u></span></td>
		<cfelse><td><span class="pix10">#HomeTeamName# v #AwayTeamName#</span></td>
		</cfif>
		<cfset ThisCount = ThisCount + 1>
	</tr>
	</cfoutput>
	<tr>
		<td colspan="#ThisColSpan#" align="right"><span class="pix13bold">#ThisCount#<hr></span></td>
	</tr>
</cfoutput>
</table>