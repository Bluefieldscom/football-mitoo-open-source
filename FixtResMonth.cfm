<cfif ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
<cfelse> <!--- Wilkinson pagegrabber to be removed 12th June 2013  - PAUSED 21st May - restarted 6th June 
	<div id="ut_piggyback"><script type="text/javascript" src="http://cdn.undertone.com/js/piggyback.js?zoneid=51269"></script></div>
	terminated 12 June --->
	<!--- Long term pagegrabber   --->
	<div id="ut_piggyback"><script type="text/javascript" src="http://cdn.undertone.com/js/piggyback.js?zoneid=53223"></script></div>	
</cfif>

<cfif ListFind("Silver,Skyblue,Yellow,White",request.SecurityLevel) >
<cfelse>
	<cfoutput>
		<cflocation url="http://www.mitoo.com/beta?league&leaguecode=#request.CurrentLeagueCodePrefix#&nonko=1" addtoken="no">
	</cfoutput>
	<cfabort>
</cfif>

<cfset variables.robotindex="no">
<cfif StructKeyExists(url, "MonthNo") AND IsNumeric(url.MonthNo) AND (url.MonthNo GT 0) AND (url.MonthNo LT 13) >
	<cfset MonthNo = url.MonthNo >
<cfelse>
	<cfset MonthNo = Month(Now()) >
</cfif> 
<!--- include toolbar.cfm--->
<cfinclude template="InclBegin.cfm">
<CFSILENT>

<cfinclude template="queries/qry_QFixtures_v6.cfm">
</CFSILENT>
<cfif QFixtures.RecordCount IS "0">
	<span class="pix13bold">No fixtures or results</span>
