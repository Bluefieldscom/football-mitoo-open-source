<cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>

<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfsetting enablecfoutputonly="yes">
<CFCONTENT type="application/msexcel">
<cfheader name="Content-Disposition" value="filename=Fixtures.xls">
<cfset ThisColSpan = 14 >
<cfoutput>
<table border="1">
	<tr> <td height="30" colspan="#ThisColSpan#" align="center" valign="top"><strong>#SeasonName#</strong></td></tr>
	<tr> <td height="30" colspan="#ThisColSpan#" align="center" valign="top"><strong>#LeagueName#</strong></td></tr>
	<tr>
		<td>Date</td>
		<td>Competition</td>
		<td>Match Number</td>
		<td>Home Team</td>
		<td align="center">v</td>
		<td>Away Team</td>
		<td>Round</td>
		<td>KO Time</td>
		<td>Venue</td>
		<td>Pitch</td>
		<td>Referee</td>
		<td>Assistant 1</td>
		<td>Assistant 2</td>
		<td>4th Official</td>
	</tr>
</table>
</cfoutput>
<cfinclude template="queries/qry_QFixtures_v8.cfm">

<cfif ListFind("Yellow",request.SecurityLevel) >
	<cfinclude template="queries/qry_QHide_Fixtures.cfm">
	<cfset HideDatesList = QuotedValueList(QHide_Fixtures.EventDate)>
</cfif>

<cfoutput>
<table border="1">
</cfoutput>
	<cfoutput query="QFixtures" group="FixtureDate">
		<!--- Check Hide_Fixtures for Yellow security Level --->
		<cfif ListFind("Yellow",request.SecurityLevel) AND Find('#DateFormat(QFixtures.FixtureDate,"YYYY-MM-DD")#','#HideDatesList#')>
			<tr>
				<td height="25" colspan="#ThisColSpan#" bgcolor="lightyellow"><strong>Fixtures Hidden for #DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#</strong></td>
			</tr>
		<cfelse>
			<tr>
				<td height="25" colspan="#ThisColSpan#" bgcolor="lightyellow"><strong>#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#</strong></td>
			</tr>
				<cfoutput group="DivName">
				<tr>
					<td height="25" colspan="1"  bgcolor="white"><strong>&nbsp;</strong></td>
					<cfif External IS "Yes">
						<td height="25" colspan="#ThisColSpan-1#" bgcolor="silver"><strong>#DivName#</strong></td>
					<cfelse>
						<td height="25" colspan="#ThisColSpan-1#" bgcolor="lightblue"><strong>#DivName#</strong></td>
					</cfif>
				</tr>
				<cfoutput>
 				
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td><cfif MatchNumber IS 0>&nbsp;<cfelse>#MatchNumber#</cfif></td>
						<td><strong>#HomeTeam# #HomeOrdinal#</strong></td>
						<td align="center"> 
							<cfif Result IS "P">P<cfelseif Result IS "W" >V<cfelseif Result IS "Q" >A<cfelseif Result IS "H" >H<cfelseif Result IS "A" >-<cfelseif Result IS "D" >D<cfelse>#HomeGoals#</cfif>
							v
							<cfif Result IS "P">P<cfelseif Result IS "W" >V<cfelseif Result IS "Q" >A<cfelseif Result IS "H" >-<cfelseif Result IS "A" >A<cfelseif Result IS "D" >D<cfelse>#AwayGoals#</cfif>	
						</td>
						<td><strong>#AwayTeam# #AwayOrdinal#</strong></td>
						<td>#RoundName#</td>
						<td>#TimeFormat(QFixtures.KOTime, 'h:mm TT')#</td>
						<td>#VenueName#</td>
						<td>#PitchNumber#</td>
						<td><cfif LTRIM(RTRIM(RefsName)) IS "">&nbsp;<cfelse><strong><em>#RefsName#</em></strong></cfif></td>
						<td><cfif LTRIM(RTRIM(AR1Name)) IS "">&nbsp;<cfelse><strong><em>#AR1Name#</em></strong></cfif></td>
						<td><cfif LTRIM(RTRIM(AR2Name)) IS "">&nbsp;<cfelse><strong><em>#AR2Name#</em></strong></cfif></td>
						<td><cfif LTRIM(RTRIM(FourthOfficialName)) IS "">&nbsp;<cfelse><strong><em>#FourthOfficialName#</em></strong></cfif></td>
					</tr>
					<cfif LTRIM(RTRIM(FixtureNotes)) IS "">
					<cfelse>
						<tr>
							<td colspan="3">&nbsp;</td>
							<td colspan="#ThisColspan-3#">#FixtureNotes#</td>
						</tr>
					</cfif>
				</cfoutput>
			</cfoutput>
			</cfif>
		</cfoutput>
</table>
