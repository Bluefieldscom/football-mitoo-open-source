<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfsilent>
<cfinclude template = "queries/qry_QTeamList.cfm">
<cfinclude template = "queries/qry_QResults.cfm">
<cfset CIDList=ValueList(QTeamList.CID)>
<cfset TeamIDList=ValueList(QTeamList.TeamID)>
<cfset SaveColSpan = QTeamList.RecordCount + 1>
</cfsilent>

<cfsetting enablecfoutputonly="yes">
<CFCONTENT type="application/msexcel">
<cfheader name="Content-Disposition" value="filename=ResultsGrid.xls">
<cfset ThisColSpan = SaveColSpan >
<cfoutput>
<table border="1">

<tr> <td colspan="#ThisColSpan#" align="center">#SeasonName#</td></tr>
<tr> <td colspan="#ThisColSpan#" align="center">#LeagueName#</td></tr>

<tr> <td colspan="#ThisColSpan#" align="center" valign="top">#ThisCompetitionDescription#</td></tr>
<tr bgcolor="White">
	<td height="20" colspan="#ThisColSpan#" align="LEFT"  >&nbsp;</td>
</tr>
</cfoutput>
<tr>
	<cfoutput><td align="center">&nbsp;</td></cfoutput>
	<cfoutput query="QTeamList">
	<td align="center" valign="top"><cfif TeamNameMedium IS "">#TeamName#<cfelse>#TeamNameMedium#</cfif> <cfif OrdinalNameShort IS "">#OrdinalName#<cfelse>#OrdinalNameShort#</cfif></td>
	</cfoutput>
</tr>
<cfoutput query="QTeamList">
	<tr>
	<td valign="middle">&nbsp;<br />#TeamName# #OrdinalName#<br />&nbsp;</td>
	<cfloop index="ColN" from="1" to="#QTeamList.RecordCount#" step="1" >
		
			<cfif QTeamList.CID IS ListGetAt(CIDList, ColN)>
				<cfinclude template = "queries/qry_QGridHomeGames.cfm">
				<cfinclude template = "queries/qry_QGridAwayGames.cfm">
				<cfset HGCount = IIF(IsNumeric(QGridHomeGames.HomeGames),QGridHomeGames.HomeGames,0)>
				<cfset AGCount = IIF(IsNumeric(QGridAwayGames.AwayGames),QGridAwayGames.AwayGames,0)>
				
				<cfif HGCount IS 0 AND AGCount IS 0>
					<td align="CENTER"  valign="middle" bgcolor="silver">&nbsp;</td>
				<cfelse>
					<cfif ABS(HGCount - AGCount) GT 2>
						<td align="CENTER"  valign="middle" bgcolor="silver"><strong>&nbsp;<br />H#HGCount# A#AGCount#</strong><br />&nbsp;</td>
					<cfelse>
						<td align="CENTER"  valign="middle" bgcolor="silver">&nbsp;<br />H#HGCount# A#AGCount#<br />&nbsp;</td>
					</cfif>
				</cfif>
			<cfelse>
				<cfinclude template = "queries/qry_QGetResult.cfm">
					<td align="center">
						<table>
							<cfloop query="QGetResult">
							
							
								<cfset HideFixtures = "No">
								<cfset ThisDate = DateFormat(FixtureDate, 'YYYY-MM-DD')>
								<!--- Hide the fixtures from the public if the Event Text says so --->
								<cfinclude template="queries/qry_QEventText.cfm">
								<cfif QEventText.RecordCount IS 1>
									<cfif FindNoCase("Hide_Fixtures",QEventText.EventText)>
										<cfset HideFixtures = "Yes">
									</cfif>
								</cfif>
								<cfif HideFixtures IS "Yes">
									<cfif ListFind("Silver,Skyblue",request.SecurityLevel)>
										<tr>
											<td bgcolor="silver" align="center">hidden</td>
										</tr>
										<cfset DateString = '#DateFormat(FixtureDate,"D MMM")#'>
									<cfelse>
										<cfset DateString = ''>
									</cfif>
								<cfelse>	
									<cfset DateString = '#DateFormat(FixtureDate,"D MMM")#'>							
								</cfif>
								<cfif Result IS "H" ><cfset ScoreString = "Home Win">
								<cfelseif Result IS "A" ><cfset ScoreString = "Away Win">
								<cfelseif Result IS "U" ><cfset ScoreString = "Home Win on pens">
								<cfelseif Result IS "V" ><cfset ScoreString = "Away Win on pens">
								<cfelseif Result IS "D" ><cfset ScoreString = "Draw">
								<cfelseif Result IS "P" ><cfset ScoreString = "Postponed">
								<cfelseif Result IS "Q" ><cfset ScoreString = "Abandoned">
								<cfelseif Result IS "W" ><cfset ScoreString = "Void">
								<cfelseif HomeGoals IS ""><cfset ScoreString = "">
								<cfelseif NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND Find( "HideDivision", QKnockOut.Notes ) >
									<cfif HomeGoals GT AwayGoals><cfset ScoreString = "Played ">
									<cfelseif HomeGoals LT AwayGoals><cfset ScoreString = "Played ">
									<cfelseif HomeGoals IS AwayGoals><cfset ScoreString = "Played ">
									</cfif>
								<cfelse><cfset ScoreString = "&nbsp;#HomeGoals#-#AwayGoals#&nbsp;">
								</cfif>
									<tr>
										<td align="center">#DateString#</td>
									</tr>
									<tr>
										<td align="center"><strong>#ScoreString#</strong></td>
									</tr>
							</cfloop>
						</table>
						<table>
							<cfloop query="QGetResult">
								<cfif HomePointsAdjust IS NOT "" AND HomePointsAdjust IS NOT 0 >
									<tr>
										<td align="center">#NumberFormat(HomePointsAdjust,"+9")# pts H</td>
									</tr>
								</cfif>
								<cfif AwayPointsAdjust IS NOT "" AND AwayPointsAdjust IS NOT 0 >
									<tr>
										<td align="center">#NumberFormat(AwayPointsAdjust,"+9")# pts A</td>
									</tr>
								</cfif>
							</cfloop>
						</table>
					</td>
			</cfif>
	</cfloop>
