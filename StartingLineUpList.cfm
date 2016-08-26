<!--- Need to be logged in to see this report --->
<cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfif ListFind("Yellow",request.SecurityLevel)>
	<cfif request.YellowKey IS NOT "#request.CurrentLeagueCode##request.DropDownTeamID#" >
		<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
		<cfabort>
	</cfif>
</cfif>
<cfset BlueColor1 = "D8FEF5">
<cfset BlueColor2 = "B8FEF5">
<cfinclude template="queries/qry_QFixtureDate.cfm">

<cfif ListFind("Yellow",request.SecurityLevel) >
	<cfinclude template = "queries/qry_QValidFID.cfm">
	<!--- Is the FID valid for the current team ? Has it been tampered with in the URL ? --->
	<!--- <cfdump var="#QValidFID#"><cfdump var="#request#"> --->
	<cfif QValidFID.RecordCount IS 1>
		<cfif StructKeyExists(url, "HA")>
			<cfif QValidFID.HomeID IS request.DropDownTeamID AND url.HA IS "H" >
				<cfset HA = "H">
			<cfelseif QValidFID.AwayID IS request.DropDownTeamID AND url.HA IS "A" >
				<cfset HA = "A">
			<cfelse>
				<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
				<cfabort>
			</cfif>
		<cfelse>
			<cfif QValidFID.HomeID IS request.DropDownTeamID >
				<cfset HA = "H">
			<cfelseif QValidFID.AwayID IS request.DropDownTeamID >
				<cfset HA = "A">
			<cfelse>
				<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
				<cfabort>
			</cfif>
		</cfif>
	<cfelse>
		<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
		<cfabort>
	</cfif>
</cfif>


<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<!--- include toolbar.cfm--->
<cfinclude template="InclBegin.cfm">

<cfinclude template = "queries/qry_QTeamName.cfm">
<cfset StartingPlayerCount = 11>    <!--- default value, overridden by 'TeamSize' in Division Notes --->
<cfset SubsUsedPlayerCount = 3>   <!--- default value, overridden by 'TeamSize' in Division Notes --->
<cfset SubsNotUsedPlayerCount = 4>   <!--- default value, overridden by 'TeamSize' in Division Notes --->
<cfset TeamSizeTokenStart = Find( "TeamSize", QTeamName.DivisionNotes)>
<cfif TeamSizeTokenStart GT 0>
	<cfset StartingPlayerCount = MID(QTeamName.DivisionNotes, TeamSizeTokenStart+8, 2)>
	<cfset SubsUsedPlayerCount = MID(QTeamName.DivisionNotes, TeamSizeTokenStart+11, 2)>
	<cfif MID(QTeamName.DivisionNotes, TeamSizeTokenStart+13, 1) IS "+">
		<cfset SubsNotUsedPlayerCount = MID(QTeamName.DivisionNotes, TeamSizeTokenStart+14, 2)>
	</cfif>
	<cfif IsNumeric(StartingPlayerCount) AND IsNumeric(SubsUsedPlayerCount) AND IsNumeric(SubsNotUsedPlayerCount)>
	<cfelse>
		<cfoutput>
			<span class="pix13">Starting Player Count #StartingPlayerCount#<br>Subs Used Player Count #SubsUsedPlayerCount#<br>Subs Not Used Player Count #SubsNotUsedPlayerCount#<br></span>
			<span class="pix24boldred">ERROR: Look at <em>#MID(QTeamName.DivisionNotes, TeamSizeTokenStart, 16)#</em> in <cfoutput>#QTeamName.divisionName# Notes.</cfoutput></span>
		</cfoutput>
		<cfabort>
	</cfif>
