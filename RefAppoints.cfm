<cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>

<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfinclude template="queries/qry_QFixtures_v8.cfm">

<cfif ListFind("Yellow",request.SecurityLevel) >
	<cfinclude template="queries/qry_QHide_Fixtures.cfm">
	<cfset HideDatesList = QuotedValueList(QHide_Fixtures.EventDate)>
</cfif>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="left"><span class="pix10bold">&nbsp;</span></td>
		<td align="left"><span class="pix10bold">Referee</span></td>
		<td align="left"><span class="pix10bold">Assistant 1</span></td>
		<td align="left"><span class="pix10bold">Assistant 2</span></td>
		<td align="left"><span class="pix10bold">4th Official</span></td>
	</tr>

	<cfoutput query="QFixtures" group="FixtureDate">
		<!--- Check Hide_Fixtures for Yellow security Level --->
		<cfif ListFind("Yellow",request.SecurityLevel) AND Find('#DateFormat(QFixtures.FixtureDate,"YYYY-MM-DD")#','#HideDatesList#')>
			<tr>
				<td align="left" height="20" colspan="5" bgcolor="lightyellow"><span class="pix10bold">Fixtures Hidden for #DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#</span></td>
			</tr>
		<cfelse>
	
		<tr>
			<td align="left" valign="bottom"><span class="pix13bold"><br>#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#</span></td>
		</tr>
		<cfoutput group="DivName">
		<tr>
			<td align="left"><span class="pix10bold"><BR>#DivName#</span></td>
		</tr>
			<cfoutput>
				<tr>
					<td align="left" width="450"><span class="pix10">
					<cfif MatchNumber IS 0><cfelse>#MatchNumber#</cfif>&nbsp;#HomeTeam# #HomeOrdinal#
					<cfif Result IS "P">P<cfelseif Result IS "W" >V<cfelseif Result IS "Q" >A<cfelseif Result IS "H" >H<cfelseif Result IS "A" >-<cfelseif Result IS "D" >D<cfelse>#HomeGoals#</cfif>
					v
					<cfif Result IS "P">P<cfelseif Result IS "W" >V<cfelseif Result IS "Q" >A<cfelseif Result IS "H" >-<cfelseif Result IS "A" >A<cfelseif Result IS "D" >D<cfelse>#AwayGoals#</cfif>	
					#AwayTeam# #AwayOrdinal#	<em>#RoundName#</em></span></td> 
					<cfif LTRIM(RTRIM(RefsName)) IS "">
						<td align="left"><span class="pix10">&nbsp;</span></td>
					<cfelse>
						<td align="left"><span class="pix10">#RefsName#</span></td>
					</cfif>
					<cfif LTRIM(RTRIM(AR1Name)) IS "">
						<td align="left"><span class="pix10">&nbsp;</span></td>
					<cfelse>
						<td align="left"><span class="pix10">#AR1Name#</span></td>
					</cfif>
					<cfif LTRIM(RTRIM(AR2Name)) IS "">
						<td align="left"><span class="pix10">&nbsp;</span></td>
					<cfelse>
						<td align="left"><span class="pix10">#AR2Name#</span></td>
					</cfif>
					<cfif LTRIM(RTRIM(FourthOfficialName)) IS "">
						<td align="left"><span class="pix10">&nbsp;</span></td>
					<cfelse>
						<td align="left"><span class="pix10">#FourthOfficialName#</span></td>
					</cfif>
				</tr>
			</cfoutput>
		</cfoutput>
		</cfif>
	</cfoutput>
</table>