</tr>
</cfoutput>
</table>


<!--- Attendances --->
<cfoutput>
<table border="1">
<tr> <td height="50" colspan="#ThisColSpan#"  align="center"> </td></tr>

<tr> <td colspan="#ThisColSpan#" align="center">#SeasonName#</td></tr>
<tr> <td colspan="#ThisColSpan#" align="center">#LeagueName#</td></tr>

<tr> <td colspan="#ThisColSpan#" align="center" valign="top">#ThisCompetitionDescription#</td></tr>
<tr> <td colspan="#ThisColSpan#" align="center" valign="top"><strong>Attendances</strong></td></tr>

<tr bgcolor="White">
	<td height="20" colspan="#ThisColSpan#" align="LEFT"  >&nbsp;</td>
</tr>
</cfoutput>
<tr>
	<cfoutput><td align="center">&nbsp;</td></cfoutput>
	<cfoutput query="QTeamList">
	<td align="center" valign="top"><cfif TeamNameMedium IS "">#TeamName#<cfelse>#TeamNameMedium#</cfif> <cfif OrdinalNameShort IS "">#OrdinalName#<cfelse>#OrdinalNameShort#</cfif></td>
	</cfoutput>
</tr>
<cfoutput query="QTeamList">
	<tr>
	<td valign="middle">&nbsp;<br />#TeamName# #OrdinalName#<br />&nbsp;</td>
	<cfloop index="ColN" from="1" to="#QTeamList.RecordCount#" step="1" >
		
			<cfif QTeamList.CID IS ListGetAt(CIDList, ColN)>
				<cfinclude template = "queries/qry_QGridHomeGames.cfm">
				<cfinclude template = "queries/qry_QGridAwayGames.cfm">
				<cfset HGCount = IIF(IsNumeric(QGridHomeGames.HomeGames),QGridHomeGames.HomeGames,0)>
				<cfset AGCount = IIF(IsNumeric(QGridAwayGames.AwayGames),QGridAwayGames.AwayGames,0)>
				
				<cfif HGCount IS 0 AND AGCount IS 0>
					<td align="CENTER"  valign="middle" bgcolor="silver">&nbsp;</td>
				<cfelse>
					<cfif ABS(HGCount - AGCount) GT 2>
						<td align="CENTER"  valign="middle" bgcolor="silver"><strong>&nbsp;<br />H#HGCount# A#AGCount#</strong><br />&nbsp;</td>
					<cfelse>
						<td align="CENTER"  valign="middle" bgcolor="silver">&nbsp;<br />H#HGCount# A#AGCount#<br />&nbsp;</td>
					</cfif>
				</cfif>
			<cfelse>
				<cfinclude template = "queries/qry_QGetResult.cfm">
					<td align="center">
						<table>
							<cfloop query="QGetResult">
							
							
								<cfset HideFixtures = "No">
								<cfset ThisDate = DateFormat(FixtureDate, 'YYYY-MM-DD')>
								<!--- Hide the fixtures from the public if the Event Text says so --->
								<cfinclude template="queries/qry_QEventText.cfm">
								<cfif QEventText.RecordCount IS 1>
									<cfif FindNoCase("Hide_Fixtures",QEventText.EventText)>
										<cfset HideFixtures = "Yes">
									</cfif>
								</cfif>
								<cfif HideFixtures IS "Yes">
									<cfif ListFind("Silver,Skyblue",request.SecurityLevel)>
										<tr>
											<td bgcolor="silver" align="center">hidden</td>
										</tr>
										<cfset DateString = '#DateFormat(FixtureDate,"D MMM")#'>
									<cfelse>
										<cfset DateString = ''>
									</cfif>
								<cfelse>	
									<cfset DateString = '#DateFormat(FixtureDate,"D MMM")#'>							
								</cfif>
								<cfif Result IS "H" ><cfset ScoreString = "Home Win">
								<cfelseif Result IS "A" ><cfset ScoreString = "Away Win">
								<cfelseif Result IS "U" ><cfset ScoreString = "Home Win on pens">
								<cfelseif Result IS "V" ><cfset ScoreString = "Away Win on pens">
								<cfelseif Result IS "D" ><cfset ScoreString = "Draw">
								<cfelseif Result IS "P" ><cfset ScoreString = "Postponed">
								<cfelseif Result IS "Q" ><cfset ScoreString = "Abandoned">
								<cfelseif Result IS "W" ><cfset ScoreString = "Void">
								<cfelseif HomeGoals IS ""><cfset ScoreString = "">
								<cfelseif NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND Find( "HideDivision", QKnockOut.Notes ) >
									<cfif HomeGoals GT AwayGoals><cfset ScoreString = "Played ">
									<cfelseif HomeGoals LT AwayGoals><cfset ScoreString = "Played ">
									<cfelseif HomeGoals IS AwayGoals><cfset ScoreString = "Played ">
									</cfif>
								<cfelse><cfset ScoreString = "&nbsp;#HomeGoals#-#AwayGoals#&nbsp;">
								</cfif>
									<tr>
										<td align="center">#DateString#</td>
									</tr>
									<tr>
										<td align="center"><strong>#Attendance#</strong></td>
									</tr>
							</cfloop>
						</table>
						<table>
							<cfloop query="QGetResult">
								<cfif HomePointsAdjust IS NOT "" AND HomePointsAdjust IS NOT 0 >
									<tr>
										<td align="center">#NumberFormat(HomePointsAdjust,"+9")# pts H</td>
									</tr>
								</cfif>
								<cfif AwayPointsAdjust IS NOT "" AND AwayPointsAdjust IS NOT 0 >
									<tr>
										<td align="center">#NumberFormat(AwayPointsAdjust,"+9")# pts A</td>
									</tr>
								</cfif>
							</cfloop>
						</table>
					</td>
			</cfif>
	</cfloop>
</tr>
</cfoutput>
</table>