</cfif>
<!--- OK button has been pressed - so update accordingly before re-presenting the latest state of affairs --->
<cfif StructKeyExists(form, "OK_Button")>
	<cfif Form.OK_Button IS "OK" OR Form.OK_Button IS "=OK=">
		<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
			<cfinclude template = "UpdateStartingLineUpList.cfm">
			<!--- OK button has been pressed by JAB or full password holder  --->
			<cfif     HA IS "H">
				<cfif Form.OK_Button IS "OK"> <!--- allow further updating of the home team sheet by a club --->
					<cfinclude template = "queries/upd_HomeTeamSheetOK1.cfm">
				</cfif>
				<cfif Form.OK_Button IS "=OK="> <!--- prevent further updating of the home team sheet by a club --->
					<cfinclude template = "queries/upd_HomeTeamSheetOK2.cfm">
				</cfif>
			<cfelseif HA IS "A">
				<cfif Form.OK_Button IS "OK"> <!--- allow further updating of the away team sheet by a club --->
					<cfinclude template = "queries/upd_AwayTeamSheetOK1.cfm">
				</cfif>
				<cfif Form.OK_Button IS "=OK="> <!--- prevent further updating of the away team sheet by a club --->
					<cfinclude template = "queries/upd_AwayTeamSheetOK2.cfm">
				</cfif>
			<cfelse>
				ERROR 27 in StartingLineUpList.cfm
				<cfabort>
			</cfif>
		<cfelseif ListFind("Yellow",request.SecurityLevel)>
			<cfif HA IS "H">
				<cfif QValidFID.HomeTeamSheetOK >
					<!--- HomeTeamSheetOK flag has just been set by another Silver or Skyblue user so don't do any updating --->
				<cfelse>
					<cfinclude template = "UpdateStartingLineUpList.cfm">
				</cfif>
			<cfelseif  HA IS "A">
				<cfif QValidFID.AwayTeamSheetOK >
					<!--- AwayTeamSheetOK flag has just been set by another Silver or Skyblue user so don't do any updating --->
				<cfelse>
					<cfinclude template = "UpdateStartingLineUpList.cfm">
				</cfif>
			<cfelse>
				ERROR 61 in StartingLineUpList.cfm
				<cfabort>
			</cfif>
		</cfif>
	</cfif>
</cfif>


<!--- This query is used to populate the top half of the screen --->
<cfinclude template = "queries/qry_QPlayersWhoStarted.cfm">

<cfset PlayerIDList=ValueList(QPlayersWhoStarted.PlayerID)>

<!--- This query is used to populate the bottom half of the screen --->
<cfinclude template = "queries/qry_PlayersWhoDidNotStart.cfm">