<cfelse>
	<cfinclude template="queries/qry_QTempFixturesCount.cfm">
	<cfif QTempFixtures.Counter IS "">
		<cfset TempFixtCount = 0 >
	<cfelse>
		<cfset TempFixtCount = QTempFixtures.Counter >
	</cfif>

	<cfif DefaultGoalScorers IS "Yes">
		<cfinclude template="InclGoalscorerInfo.cfm">
		<cfinclude template="InclStarPlayerInfo.cfm">
	</cfif>
	<table width="100%" border="0" cellpadding="0" cellspacing="2" class="white" >
		<!--- e.g. 47 in list --->
		<tr>
			<cfoutput>
			<td colspan="10" align="left" valign="middle"  > 
			<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
				<span class="pix13bold">#QFixtures.RecordCount# in list <cfif TempFixtCount GT 0 >[including #TempFixtCount# <img src="gif/TEMPflag.gif" width="41" height="13"  border="0" align="absmiddle">]</cfif></span>
			<cfelse>
				<span class="pix13bold">#Evaluate(QFixtures.RecordCount -TempFixtCount)# in list</span>
			</cfif>
			<cfif KickOffTimeOrder>
				<span class="pix13bold"> displayed in KO Time order within Division</span>
			</cfif>
			</td>
			</cfoutput>
		</tr>

		<cfoutput query="QFixtures" group="FixtureDate">
		<tr>
			<td class="mainHeading" colspan="10" align="left">
			<!--- e.g.  Saturday, 18 December 1999  --->
				<a href="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(FixtureDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#"><span class="pix13bold">#DateFormat( FixtureDate , 'DDDD, DD MMMM YYYY')#</span></a>
			</td>
		</tr>
		<cfset HideFixtures = "No">
		<cfset ThisDate = DateFormat(QFixtures.FixtureDate, 'YYYY-MM-DD')>
		<!--- Hide the fixtures from the public if the Event Text says so --->
		<cfinclude template="queries/qry_QEventText.cfm">
		<cfif QEventText.RecordCount IS 1>
			<cfif FindNoCase("Hide_Fixtures",QEventText.EventText)>
				<cfset HideFixtures = "Yes">
			</cfif>
		</cfif>
		<cfif HideFixtures IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel)>
			<tr>
				<td colspan="10"> <span class="pix13bold">Fixtures have been hidden</span></td>
			</tr>
		<cfelse>
			<cfif HideFixtures IS "Yes" AND ListFind("Silver,Skyblue",request.SecurityLevel)>
				<tr>
					<td colspan="10" bgcolor="##6A7289"> <span class="pix10boldwhite">Fixtures have been hidden from the public</span></td>
				</tr>
			</cfif>
			<cfoutput>
			
			
				<cfif Result IS "T" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
					<!--- if it is a TEMP fixture then suppress output for the public --->
				<cfelse>
					<cfset Highlight = "No">
					<cflock scope="session" timeout="10" type="readonly">
						<cfif session.fmTeamID IS HomeTeamID>
							<cfset Highlight = "Yes">
						</cfif>
						<cfif session.fmTeamID IS AwayTeamID>
							<cfset Highlight = "Yes">
						</cfif>
					</cflock>
						<tr class="bg_contrast" align="left">
							<!--- merge cells if Postponed or Abandoned or HideScore --->
							
							
					<!--- merge cells if Postponed or Abandoned or HideScore --->
					<cfif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND HomeGoals IS "" AND AwayGoals IS "" AND Result IS "" >
						<td width="70" colspan="2" align="center"><span class="pix10grey">&nbsp;</span></td>
					<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "H" OR (HomeGoals GT AwayGoals)) >
						<td width="70" colspan="2" align="center"><span class="pix10grey">Played</span></td>
					<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "A" OR (HomeGoals LT AwayGoals)) >
							<td width="70" colspan="2" align="center"><span class="pix10grey">Played</span></td>
					<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "D" OR (HomeGoals IS AwayGoals AND IsNumeric(HomeGoals) AND IsNumeric(AwayGoals) )) >
							<td width="70" colspan="2" align="center"><span class="pix10grey">Played</span></td>
					<cfelseif Result IS "P" >
						<td width="70" colspan="2" align="center"><span class="pix18boldgray">P</span></td>
					<cfelseif Result IS "Q" >
						<td width="70" colspan="2" align="center"><span class="pix18boldgray">A</span></td>
					<cfelseif Result IS "W" >
						<td width="70" colspan="2" align="center"><span class="pix18boldgray">V</span></td>
					<cfelseif Result IS "T" >
						<td width="70" colspan="2" align="center" bgcolor="aqua"><span class="pix18boldgray">TEMP</span></td>
					<cfelse>
					<!--- e.g. 3  1  British Airways III v Northolt Villa --->
					<!--- This is the HOME score..... --->
								<td width="35" align="CENTER" <cfif Highlight>class="bg_highlight"</cfif> >
								<span class="pix13bold">
								<cfif Result IS "H" >
									H
								<cfelseif Result IS "A" >
									-
								<cfelseif Result IS "D" >
									D 
								<cfelse>
									#HomeGoals#
								</cfif> 
								</span>
								</td>
					<!--- This is the AWAY score..... --->
								<td width="35" align="CENTER" <cfif Highlight>class="bg_highlight"</cfif>>
								<span class="pix13bold">
								<cfif Result IS "H" >
									-
								<cfelseif Result IS "A" >
									A
								<cfelseif Result IS "D" >
									D 
								<cfelse>
									#AwayGoals#
								</cfif> 
								</span>
								</td>
							</cfif>
				<!--- This is the pair of teams that play each other.... --->			
							<td <cfif Highlight>class="bg_highlight"</cfif>>
									<cfset MatchReportHeading = "#Getlong.CompetitionDescription#" >
									<cfset MatchReportDate = "#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#" >	
								<cfif Find( "MatchNumbers", QKnockOut.Notes )>		<!--- e.g. 004 in italics --->
									<cfif MatchNumber IS NOT "" AND MatchNumber IS NOT 0>
										<span class="pix10italic">#NumberFormat(MatchNumber,"000")#</span>
									</cfif>
								</cfif>
								<cfset HTeamName = Trim("#HomeTeam# #HomeOrdinal#")>
								<cfset ATeamName = Trim("#AwayTeam# #AwayOrdinal#")>
								<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
									<cfif UCase(HomeGuest) IS "GUEST">
										<a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DivisionID#&HomeID=#HomeID#&AwayID=#AwayID#&LeagueCode=#LeagueCode#&Whence=MD">
										<span class="pix13bolditalic"><u>#HTeamName#</u></span></a>
									<cfelse>
										<a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DivisionID#&HomeID=#HomeID#&AwayID=#AwayID#&LeagueCode=#LeagueCode#&Whence=MD">
										<span class="pix13bold"><u>#HTeamName#</u></span></a>
									</cfif>
									<span class="pix13">v</span>
									<cfif UCase(AwayGuest) IS "GUEST">
										<a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DivisionID#&HomeID=#HomeID#&AwayID=#AwayID#&LeagueCode=#LeagueCode#&Whence=MD">
										<span class="pix13bolditalic"><u>#ATeamName#</u></span></a>
									<cfelse>
										<a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DivisionID#&HomeID=#HomeID#&AwayID=#AwayID#&LeagueCode=#LeagueCode#&Whence=MD">
										<span class="pix13bold"><u>#ATeamName#</u></span></a>
									</cfif>
								<cfelse>
									<cfif UCase(HomeGuest) IS "GUEST">
										<span class="pix13bolditalic">#HTeamName#</span>
									<cfelse>
										<span class="pix13bold">#HTeamName#</span>
									</cfif>
									<span class="pix13">v</span>
									<cfif UCase(AwayGuest) IS "GUEST">
										<span class="pix13bolditalic">#ATeamName#</span>
									<cfelse>
										<span class="pix13bold">#ATeamName#</span>
									</cfif>
								</cfif>
								<cfif TRIM(#RoundName#)IS NOT "" >			<!--- e.g. [ Round 1 ] --->
									 <span class="pix13boldnavy">[ #RoundName# ]</span>
								</cfif>
								<cfif Result IS "H" AND HideScore IS "No" ><span class="pix13boldnavy">[ Home Win was awarded ]</span>
								<cfelseif Result IS "A" AND HideScore IS "No" ><span class="pix13boldnavy">[ Away Win was awarded ]</span>
								<cfelseif Result IS "U" AND HideScore IS "No" ><span class="pix13boldnavy">[ Home Win on penalties ]</span>
								<cfelseif Result IS "V" AND HideScore IS "No" ><span class="pix13boldnavy">[ Away Win on penalties ]</span>
								<cfelseif Result IS "D" AND HideScore IS "No" ><span class="pix13boldnavy">[ Draw was awarded ]</span>
								<cfelseif Result IS "P" ><span class="pix13boldnavy">[ Postponed ]</span>
								<cfelseif Result IS "Q" ><span class="pix13boldnavy">[ Abandoned ]</span>						
								<cfelseif Result IS "W" ><span class="pix13boldnavy">[ Void ]</span>
								<cfelseif Result IS "T" ><span class="pix10italic"> fixture hidden from the public </span>						
								<cfelse>
								</cfif> 
		
		
		
		
		<!---
							********************
							* Starting Line-Up *
							********************
		--->					
						
						<cfset TheHomeTeam = QFixtures.HomeTeam>
						<cfset TheHomeOrdinal = QFixtures.HomeOrdinal>
						<cfset TheAwayTeam = QFixtures.AwayTeam>
						<cfset TheAwayOrdinal = QFixtures.AwayOrdinal>
						
		<!---
							********************
							* Starting Line-Up *
							********************
		--->					
						<cfset tooltiptext = "">
						<cfinclude template="queries/qry_QTeamStartingLineUpHome.cfm">
						<cfinclude template="queries/qry_QTeamStartingLineUpAway.cfm">
						<cfif (QTeamStartingLineUpHome.RecordCount + QTeamStartingLineUpAway.RecordCount) GT 0>
								
							<!--- process the Home team --->
							<cfif QTeamStartingLineUpHome.RecordCount GT 0 >
								<cfset FirstActivity2 = "No">
								<cfset FirstActivity3 = "No">
								<cfset tooltiptext = "#tooltiptext#<div style='text-align:center;text-decoration:underline'>#TheHomeTeam# #TheHomeOrdinal#</div><br>">
								<cfloop query="QTeamStartingLineUpHome">
									<!--- query is sorted into Activity groups Activity=1 then Activity=2 then Activity=3 --->
									<cfif Activity IS 1>    <!--- Players who were in the starting eleven --->
										<cfset tooltiptext = "#tooltiptext#<div style='text-align:left;'>#NumberFormat(ActualShirtNumber, '00')# #Left(Forename,1)#. #Surname#</div>">
									<cfelseif Activity IS 2> <!--- substitutes who played --->
										<cfif FirstActivity2 IS "No">
											<cfset FirstActivity2 = "Yes">
											<cfset tooltiptext = "#tooltiptext#<hr>">  <!--- draw a line under the starting eleven --->
										</cfif>
										<cfset tooltiptext = "#tooltiptext#<div style='text-align:left;background-color:##F5F5DC;'>#NumberFormat(ActualShirtNumber, '00')# #Left(Forename,1)#. #Surname#</div>">
									<cfelseif Activity IS 3>   <!--- substitutes who did not play --->
										<cfif FirstActivity3 IS "No">
											<cfset FirstActivity3 = "Yes">
											<cfset tooltiptext = "#tooltiptext#<hr>" >  <!--- draw a line under the last substitute who played --->
										</cfif>
										<cfset tooltiptext = "#tooltiptext#<div style='text-align:left;background-color:##F8F8FF;'>#NumberFormat(ActualShirtNumber, '00')# #Left(Forename,1)#. #Surname#</div>">
									<cfelse>
										ERROR 37 in FixtResMonth.cfm
									</cfif>
								</cfloop>
								<cfset tooltiptext = "#tooltiptext#<br>">
							</cfif>
							<!--- process the Away team --->
							<cfif QTeamStartingLineUpAway.RecordCount GT 0 >
								<cfset FirstActivity2 = "No">
								<cfset FirstActivity3 = "No">
								<cfset tooltiptext = "#tooltiptext#<div style='text-align:center;text-decoration:underline'>#TheAwayTeam# #TheAwayOrdinal#</div><br>">
								<cfloop query="QTeamStartingLineUpAway">
									<!--- query is sorted into Activity groups Activity=1 then Activity=2 then Activity=3 --->
									<cfif Activity IS 1>    <!--- Players who were in the starting eleven --->
										<cfset tooltiptext = "#tooltiptext#<div style='text-align:left;'>#NumberFormat(ActualShirtNumber, '00')# #Left(Forename,1)#. #Surname#</div>">
									<cfelseif Activity IS 2> <!--- substitutes who played --->
										<cfif FirstActivity2 IS "No">
											<cfset FirstActivity2 = "Yes">
											<cfset tooltiptext = "#tooltiptext#<hr>">  <!--- draw a line under the starting eleven --->
										</cfif>
										<cfset tooltiptext = "#tooltiptext#<div style='text-align:left;background-color:##F5F5DC;'>#NumberFormat(ActualShirtNumber, '00')# #Left(Forename,1)#. #Surname#</div>">
									<cfelseif Activity IS 3>   <!--- substitutes who did not play --->
										<cfif FirstActivity3 IS "No">
											<cfset FirstActivity3 = "Yes">
											<cfset tooltiptext = "#tooltiptext#<hr>" >  <!--- draw a line under the last substitute who played --->
										</cfif>
										<cfset tooltiptext = "#tooltiptext#<div style='text-align:left;background-color:##F8F8FF;'>#NumberFormat(ActualShirtNumber, '00')# #Left(Forename,1)#. #Surname#</div>">
									<cfelse>
										ERROR 38 in FixtResMonth.cfm
									</cfif>
								</cfloop>
								<cfset tooltiptext = "#tooltiptext#<br>">
							</cfif>
							<cfset tooltiptext = Replace(tooltiptext, "'", "\'", "ALL")>
							<a onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='##FFFFF0';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=180;return escape('#ToolTipText#')"><img src="images/icon_lineup.png" border="0" align="absmiddle"></a>
						</cfif>
		
		
		
		
		
		
		
								<cfif VenueAndPitchAvailable IS "Yes" AND UCase(HomeGuest) IS NOT "GUEST">
									<cfinclude template="InclFixturePitchAvailability.cfm">
								</cfif>
							
								<cfif KOTime IS "" >
								<cfelse>
								  <span class="pix10brand"><br><strong>#TimeFormat(KOTime, 'h:mm TT')#</strong></span>
								</cfif> 
							
								<cfif #Attendance# IS "" >
								<cfelse>
									<span class="pix10navy"><br>Attendance #NumberFormat(Attendance, '99,999')#</span>
								</cfif>
								
								<cfif HomePointsAdjust IS NOT "" AND HomePointsAdjust IS NOT 0><span class="pix10"><br>#HomeTeam# #HomeOrdinal# #NumberFormat(HomePointsAdjust,"+9")# <cfif HomePointsAdjust IS 1 OR HomePointsAdjust IS -1>point<cfelse>points</cfif></span></cfif>
								<cfif AwayPointsAdjust IS NOT "" AND AwayPointsAdjust IS NOT 0><span class="pix10"><br>#AwayTeam# #AwayOrdinal# #NumberFormat(AwayPointsAdjust,"+9")# <cfif AwayPointsAdjust IS 1 OR AwayPointsAdjust IS -1>point<cfelse>points</cfif></span></cfif>							
								<span class="pix10">
									<cfif #FixtureNotes# IS "" >
									<cfelse>
										<br>#FixtureNotes#
									</cfif>
								</span>
								<cfif #MatchReportID# IS NOT "" >
									<br><a href="SeeMatchReport.cfm?MatchReportID=#MatchReportID#&LeagueCode=#LeagueCode#&TblName=Matches&LeagueName=#URLEncodedFormat(LeagueName)#&SeasonName=#SeasonName#"
									 target="#LeagueCode#MatchReport#MatchReportID#"><span class="pix10boldred">Match Report</span></a>
								</cfif>
							</td>
							<cfinclude template="InclOfficials.cfm">	<!---  <td></td> Referee and Assistants --->		
						</tr>
        				<cfif DefaultGoalScorers IS "Yes" AND ((HideScore IS "No") OR (HideScore IS "Yes" AND ListFind("Silver,Skyblue",request.SecurityLevel))) >
							<cfinclude template="InclGoalscorers.cfm"> 	<!---  <tr></tr> Goalscorers --->
						</cfif>
					</cfif>
			</cfoutput>
		</cfif>
			<tr> 
				<td height="4" colspan="4" bgcolor="white"></td>
			</tr>
		</cfoutput>
	</table>
</cfif>
<script language="JavaScript" type="text/javascript" src="wz_tooltip.js"></script>
