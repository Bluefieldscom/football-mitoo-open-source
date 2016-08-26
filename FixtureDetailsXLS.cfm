<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>
<cfif NOT StructKeyExists( url , "D1" )>
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>
<cfif NOT StructKeyExists( url , "D2" )>
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>

<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">

<cfinclude template="queries/qry_QFixtures_v14.cfm">

<cfif QFixtures.RecordCount GT 500 >
	<span class="pix24boldred">Exceeded maximum 500 fixtures/results</span>
	<cfabort>
</cfif>
<cfsetting enablecfoutputonly="yes">
<CFCONTENT type="application/msexcel">
<cfheader name="Content-Disposition" value="filename=FixtureDetails.xls">
<cfif VenueAndPitchAvailable IS "Yes">
	<cfset ThisColSpan = 19 >
<cfelse>
	<cfset ThisColSpan = 17>
</cfif>

<cfoutput>
<table border="1">
	<tr> <td height="30" colspan="#ThisColSpan#" align="center" valign="top"><strong>#SeasonName#</strong></td></tr>
	<tr> <td height="30" colspan="#ThisColSpan#" align="center" valign="top"><strong>#LeagueName#</strong></td></tr>
	<tr>
		<td>Date</td>
		<td>Competition</td>
		<td bgcolor="lightyellow">Home Team Notes</td>
		<td bgcolor="lightyellow">Away Team Notes</td>
		<td>Private Notes</td>
		<td>Match<br>Number</td>
		<td>Home Team</td>
		<td align="center">v</td>
		<td>Away Team</td>
		<td>Round</td>
		<td>KO Time</td>
		<!--- only show the next 2 columns if set up for the league --->
		<cfif VenueAndPitchAvailable IS "Yes">
			<td>Venue</td>
			<td>Pitch</td>
		</cfif>
		<td bgcolor="yellow">Home<br>Sports<br>Marks</td>
		<td bgcolor="yellow">Away<br>Sports<br>Marks</td>
		<td>Referee</td>
		<td>Assistant 1</td>
		<td>Assistant 2</td>
		<td>4th Official</td>
	</tr>
</table>
</cfoutput>


<cfoutput>
<table border="1">
</cfoutput>
	<cfoutput query="QFixtures" group="FixtureDate">
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
						<td valign="top">&nbsp;</td>
						<td valign="top">&nbsp;</td>
						<td valign="top" bgcolor="lightyellow"><cfif LTRIM(RTRIM(HomeTeamNotes)) IS "">&nbsp;<cfelse>#Replace(HomeTeamNotes, chr(13), "<br>", "ALL")#</cfif></td>
						<td valign="top" bgcolor="lightyellow"><cfif LTRIM(RTRIM(AwayTeamNotes)) IS "">&nbsp;<cfelse>#Replace(AwayTeamNotes, chr(13), "<br>", "ALL")#</cfif></td>
						<td valign="top"><cfif LTRIM(RTRIM(PrivateNotes)) IS "">&nbsp;<cfelse><strong>#Replace(PrivateNotes, chr(13), "<br>", "ALL")#</strong></cfif></td>
						<td valign="top"><cfif MatchNumber IS 0>&nbsp;<cfelse>#MatchNumber#</cfif></td>
						<td valign="top"><strong>#HomeTeam# #HomeOrdinal#</strong></td>
						<td valign="top" align="center"> 
							<cfif Result IS "P">P<cfelseif Result IS "W" >V<cfelseif Result IS "Q" >A<cfelseif Result IS "H" >H<cfelseif Result IS "A" >-<cfelseif Result IS "D" >D<cfelse>#HomeGoals#</cfif>
							v
							<cfif Result IS "P">P<cfelseif Result IS "W" >V<cfelseif Result IS "Q" >A<cfelseif Result IS "H" >-<cfelseif Result IS "A" >A<cfelseif Result IS "D" >D<cfelse>#AwayGoals#</cfif>	
						</td>
						<td valign="top" ><strong>#AwayTeam# #AwayOrdinal#</strong></td>
						<td valign="top" >#RoundName#</td>
						<td valign="top" >#TimeFormat(QFixtures.KOTime, 'h:mm TT')#</td>
						<!--- only show the next 2 columns if set up for the league --->
						<cfif VenueAndPitchAvailable IS "Yes">
							<td valign="top" >#VenueName#</td>
						<td valign="top" >#PitchNumber#</td>
						</cfif>
						<td bgcolor="yellow" valign="top" ><strong>#HomeSportsmanshipMarks#</strong></td>
						<td bgcolor="yellow" valign="top" ><strong>#AwaySportsmanshipMarks#</strong></td>
						<td valign="top" ><cfif LTRIM(RTRIM(RefsName)) IS "">&nbsp;<cfelse><strong><em>#RefsName#</em></strong></cfif></td>
						<td valign="top" ><cfif LTRIM(RTRIM(AR1Name)) IS "">&nbsp;<cfelse><strong><em>#AR1Name#</em></strong></cfif></td>
						<td valign="top" ><cfif LTRIM(RTRIM(AR2Name)) IS "">&nbsp;<cfelse><strong><em>#AR2Name#</em></strong></cfif></td>
						<td valign="top" ><cfif LTRIM(RTRIM(FourthOfficialName)) IS "">&nbsp;<cfelse><strong><em>#FourthOfficialName#</em></strong></cfif></td>
					</tr>
					<cfif LTRIM(RTRIM(FixtureNotes)) IS "">
					<cfelse>
						<tr>
							<td  valign="top" colspan="3">&nbsp;</td>
							<td  valign="top" colspan="#ThisColspan-3#">#FixtureNotes#</td>
						</tr>
					</cfif>
				</cfoutput>
			</cfoutput>

		</cfoutput>
</table>