<!---<cfdump var="#QPlayersWhoDidNotPlay#"><cfabort> --->
<cfinclude template = "queries/qry_QSuspendedPlayers_v1.cfm">
<cfset SuspendedPlayerIDList=ValueList(QSuspendedPlayers.PlayerID)>
<cfform name="StartingLineUpForm" action="StartingLineUpList.cfm" >
	<cfoutput>
		<input type="Hidden" name="TblName" value="TeamList">
		<input type="Hidden" name="LeagueCode" value="#LeagueCode#">
		<input type="Hidden" name="DivisionID" value="#DivisionID#">
		<input type="Hidden" name="FID" value="#FID#">		
		<input type="Hidden" name="HA" value="#HA#">
	</cfoutput>
	<cfset PlayerCount = QPlayersWhoStarted.RecordCount>
	<input type="Hidden" name="PlayersWhoStartedCount" value="<cfoutput>#PlayerCount#</cfoutput>">
	<cfset NoOfCols = 2>
	<cfif PlayerCount Mod NoOfCols IS 0 >
		<cfset NoOfPlayersPerCol = PlayerCount / NoOfCols>
	<cfelse>
		<cfset NoOfPlayersPerCol = Round((PlayerCount / NoOfCols)+ 0.5) >
	</cfif>
	<cfset PlayerSurnameList=ValueList(QPlayersWhoStarted.PlayerSurname)>
	<cfset PlayerForenameList=ValueList(QPlayersWhoStarted.PlayerForename)>
	<cfset CardList=ValueList(QPlayersWhoStarted.Card)>
	<cfset NominalShirtNumberList=ValueList(QPlayersWhoStarted.NominalShirtNumber)>
	<cfset AppearanceTypeList=ValueList(QPlayersWhoStarted.AppearanceType)>
	<cfset ActualShirtNumberList=ValueList(QPlayersWhoStarted.ActualShirtNumber)>
	<cfset AppearanceIDList=ValueList(QPlayersWhoStarted.AppearanceID)>
	<cfset GoalsScoredList=ValueList(QPlayersWhoStarted.GoalsScored)>
	<cfoutput query="QTeamName">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" align="CENTER" class="loggedinScreen">
	
	
		<tr>
			<td colspan="#NoOfCols#" align="CENTER" >
				<table width="100%" border="1" align="center" cellpadding="4" cellspacing="0" class="LoggedInScreen">
					<tr>
						<td align="center">
							<span class="pix13bold"><a href="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(FixtureDate)#&DivisionID=#QFixtureDate.CurrentDivisionID#&LeagueCode=#LeagueCode#">#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#</a><br /></span>
							<span class="pix13bold">#DivisionName# <cfif TRIM(KORoundName) IS ""><cfelse> - #KORoundName#</cfif></span>
							<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >					
								<br />
								<cfif HA IS "H">
									<a href="TeamReportsMenu.cfm?LeagueCode=#LeagueCode#&TID=#QTeamName.HomeTeamID#"><img src="gif/TeamReportsMenu.gif" alt="Team Reports Menu" border="1" align="top"></a>
								<cfelse>
									<a href="TeamReportsMenu.cfm?LeagueCode=#LeagueCode#&TID=#QTeamName.AwayTeamID#"><img src="gif/TeamReportsMenu.gif" alt="Team Reports Menu" border="1" align="top"></a>
								</cfif>
								<a href="UpdateForm.cfm?TblName=Matches&id=#FID#&HomeID=#QTeamName.HomeID#&AwayID=#QTeamName.AwayID#&DivisionID=#QFixtureDate.CurrentDivisionID#&LeagueCode=#LeagueCode#&Whence=MD"><img src="gif/UpdateForm.gif" alt="Update Form" border="1" align="top"></a>
							<cfelseif ListFind("Yellow",request.SecurityLevel) >					
								<br />
								<a href="TeamReportsMenu.cfm?LeagueCode=#LeagueCode#"><img src="gif/TeamReportsMenu.gif" alt="Team Reports Menu" border="1" align="top"></a>
							</cfif>
						</td>
						
						<cfset HomeTeamName = "#TeamName1# #OrdinalName1#">
						<cfset AwayTeamName = "#TeamName2# #OrdinalName2#">
						<cfset HomeClubName = "#TeamName1#">
						<cfset AwayClubName = "#TeamName2#">
						<cfif HA IS "H">
							<cfset ThisTeamID = HomeTeamID >
							<cfset ThisCID = HomeID >
							<cfset ThisClubName = HomeTeamName >
							<td align="left" bgcolor="aqua">
								<span class="pix18bold">#HomeTeamName#</span>
								<cfif ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
									<span class="pix10"><a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=H&DivisionID=#DivisionID#"><img src="gif/TeamSheet.gif" alt="Team Sheet" width="35" height="23" border="1" align="top"></a>
									<!--- <cfif TeamSizeTokenStart GT 0> --->
										&nbsp;<a href="StartingLineUpList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=H&DivisionID=#DivisionID#"><img src="gif/StartingLineUp.gif" alt="Starting Line-Up" width="47" height="23" border="1" align="top"></a>
									<!--- </cfif> --->										
									</span>
								</cfif>
							</td>
							<td align="center" bgcolor="aqua"><span class="pix18bold">#HomeGoals#</span></td>
							<td align="left">
								<span class="pix18boldsilver">#AwayTeamName#</span>
								<cfif ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
									<span class="pix10"><a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=A&DivisionID=#DivisionID#"><img src="gif/TeamSheet.gif" alt="Team Sheet" width="35" height="23" border="1" align="top"></a>
									<!--- <cfif TeamSizeTokenStart GT 0> --->
										&nbsp;<a href="StartingLineUpList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=A&DivisionID=#DivisionID#"><img src="gif/StartingLineUp.gif" alt="Starting Line-Up" width="47" height="23" border="1" align="top"></a>
									<!--- </cfif> --->										
									</span>
								</cfif>
							</td>
							<td align="center"><span class="pix18boldsilver">#AwayGoals#</span></td>
						<cfelseif HA IS "A">
							<cfset ThisTeamID = AwayTeamID >
							<cfset ThisCID = AwayID >
							<cfset ThisClubName = AwayTeamName >
							<td align="left">
								<span class="pix18boldsilver">#HomeTeamName#</span>
								<cfif ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
									<span class="pix10"> <a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=H&DivisionID=#DivisionID#"><img src="gif/TeamSheet.gif" alt="Team Sheet" width="35" height="23" border="1" align="top"></a>
									<!--- <cfif TeamSizeTokenStart GT 0> --->
										&nbsp;<a href="StartingLineUpList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=H&DivisionID=#DivisionID#"><img src="gif/StartingLineUp.gif" alt="Starting Line-Up" width="47" height="23" border="1" align="top"></a>
									<!--- </cfif> --->										
									</span>
								</cfif>
							</td>
							<td align="center"><span class="pix18boldsilver">#HomeGoals#</span></td>
							<td align="left" bgcolor="aqua"><span class="pix18bold">#AwayTeamName#</span>
								<cfif ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
									<span class="pix10"><a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=A&DivisionID=#DivisionID#"><img src="gif/TeamSheet.gif" alt="Team Sheet" width="35" height="23" border="1" align="top"></a>
									<!--- <cfif TeamSizeTokenStart GT 0> --->
										&nbsp;<a href="StartingLineUpList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=A&DivisionID=#DivisionID#"><img src="gif/StartingLineUp.gif" alt="Starting Line-Up" width="47" height="23" border="1" align="top"></a>
									<!--- </cfif> --->										
									</span>
								</cfif>
							</td>
							<td align="center" bgcolor="aqua"><span class="pix18bold">#AwayGoals#</span></td>
						<cfelse>
							ERROR 28 in StartingLineUpList.cfm - aborting<cfabort>
						</cfif>
					</tr>
					<!--- Check Line Up --->
					<tr>
						<td colspan="6" align="CENTER" >
							<table width="60" border="0" cellspacing="0" cellpadding="2" align="CENTER">
								<tr>
									<td align="center" valign="middle" bgcolor="aqua">
										<cfset TheHomeTeam = QFixtureDate.HomeTeam>
										<cfset TheHomeOrdinal = QFixtureDate.HomeOrdinal>
										<cfset TheAwayTeam = QFixtureDate.AwayTeam>
										<cfset TheAwayOrdinal = QFixtureDate.AwayOrdinal>
										
<cfoutput>
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
								ERROR 37 in StartingLineUpList.cfm<cfabort>
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
								ERROR 384 in StartingLineUpList.cfm<cfabort>
							</cfif>
						</cfloop>
						<cfset tooltiptext = "#tooltiptext#<br>">
					</cfif>
					
					
					<cfset tooltiptext = Replace(tooltiptext, "'", "\'", "ALL")>
					<a onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='##FFFFF0';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=180;return escape('#ToolTipText#')"><img src="images/icon_lineup.png" border="0" align="absmiddle"></a>
				</cfif>
</cfoutput>
										
										
										
										
										
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<cfset TotalGoalsScored = 0 >
		<cfset StarPlayerCount = 0 >
		<cfif PlayerCount GT 0>
		<tr valign="TOP">
			<cfloop index="ColN" from="1" to="#NoOfCols#" step="1" >
				<cfset xxx=((#ColN#-1) * #NoOfPlayersPerCol#)+1>
				<cfset yyy=MIN((#ColN# * #NoOfPlayersPerCol#),#PlayerCount#)>
				<td align="center">
<!---
							*************************************************************
							* Produce the list of players with shirt numbers specified  *
							* across the top half of screen in columns ( see NoOfCols)	*
							*************************************************************
--->
					<table border="0" cellspacing="1" cellpadding="2" >
						<tr>
							<td align="center"><span class="pix10">Select</span></td>
							<td align="center"><span class="pix10">Activity</span></td>							
							<td align="center"><span class="pix10">Posn.No.</span></td>
							<td align="center"><span class="pix10">Shirt No.</span></td>
							<!--- <td align="center"><span class="pix10">RegNo</span></td> --->
							<td colspan="2" align="left"><span class="pix10">Player Name</span>
						</tr>
						<cfloop index="RowN" from="#xxx#" to="#yyy#" step="1">
							<cfset ThisAppearanceType = ListGetAt(AppearanceTypeList, RowN)>
							<cfif ThisAppearanceType IS 'Started'>
								<cfif RowN Mod 2 IS 0>
									<cfset rowcolor = "#BlueColor1#" >
								<cfelse>
									<cfset rowcolor = "#BlueColor2#" >
								</cfif>
							<cfelseif ThisAppearanceType IS 'SubUsed'>
								<cfset rowcolor = "Silver" >
							<cfelseif ThisAppearanceType IS 'SubNotUsed'>
								<cfset rowcolor = "White" >
							<cfelse>
								ERROR 598645 StartingLineUpList.cfm<cfabort>
							</cfif>
							<cfset ThisPlayerID = ListGetAt(PlayerIDList, RowN)>
							<input type="Hidden" name="ppid#RowN#" value="#ThisPlayerID#">
							<tr bgcolor="#rowcolor#">
								<!--- <cfset ThisRegType = ListGetAt(RegTypeList, RowN)> --->
								<cfset ThisSurname = ListGetAt(PlayerSurnameList, RowN)>
								<cfset ThisForename = ListGetAt(PlayerForenameList, RowN)>
								<cfset ThisNominalShirtNumber = ListGetAt(NominalShirtNumberList, RowN)>
								<cfset ThisActualShirtNumber = ListGetAt(ActualShirtNumberList, RowN)>
								<cfset OG = "No">
								<input type="Hidden" name="AppID#RowN#" value="#ListGetAt(AppearanceIDList, RowN)#">
								<td align="center"> <!--- Started check box --->
									<input type="Checkbox" name="ppp#RowN#" checked>
								</td>
								<cfif ThisAppearanceType IS 'Started'>
										<td align="center"><span class="pix10">Started</span></td>								
										<td align="center"><span class="pix13">#ThisNominalShirtNumber#</span></td>								
										<td align="center">
											<table border="1" cellpadding="2" cellspacing="0"><tr><td><span class="pix13bold">#ThisActualShirtNumber#</span></td></tr></table>
										</td>
										
										


										
								<cfelseif ThisAppearanceType IS 'SubUsed'>
										<td align="center" ><span class="pix10">Sub Played</span></td>								
										<td align="center" ><span class="pix13">#ThisNominalShirtNumber#</span></td>								
										<td align="center">
											<table border="1" cellpadding="2" cellspacing="0"><tr><td><span class="pix13bold">#ThisActualShirtNumber#</span></td></tr></table>
										</td>
								<cfelseif ThisAppearanceType IS 'SubNotUsed'>
										<td align="center" ><span class="pix10">Sub Not Played</span></td>								
										<td align="center" ><span class="pix13">#ThisNominalShirtNumber#</span></td>								
										<td align="center">
											<table border="1" cellpadding="2" cellspacing="0"><tr><td><span class="pix13bold">#ThisActualShirtNumber#</span></td></tr></table>
										</td>
								<cfelse>
								ERROR 456445 StartingLineUpList.cfm<cfabort>
								</cfif>
								<cfif ListGetAt(CardList, RowN) IS 0> <!--- Not carded --->
										<td bgcolor="#rowcolor#"><a href="PlayersHist.cfm?PI=#ThisPlayerID#&LeagueCode=#LeagueCode#"><span class="pix13bold">#ThisSurname#</span></a></td><!--- Player's name --->
										<td bgcolor="#rowcolor#"><span class="pix13">#ThisForename#</span></td><!--- Player's Forename(s) --->
										<td bgcolor="#rowcolor#"><span class="pix13bold">&nbsp;</span></td>
								<cfelseif ListGetAt(CardList, RowN) IS 1> <!--- YELLOW CARD --->
										<td bgcolor="#rowcolor#"><a href="PlayersHist.cfm?PI=#ThisPlayerID#&LeagueCode=#LeagueCode#"><span class="pix13bold">#ThisSurname#</span></a></td><!--- Player's name --->
										<td bgcolor="#rowcolor#"><span class="pix13">#ThisForename#</span></td><!--- Player's Forename(s) --->
										<td bgcolor="Yellow"><span class="pix13bold">Y</span></td>
								<cfelseif ListGetAt(CardList, RowN) IS 3> <!--- RED CARD --->
										<td bgcolor="#rowcolor#"><a href="PlayersHist.cfm?PI=#ThisPlayerID#&LeagueCode=#LeagueCode#"><span class="pix13bold">#ThisSurname#</span></a></td><!--- Player's name --->
										<td bgcolor="#rowcolor#"><span class="pix13">#ThisForename#</span></td><!--- Player's Forename(s) --->
										<td bgcolor="Red"><span class="pix13boldwhite">R</span></td>
								<cfelseif ListGetAt(CardList, RowN) IS 4> <!--- YELLOW CARD + straight RED CARD = ORANGE --->
										<td bgcolor="#rowcolor#"><a href="PlayersHist.cfm?PI=#ThisPlayerID#&LeagueCode=#LeagueCode#"><span class="pix13bold">#ThisSurname#</span></a></td><!--- Player's name --->
										<td bgcolor="#rowcolor#"><span class="pix13">#ThisForename#</span></td><!--- Player's Forename(s) --->
										<td bgcolor="Orange"><span class="pix13bold">4</span></td>
								</cfif>
							</tr>

<!--- IN DEVELOPMENT
<cfif ListGetAt(GoalsScoredList, RowN) GT 0>
	<cfloop index="GoalNo" from="1" to="#ListGetAt(GoalsScoredList, RowN)#" step="1" >
		<tr>
			<td colspan="5">
				<span class="pix10">Goal #GoalNo#:</span>
			</td>
		</tr>
	</cfloop>
</cfif>
--->

							
						</cfloop>
					</table>
				</td>
			</cfloop>
			
		</tr>
		</cfif>
	</cfoutput>
	
 	
	
	<cfset PlayerCount = QPlayersWhoDidNotStart.RecordCount>
	<input type="Hidden" name="PlayersWhoDidNotStartCount" value="<cfoutput>#PlayerCount#</cfoutput>">
	<cfif PlayerCount Mod NoOfCols IS 0 >
		<cfset NoOfPlayersPerCol = PlayerCount / NoOfCols>
	<cfelse>
		<cfset NoOfPlayersPerCol = Round((PlayerCount / NoOfCols)+ 0.5) >
	</cfif>
	<cfset PlayerIDList=ValueList(QPlayersWhoDidNotStart.PlayerID)>
	<cfset AppearanceIDList=ValueList(QPlayersWhoDidNotStart.AppearanceID)>
	<cfset AppearanceTypeList=ValueList(QPlayersWhoDidNotStart.AppearanceType)>
	<cfset PlayerSurnameList=ValueList(QPlayersWhoDidNotStart.PlayerSurname)>
	<cfset PlayerForenameList=ValueList(QPlayersWhoDidNotStart.PlayerForename)>
<!---
							*************************************************************
							* Produce the list of players without shirt numbers         *
							* across the bottom half of screen in columns (see NoOfCols)*
							*************************************************************
--->
	<cfoutput>
		<cfset ExternalTokenStart = Find( "External", QTeamName.DivisionNotes)>
		<tr bgcolor="#bg_highlight#">
			<cfloop index="ColN" from="1" to="#NoOfCols#" step="1" >
				<cfset xxx=((#ColN#-1) * #NoOfPlayersPerCol#)+1>
				<cfset yyy=MIN((#ColN# * #NoOfPlayersPerCol#),#PlayerCount#)>
				<td>
					<cfif QPlayersWhoDidNotStart.RecordCount GT 0>
				
					<table border="0" align="center" cellpadding="2" cellspacing="1" >
						<tr>
							<!--- temporary for testing purposes only
							<td><span class="pix9">&nbsp;</span></td>
						    --->
							<td align="center"><span class="pix10">Select</span></td>
							<td align="center"><span class="pix10">Activity</span></td>
							<td align="center"><span class="pix10">Position<br>No.</span></td>
							<td align="center"><span class="pix10">Shirt No.<br>if different</span></td>
							<!--- <td align="center"><span class="pix10">RegNo</span></td> --->
							<td align="left"><span class="pix10">Player Name</span>
						</tr>
						<cfloop index="RowN" from="#xxx#" to="#yyy#" step="1">

						<cfset ThisAppearanceType = ListGetAt(AppearanceTypeList, RowN)>
						<cfif ThisAppearanceType IS "Started">
							<cfset AppearanceTypeText = "Started">
							<cfif RowN Mod 2 IS 0 >
								<cfset rowcolor = "#bg_highlight#" >
							<cfelse>
								<cfset rowcolor = "pink" >
							</cfif>
						<cfelseif ThisAppearanceType IS "SubUsed">
							<cfset AppearanceTypeText = "Sub Played">
							<cfset rowcolor = "Silver" >
						<cfelseif ThisAppearanceType IS "SubNotUsed">
							<cfset AppearanceTypeText = "Sub Not Played">
							<cfset rowcolor = "White" >
						<cfelse>
							ERROR 456 in StartingLineUpList.cfm<cfabort>
						</cfif>
						
						<cfset ThisPlayerID = ListGetAt(PlayerIDList, RowN)>
						<input type="Hidden" name="PID#RowN#" value="#ThisPlayerID#">
						
						<cfset ThisAppearanceID = ListGetAt(AppearanceIDList, RowN)>
						<input type="Hidden" name="AID#RowN#" value="#ThisAppearanceID#">
						
						<tr>
							
							<!--- temporary for testing purposes only 
							<td bgcolor="#rowcolor#" align="center" valign="top"><span class="pix9">#ThisAppearanceID#</span></td>
							--->
							<!--- Select tick mark --->
							<td bgcolor="#rowcolor#" align="center" ><input type="Checkbox" name="P#RowN#" checked ></td>
							
							<!--- Started, Sub Played, Sub Not Played --->
							<td bgcolor="#rowcolor#" ><span class="pix10">#AppearanceTypeText#</span></td>

							 <!--- Nominal Shirt Number --->
							<td bgcolor="#rowcolor#" align="center" ><span class="pix13"><cfinput type="Text" name="NSN#RowN#" message="Position number invalid" validate="integer" required="No" size="1" maxlength="2"></span></td>
							 <!--- Actual Shirt Number --->
							<td bgcolor="#rowcolor#" align="center" ><span class="pix13"><cfinput type="Text" name="ASN#RowN#" message="Shirt number invalid" validate="integer" required="No" size="1" maxlength="2"></span></td>

							<cfset ThisSurname = ListGetAt(PlayerSurnameList, RowN)>
							<cfset ThisForename = ListGetAt(PlayerForenameList, RowN)>
							<td bgcolor="#rowcolor#" ><span class="pix13bold">#ThisSurname#</span></td><!--- Player's Surname --->
							<td bgcolor="#rowcolor#" ><span class="pix13">#ThisForename#</span></td><!--- Player's Forename --->
						</tr>
				
						</cfloop>
					</table>
					</cfif>
				</td>
				
			</cfloop>
		</tr>
			<!--- ERROR  messages --->
			<cfoutput> 
				<cfif QPlayersWhoStarted.RecordCount GT 0 AND QPlayersWhoDidNotStart.RecordCount GT 0>
					<span class="pix24boldred"><br>ERROR: Starting Line-Up and Substitutes not completed</span>
				<cfelse>
					<!--- Check for valid shirtnumbers --->
					<cfinclude template="queries/qry_QCheckShirts.cfm"> 
					<cfif StartingPlayerCount IS QCheckShirts03.RecordCount>
						<cfif (QCheckShirts01.Counter IS NOT QCheckShirts02.Counter) OR (QCheckShirts04.Counter IS NOT QCheckShirts05.Counter)>
							<span class="pix24boldred"><br>ERROR: Posn. No. column must be in ascending sequence without any duplicates. To fix this untick the duplicates and click on OK, then add them again. </span>
						<cfelseif QCheckShirts01.Cntr IS NOT QCheckShirts02.Counter >
							<span class="pix24boldred"><br>ERROR: Shirt No. column must not have any duplicates</span>
						<cfelse>	
							<cfset NominalShirtnumberList=ValueList(QCheckShirts03.NominalShirtnumber)>
							<cfset CheckNominalShirtnumberList=''>
							<!--- if the number of players starting is eleven then both these lists will be 1,2,3,4,5,6,7,8,9,10,11 and must match 
							 or if the number of players starting is ten then both these lists will be 1,2,3,4,5,6,7,8,9,10 etc and must match --->
							<cfloop from="1" to="#QCheckShirts03.RecordCount#" index="m">
								<cfset CheckNominalShirtnumberList = ListAppend(CheckNominalShirtnumberList, m)>
							</cfloop>
							<cfif NominalShirtnumberList IS NOT CheckNominalShirtnumberList>
								<span class="pix24boldred"><br>ERROR: Posn. No. column for players who started must be #CheckNominalShirtnumberList#</span>
							</cfif>
						</cfif>
					<cfelse>
					</cfif>
				</cfif>
			</cfoutput>
		<!---
		**********************************
		*  Is the OK button displayed?   *
		**********************************
		--->
		<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
		<!--- Warning if this teamsheet is for a future game --->
			<cfif DateCompare(QFixtureDate.FixtureDate, Now()) IS 1 >
			<!--- produces a warning line above the table because the cfoutput is immediate --->
				<cfoutput>
					<center>
						<span class="pix18boldred">WARNING: This team sheet should only be updated on or after the match day.</span>
					</center>
				</cfoutput>
			</cfif>
			<tr>
				<td height="30" colspan="6" align="center" >
					<table border="0" align="center" cellpadding="5" cellspacing="3">
						<tr>
							<td width="200" align="center" bgcolor="lightgreen"><span class="pix10"><input name="OK_Button" type="submit" value="OK"><br />ALLOW</span></td>
							<td width="200" align="center" bgcolor="pink"><span class="pix10"><input name="OK_Button" type="submit" value="=OK="><br />PREVENT</span></td>
						</tr>
						<cfinclude template="queries/qry_QFixtureDate.cfm">
						
							<cfif HA IS "H">
								<cfif QFixtureDate.HomeTeamSheetOK><span class="pix10">Future updates by the club secretary of <strong>#QTeamName.TeamName1# #QTeamName.OrdinalName1#</strong></span> <span class="pix10boldred">PREVENTED.<cfelse><span class="pix10">Future updates by the club secretary of <strong>#QTeamName.TeamName1# #QTeamName.OrdinalName1#</strong> <span class="pix10boldgreen">ALLOWED.</span></cfif>
							<cfelseif HA IS "A">
								<cfif QFixtureDate.AwayTeamSheetOK><span class="pix10">Future updates by the club secretary of <strong>#QTeamName.TeamName2# #QTeamName.OrdinalName2#</strong></span> <span class="pix10boldred">PREVENTED.<cfelse><span class="pix10">Future updates by the club secretary of <strong>#QTeamName.TeamName2# #QTeamName.OrdinalName2#</strong> <span class="pix10boldgreen">ALLOWED.</span></cfif>
							<cfelse>
								ERROR 3456234 in StartingLineUpList.cfm - ABORTING
								<cfabort>
							</cfif>
					</table>
				</td>
				
			</tr>
		<cfelse> <!--- Yellow SecurityLevel --->
			<!--- Does this league suppress the entry of team sheets by clubs? --->		
		
		 	<cfif SuppressTeamSheetEntry IS "Yes">
			<!--- produces a warning line above the table because the cfoutput is immediate --->
				<cfoutput>
					<center>
						<span class="pix18boldred">Starting Line-Up can't be updated. Your league has suppressed this feature.</span>
					</center>
				</cfoutput>
			<!--- Is this teamsheet for a future game? Only allow team sheets to be updated after the game has been completed. --->		
			<cfelseif DateCompare(QFixtureDate.FixtureDate, Now()) IS 1 >
			<!--- produces a warning line above the table because the cfoutput is immediate --->
				<cfoutput>
					<center>
						<span class="pix18boldred">Starting Line-Up can't be updated until the match day or later.</span>
					</center>
				</cfoutput>
			<!--- Has this teamsheet previously been OK'd by a Silver or Skyblue security level person? 
			If so, the Club is not allowed to change the team sheet for this fixture --->
			<cfelseif HA IS "H" AND QValidFID.HomeTeamSheetOK >
					<!--- produces a warning line above the table because the cfoutput is immediate --->
					<cfoutput>
						<center>
						<span class="pix18boldred">No further updating of this Home Starting Line-Up is allowed by your club.</span><br />
						<span class="pix13boldred">If you believe this Starting Line-Up to be incomplete or inaccurate then please contact your Registration Secretary.</span>
						</center>
					</cfoutput>
			<cfelseif HA IS "A" AND QValidFID.AwayTeamSheetOK >
					<!--- produces a warning line above the table because the cfoutput is immediate --->
					<cfoutput>
						<center>
						<span class="pix18boldred">No further updating of this Away Starting Line-Up is allowed by your club.</span><br />
						<span class="pix13boldred">If you believe this Starting Line-Up to be incomplete or inaccurate then please contact your Registration Secretary.</span>
						</center>
					</cfoutput>
			<cfelse>
				<!--- For Yellow security, Goals & Ref Marks can also be entered if neither team has been prevented --->
				<tr>
					<td height="30" colspan="6" align="center" ><input name="OK_Button" type="submit" value="OK"></td>
				</tr>
			</cfif>
		</cfif>		
	</table>
	</cfoutput>
	
</cfform>

<script language="JavaScript" type="text/javascript" src="wz_tooltip.js"></script>
