<!--- Need to be logged in to see this report --->
<cfif NOT ListFind("Silver,Skyblue,Orange,Yellow",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfif ListFind("Yellow",request.SecurityLevel)>
	<cfif request.YellowKey IS NOT "#request.CurrentLeagueCode##request.DropDownTeamID#" >
		<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
		<cfabort>
	</cfif>
	<!--- Get Notes from newsitem table for this league where longcol is 'TeamComments' --->
	<cfinclude template="queries/qry_QTeamComments.cfm">
	<cfif QTeamComments.RecordCount IS 1>
		<cfset ThisText = Trim(QTeamComments.Notes) >
	<cfelse>
		<cfset ThisText = '' >
	</cfif>
</cfif>
<cfif ListFind("Orange",request.SecurityLevel)>
	<cfif NOT StructKeyExists(session, "cfmlist") >
		<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
		<cfabort>
	</cfif>
	<cflock scope="session" timeout="10" type="readonly">
		<cfset request.cfmlist = session.cfmlist >
	</cflock> 
	<cfset ThisCFM = GetToken( CGI.Script_Name, 2, "/")>
	<cfif NOT FindNoCase(ThisCFM, request.cfmlist) >
		<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
		<cfabort>
	</cfif>
	<cfif NOT (Right(LeagueCode,4) IS Year(Now())) AND NOT (Right(LeagueCode,4) IS Year(Now())+1) >
		<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
		<cfabort>
	</cfif>
</cfif>

<cflock scope="session" timeout="10" type="readonly">
	<cfset request.SportsmanshipMarksOutOfHundred = session.SportsmanshipMarksOutOfHundred>
	<cfset request.SeeOppositionTeamSheet = session.SeeOppositionTeamSheet>
	<cfset request.RefereeMarkMustBeEntered = session.RefereeMarkMustBeEntered>
	<cfset request.spare01 =  session.spare01>
	<cfset request.spare02 =  session.spare02>
	<cfset request.HideDoubleHdrMsg =  session.HideDoubleHdrMsg>
</cflock> 

<cfset BlueColor1 = "##D8FEF5">
<cfset BlueColor2 = "##B8FEF5">
				
				
<cfinclude template="queries/qry_QFixtureDate.cfm">

<cfif ListFind("Yellow",request.SecurityLevel)>
	<cfinclude template = "queries/qry_QValidFID.cfm">
	<!--- Is the FID valid for the current team ? Has it been tampered with in the URL ? --->
	<!--- <cfdump var="#QValidFID#"><cfdump var="#request#"> --->
	<cfif QValidFID.RecordCount IS 1>
		<cfif StructKeyExists(url, "HA")>
			<cfif QValidFID.HomeID IS request.DropDownTeamID AND url.HA IS "H" >
				<cfset HA = "H">
			<cfelseif QValidFID.AwayID IS request.DropDownTeamID AND url.HA IS "A" >
				<cfset HA = "A">
			<cfelseif QValidFID.HomeID IS request.DropDownTeamID AND url.HA IS "A"  AND request.SeeOppositionTeamSheet IS 1 >
				<cfset HA = "A">
			<cfelseif QValidFID.AwayID IS request.DropDownTeamID AND url.HA IS "H"  AND request.SeeOppositionTeamSheet IS 1 >
				<cfset HA = "H">
			<cfelse>
				<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
				<cfabort>
			</cfif>
		<cfelse>
			<cfif QValidFID.HomeID IS request.DropDownTeamID AND NOT (QValidFID.AwayID IS request.DropDownTeamID)>
				<cfset HA = "H">
			<cfelseif QValidFID.AwayID IS request.DropDownTeamID AND NOT (QValidFID.HomeID IS request.DropDownTeamID)>
				<cfset HA = "A">
			<cfelseif StructKeyExists(form, "HA") AND QValidFID.HomeID IS request.DropDownTeamID AND QValidFID.AwayID IS request.DropDownTeamID >
				<cfset HA = form.HA >
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
<!--- OK button has been pressed - so update accordingly before re-presenting the latest state of affairs --->
<cfif StructKeyExists(form, "OK_Button")>
	<cfif Form.OK_Button IS "OK" OR Form.OK_Button IS "=OK=">
		<cfif ListFind("Silver,Skyblue,Orange",request.SecurityLevel) >
			<cfinclude template = "UpdateTeamList.cfm">
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
				ERROR 67 in TeamList.cfm
				<cfabort>
			</cfif>
		<cfelseif ListFind("Yellow",request.SecurityLevel)>
			<cfif HA IS "H">
				<cfif QValidFID.HomeTeamSheetOK >
					<!--- HomeTeamSheetOK flag has just been set by another Silver or Skyblue user so don't do any updating --->
				<cfelse>
					<cfinclude template = "UpdateTeamList.cfm">
					<cfif StructKeyExists(form, "HomeGoals") AND StructKeyExists(form, "AwayGoals") >
						<cfinclude template = "queries/upd_Scoreline.cfm">
						<cfinclude template = "queries/qry_QThisDivision.cfm">
						<cfset ThisDivisionID = QThisDivision.DID >						
						<cfinclude template="RefreshLeagueTable.cfm">
					</cfif>
					<cfif StructKeyExists(form, "RefereeMarksH") >
						<cfif request.RefereeMarkMustBeEntered IS 1 AND Trim(Form.RefereeMarksH) IS "">
						<cfelse>
							<cfinclude template = "queries/upd_RefereeMarksH.cfm">
						</cfif>
					</cfif>
					<cfif StructKeyExists(form, "MatchOfficialsExpenses") >
						<cfinclude template = "queries/upd_MatchOfficialsExpensesH.cfm">
					</cfif>
					<cfif StructKeyExists(form, "AwaySportsmanshipMarks") > <!--- Home team marks the away team's sportsmanship --->
						<cfinclude template = "queries/upd_AwaySportsmanshipMarks.cfm">
					</cfif>
					<cfif StructKeyExists(form, "HomeTeamNotes") >
						<cfset LenHomeTeamNotes = Len(Trim(form.HomeTeamNotes)) >
						<cfif LenHomeTeamNotes GT 255 >
							<cfoutput>
							<span class="pix18boldred"><br><br>The 255 character limit has been exceeded.<br><br> 
							Please click on the Back button of your browser <br>and reduce the Home team's comments (currently #LenHomeTeamNotes# characters).</span>
							<br><br><span class="pix13bold">If you have a long report to submit please send it in an email to the appropriate league officer.</span>
							<cfabort>
							</cfoutput>
						<cfelse>
							<cfinclude template = "queries/upd_HomeTeamNotes.cfm">
						</cfif>
					</cfif>
				</cfif>
			<cfelseif  HA IS "A">
				<cfif QValidFID.AwayTeamSheetOK >
					<!--- AwayTeamSheetOK flag has just been set by another Silver or Skyblue user so don't do any updating --->
				<cfelse>
					<cfinclude template = "UpdateTeamList.cfm">
					<cfif StructKeyExists(form, "HomeGoals") AND StructKeyExists(form, "AwayGoals") >
						<cfinclude template = "queries/upd_Scoreline.cfm">
						<cfinclude template = "queries/qry_QThisDivision.cfm">
						<cfset ThisDivisionID = QThisDivision.DID >
						<cfinclude template="RefreshLeagueTable.cfm">
					</cfif>
					<cfif StructKeyExists(form, "RefereeMarksA") >
						<cfif request.RefereeMarkMustBeEntered IS 1 AND Trim(Form.RefereeMarksA) IS "">
						<cfelse>
							<cfinclude template = "queries/upd_RefereeMarksA.cfm">
						</cfif>
					</cfif>
					<cfif StructKeyExists(form, "HospitalityMarks") >
						<cfinclude template = "queries/upd_HospitalityMarks.cfm">
					</cfif>
					<cfif StructKeyExists(form, "HomeSportsmanshipMarks") > <!--- Away team marks the home team's sportsmanship --->
						<cfinclude template = "queries/upd_HomeSportsmanshipMarks.cfm">
					</cfif>
					<cfif StructKeyExists(form, "AwayTeamNotes") >
						<cfset LenAwayTeamNotes = Len(Trim(form.AwayTeamNotes)) >
						<cfif LenAwayTeamNotes GT 255 >
							<cfoutput>
							<span class="pix18boldred"><br><br>The 255 character limit has been exceeded.<br><br> 
							Please click on the Back button of your browser <br>and reduce the Away team's comments (currently #LenAwayTeamNotes# characters).</span>
							<br><br><span class="pix13bold">If you have a long report to submit please send it in an email to the appropriate league officer.</span>
							<cfabort>
							</cfoutput>
						<cfelse>
							<cfinclude template = "queries/upd_AwayTeamNotes.cfm">
						</cfif>
					</cfif>
					
				</cfif>
			<cfelse>
				ERROR 45 in TeamList.cfm
				<cfabort>
			</cfif>
		</cfif>
	</cfif>
</cfif>

<cfinclude template = "queries/qry_QTeamName.cfm">

<!--- This query is used to populate the top half of the screen --->
<cfinclude template = "queries/qry_QPlayersWhoPlayed.cfm">

<cfset PlayerIDList=ValueList(QPlayersWhoPlayed.PlayerID)>
<cfset CutOffDate = '' >
<cfset MaxAllowedOnTeamSheet = 18 > <!--- default value, overridden by 'TeamSize' in Division Notes --->
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

<cfset MaxAllowedOnTeamSheet = StartingPlayerCount + SubsUsedPlayerCount + SubsNotUsedPlayerCount >

<cfset AgeBandTokenStart = Find( "AgeBand", QTeamName.DivisionNotes)>
<cfif AgeBandTokenStart GT 0>
	<cfset AgeBandDD   = MID(QTeamName.DivisionNotes, AgeBandTokenStart+7, 2)>
	<cfset AgeBandMM   = MID(QTeamName.DivisionNotes, AgeBandTokenStart+9, 2)>
	<cfset AgeBandYYYY = MID(QTeamName.DivisionNotes, AgeBandTokenStart+11, 4)>
	<cfset DateString = "#AgeBandDD#/#AgeBandMM#/#AgeBandYYYY#">
	<cfif IsDate(DateString) IS "Yes">
		<cfset CutOffDate = CreateDate(AgeBandYYYY, AgeBandMM, AgeBandDD)>
	<cfelse>
		<span class="pix24boldred"><strong>ERROR: Invalid AgeBand<cfoutput>[#MID(QTeamName.DivisionNotes, AgeBandTokenStart+7, 10)#] - look at #QTeamName.divisionName# NOTES</cfoutput></strong></span>
		<cfabort>
	</cfif>		
</cfif>

<!--- new for 2013 season onwards - for Youth football  e.g. YearBand1 allows only 1 year age band, YearBand2 allows 2 year age band, YearBand3 allows 3 year age band--->
<cfset YearBandTokenStart = Find( "YearBand", QTeamName.DivisionNotes)>
<cfif YearBandTokenStart GT 0>
	<cfset YearBandNo = MID(QTeamName.DivisionNotes, YearBandTokenStart+8, 1)>
	<cfif NOT isValid("integer", YearBandNo)>
		<span class="pix24boldred"><strong>ERROR: Invalid YearBand<cfoutput>[#MID(QTeamName.DivisionNotes, YearBandTokenStart+8, 1)#] - look at #QTeamName.divisionName# NOTES</cfoutput></strong></span>
		<cfabort>
	</cfif>		
<cfelse>
	<cfset YearBandNo = 1>
</cfif>


<!--- This query is used to populate the bottom half of the screen --->
<cfinclude template = "queries/qry_PlayersWhoDidNotPlay.cfm">
<!---<cfdump var="#QPlayersWhoDidNotPlay#"><cfabort> --->
<cfif HideSuspensions IS "1" AND ListFind("Yellow",request.SecurityLevel) >
	<cfset SuspendedPlayerIDList="">
	<cfoutput><center><span class="pix13boldred">Information regarding suspended players has been suppressed at the request of the league</span></center></cfoutput>
<cfelse>
	<cfinclude template = "queries/qry_QSuspendedPlayers_v1.cfm">
	<cfset SuspendedPlayerIDList=ValueList(QSuspendedPlayers.PlayerID)>
</cfif>
<cfform name="AppearancesForm" action="TeamList.cfm" >
	<cfoutput>
		<input type="Hidden" name="MaxAllowedOnTeamSheet" value="#MaxAllowedOnTeamSheet#">
		<input type="Hidden" name="StartingPlayerCount" value="#StartingPlayerCount#">
		<input type="Hidden" name="SubsUsedPlayerCount" value="#SubsUsedPlayerCount#">
		<input type="Hidden" name="SubsNotUsedPlayerCount" value="#SubsNotUsedPlayerCount#">
		
		<input type="Hidden" name="TblName" value="TeamList">
		<input type="Hidden" name="LeagueCode" value="#LeagueCode#">
		<input type="Hidden" name="DivisionID" value="#DivisionID#">
		<input type="Hidden" name="FID" value="#FID#">		
		<input type="Hidden" name="HA" value="#HA#">
	</cfoutput>
	<cfset PlayerCount = QPlayersWhoPlayed.RecordCount>
	<input type="Hidden" name="PlayersWhoPlayedCount" value="<cfoutput>#PlayerCount#</cfoutput>">
	<cfset NoOfCols = 2>
	<cfif PlayerCount Mod NoOfCols IS 0 >
		<cfset NoOfPlayersPerCol = PlayerCount / NoOfCols>
	<cfelse>
		<cfset NoOfPlayersPerCol = Round((PlayerCount / NoOfCols)+ 0.5) >
	</cfif>
	<cfset PlayerSurnameList=ValueList(QPlayersWhoPlayed.PlayerSurname)>
	<cfset PlayerForenameList=ValueList(QPlayersWhoPlayed.PlayerForename)>
	<cfset DOBList=QuotedValueList(QPlayersWhoPlayed.PlayerDOB)>
	<cfset RegNoList=ValueList(QPlayersWhoPlayed.PlayerRegNo)>
	<input type="Hidden" name="UpperRegNoList" value="<cfoutput>#RegNoList#</cfoutput>">							
	<cfset GoalsScoredList=ValueList(QPlayersWhoPlayed.GoalsScored)>
	<cfset CardList=ValueList(QPlayersWhoPlayed.Card)>
	<cfset StarPlayerList=ValueList(QPlayersWhoPlayed.StarPlayer)>
	<cfset ActivityList=ValueList(QPlayersWhoPlayed.Activity)>
	<cfset RegTypeList=QuotedValueList(QPlayersWhoPlayed.RegType)>
	<!--- replace any NULLs with Z - a NULL is returned by qry_QPlayersWhoPlayed.cfm 
	if a player on a teamsheet has his registration removed for the date range when he appeared --->
	<cfloop index="i" from="1" to="#ListLen(RegTypeList)#" step="1">
		<cfif ListGetAt(RegTypeList, i) IS "''" >
			<cfset RegTypeList = ListSetAt(RegTypeList,i,"'Z'") >
		</cfif>
	</cfloop>
	<cfset RegTypeList = Replace(RegTypeList,"'","","ALL") >
	
	<cfif ListFind(RegNoList, 0)>
		<cfset OwnGoalUpper = "Yes">
	<cfelse>
		<cfset OwnGoalUpper = "No">
	</cfif>
	<cfoutput query="QTeamName">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" align="CENTER" class="loggedinScreen">


		<cfif ListFind("Silver,Skyblue,Orange",request.SecurityLevel) >
			<tr bgcolor="Aqua">
				<td colspan="#NoOfCols#" align="LEFT">
					<span class="pix10">
						Click <a href="MissingAppearances.cfm?LeagueCode=#LeagueCode#"><strong>here</strong></a>
						 to see matches with missing player appearances.&nbsp;&nbsp;&nbsp;
					</span>			
				</td>
			</tr>
		</cfif>
		<tr>
			<td colspan="#NoOfCols#" align="CENTER" >
				<table width="100%" border="1" align="center" cellpadding="4" cellspacing="0" class="loggedinScreen">
					<tr>
						<td align="center">
							<span class="pix13bold"><a href="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(FixtureDate)#&DivisionID=#QFixtureDate.CurrentDivisionID#&LeagueCode=#LeagueCode#">#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#</a><br /></span>
							<span class="pix13bold">#DivisionName# <cfif TRIM(KORoundName) IS ""><cfelse> - #KORoundName#</cfif></span>
							<cfif ListFind("Silver,Skyblue,Orange",request.SecurityLevel) >					
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
								<cfif ListFind("Silver,Skyblue,Orange,Yellow",request.SecurityLevel) >
									<span class="pix10"><a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=H&DivisionID=#QFixtureDate.CurrentDivisionID#"><img src="gif/TeamSheet.gif" alt="Team Sheet" width="35" height="23" border="1" align="top"></a>
									<!--- <cfif TeamSizeTokenStart GT 0> --->
										&nbsp;<a href="StartingLineUpList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=H&DivisionID=#QFixtureDate.CurrentDivisionID#"><img src="gif/StartingLineUp.gif" alt="Starting Line-Up" width="47" height="23" border="1" align="top"></a>
									<!--- </cfif> --->										
									</span>
								</cfif>
							</td>
																																<!---
																																A=awarded away win, 
																																D=awarded draw, 
																																H=awarded home win, 
																																U=home win on penalties, 
																																V=away win on penalties, 
																																P=Postponed, 
																																Q=Abandoned, 
																																W=Void, 
																																T=TEMP fixture hidden
																																--->			
							<cfif ListFind("A,D,H,U,V,P,Q,W,T",QFixtureDate.Result)>
								<cfif ListFind("H",QFixtureDate.Result)>
									<cfset ExplainText = "Home Win Awarded">
								<cfelseif ListFind("A",QFixtureDate.Result)>
									<cfset ExplainText = "Away Win Awarded">
								<cfelseif ListFind("D",QFixtureDate.Result)>
									<cfset ExplainText = "Draw Awarded">
								<cfelseif ListFind("U",QFixtureDate.Result)>
									<cfset ExplainText = "Home Win on Penalties">
								<cfelseif ListFind("V",QFixtureDate.Result)>
									<cfset ExplainText = "Away Win on Penalties">
								<cfelseif ListFind("P",QFixtureDate.Result)>
									<cfset ExplainText = "Postponed">
								<cfelseif ListFind("Q",QFixtureDate.Result)>
									<cfset ExplainText = "Abandoned">
								<cfelseif ListFind("W",QFixtureDate.Result)>
									<cfset ExplainText = "Void">
								<cfelseif ListFind("T",QFixtureDate.Result)>
									<cfset ExplainText = "TEMP">
								</cfif>
								<td align="center" bgcolor="aqua"><span class="pix13boldrealblack">#ExplainText#</span></td>
							<cfelse>
								<td align="center" bgcolor="aqua"><span class="pix18bold">#HomeGoals#</span></td>
							</cfif>
							
							<td align="left">
								<span class="pix18boldsilver">#AwayTeamName#</span>
								<cfif ListFind("Silver,Skyblue,Orange,Yellow",request.SecurityLevel) >
									<cfif ListFind("Yellow",request.SecurityLevel) AND request.SeeOppositionTeamSheet IS 1 AND QValidFID.HomeID IS request.DropDownTeamID >
										<cfset ThisBorder="3">
									<cfelse>
										<cfset ThisBorder="1">
									</cfif>
									<span class="pix10"><a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=A&DivisionID=#QFixtureDate.CurrentDivisionID#"><img src="gif/TeamSheet.gif" alt="Team Sheet" width="35" height="23" border="#ThisBorder#" align="top"></a>
									<!--- <cfif TeamSizeTokenStart GT 0> --->
										&nbsp;<a href="StartingLineUpList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=A&DivisionID=#QFixtureDate.CurrentDivisionID#"><img src="gif/StartingLineUp.gif" alt="Starting Line-Up" width="47" height="23" border="1" align="top"></a>
									<!--- </cfif> --->										
									</span>
									<cfif ListFind("Yellow",request.SecurityLevel) AND request.SeeOppositionTeamSheet IS 1 AND QValidFID.HomeID IS request.DropDownTeamID AND NOT (QValidFID.AwayID IS request.DropDownTeamID)>
										<span class="pix13boldrealblack"><br>You are allowed to view the Away Team Sheet</span>
									</cfif>
								</cfif>
							</td>
							<td align="center"><span class="pix18boldsilver">#AwayGoals#</span></td>
						<cfelseif HA IS "A">
							<cfset ThisTeamID = AwayTeamID >
							<cfset ThisCID = AwayID >
							<cfset ThisClubName = AwayTeamName >
							<td align="left">
								<span class="pix18boldsilver">#HomeTeamName#</span>
								<cfif ListFind("Silver,Skyblue,Orange,Yellow",request.SecurityLevel) >
									<cfif ListFind("Yellow",request.SecurityLevel) AND request.SeeOppositionTeamSheet IS 1 AND QValidFID.AwayID IS request.DropDownTeamID >
										<cfset ThisBorder="3">
									<cfelse>
										<cfset ThisBorder="1">
									</cfif>
								
									<span class="pix10"><a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=H&DivisionID=#QFixtureDate.CurrentDivisionID#"><img src="gif/TeamSheet.gif" alt="Team Sheet" width="35" height="23" border="#ThisBorder#" align="top"></a>
									<!--- <cfif TeamSizeTokenStart GT 0> --->
										&nbsp;<a href="StartingLineUpList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=H&DivisionID=#QFixtureDate.CurrentDivisionID#"><img src="gif/StartingLineUp.gif" alt="Starting Line-Up" width="47" height="23" border="1" align="top"></a>
									<!--- </cfif> --->										
									</span>
									<cfif ListFind("Yellow",request.SecurityLevel) AND request.SeeOppositionTeamSheet IS 1 AND QValidFID.AwayID IS request.DropDownTeamID AND NOT (QValidFID.HomeID IS request.DropDownTeamID)>
										<span class="pix13boldrealblack"><br>You are allowed to view the Home Team Sheet</span>
									</cfif>
								</cfif>
							</td>
																																<!---
																																A=awarded away win, 
																																D=awarded draw, 
																																H=awarded home win, 
																																U=home win on penalties, 
																																V=away win on penalties, 
																																P=Postponed, 
																																Q=Abandoned, 
																																W=Void, 
																																T=TEMP fixture hidden
																																--->			
							<cfif ListFind("A,D,H,U,V,P,Q,W,T",QFixtureDate.Result)>
								<cfif ListFind("H",QFixtureDate.Result)>
									<cfset ExplainText = "Home Win Awarded">
								<cfelseif ListFind("A",QFixtureDate.Result)>
									<cfset ExplainText = "Away Win Awarded">
								<cfelseif ListFind("D",QFixtureDate.Result)>
									<cfset ExplainText = "Draw Awarded">
								<cfelseif ListFind("U",QFixtureDate.Result)>
									<cfset ExplainText = "Home Win on Penalties">
								<cfelseif ListFind("V",QFixtureDate.Result)>
									<cfset ExplainText = "Away Win on Penalties">
								<cfelseif ListFind("P",QFixtureDate.Result)>
									<cfset ExplainText = "Postponed">
								<cfelseif ListFind("Q",QFixtureDate.Result)>
									<cfset ExplainText = "Abandoned">
								<cfelseif ListFind("W",QFixtureDate.Result)>
									<cfset ExplainText = "Void">
								<cfelseif ListFind("T",QFixtureDate.Result)>
									<cfset ExplainText = "TEMP">
								</cfif>
								<td align="center" bgcolor="aqua"><span class="pix13boldrealblack">#ExplainText#</span></td>
							<cfelse>
								<td align="center" bgcolor="aqua"><span class="pix18boldsilver">#HomeGoals#</span></td>
							</cfif>














							<td align="left" bgcolor="aqua"><span class="pix18bold">#AwayTeamName#</span>
								<cfif ListFind("Silver,Skyblue,Orange,Yellow",request.SecurityLevel) >
									<span class="pix10"><a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=A&DivisionID=#QFixtureDate.CurrentDivisionID#"><img src="gif/TeamSheet.gif" alt="Team Sheet" width="35" height="23" border="1" align="top"></a>
									<!--- <cfif TeamSizeTokenStart GT 0> --->
										&nbsp;<a href="StartingLineUpList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=A&DivisionID=#QFixtureDate.CurrentDivisionID#"><img src="gif/StartingLineUp.gif" alt="Starting Line-Up" width="47" height="23" border="1" align="top"></a>
									<!--- </cfif> --->										
									</span>
								</cfif>
							</td>
							<td align="center" bgcolor="aqua"><span class="pix18bold">#AwayGoals#</span></td>
						<cfelse>
							ERROR 89 in TeamList - aborting<cfabort>
						</cfif>
						
						
						
						
						
						
					</tr>
				</table>
			</td>
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
											ERROR 37 in MtchDay.cfm
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
											ERROR 38 in MtchDay.cfm
										</cfif>
									</cfloop>
									<cfset tooltiptext = "#tooltiptext#<br>">
								</cfif>
								<cfset tooltiptext = Replace(tooltiptext, "'", "\'", "ALL")>
								<a onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='##FFFFF0';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=180;return escape('#ToolTipText#')"><img src="images/icon_lineup.png" border="0" align="absmiddle"></a>
							</cfif>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<cfif StructKeyExists(session, "DisplayAA") AND StructKeyExists(url, "DisplayAA") >
				<cflock scope="session" timeout="10" type="readonly">
					<cfset request.DisplayAA = session.DisplayAA >
				</cflock>
				<cfset ThisDisplayAA = url.DisplayAA >
			<cfelseif StructKeyExists(session, "DisplayAA") AND NOT StructKeyExists(url, "DisplayAA") >
				<cflock scope="session" timeout="10" type="readonly">
					<cfset request.DisplayAA = session.DisplayAA >
				</cflock>
				<cfset ThisDisplayAA = request.DisplayAA >
			<cfelseif NOT StructKeyExists(session, "DisplayAA") AND StructKeyExists(url, "DisplayAA") >
				<cfset ThisDisplayAA = url.DisplayAA >
			<cfelse> <!--- NOT StructKeyExists(session, "DisplayAA") AND NOT StructKeyExists(url, "DisplayAA") --->
				<cfset ThisDisplayAA = "Show" >
			</cfif>
			<td height="40" colspan="2">
				<table border="0" align="center" cellpadding="5" cellspacing="0" class="loggedinScreen">
					<tr>
						<cfif ThisDisplayAA IS "Show">
							<td align="center">
								<table border="0" cellpadding="2" cellspacing="0">
									<tr>
										<td>
											<span class="pix13bold"><a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=#HA#&DivisionID=#QFixtureDate.CurrentDivisionID#&DisplayAA=suppress">Click here</a> to hide the appearance analysis which </span>
										</td>
										<td bgcolor="white">
											<span class="pix13boldred">only counts up to and includes #DateFormat( FixtureDate , "DD MMM YYYY")#</span>
										</td>

									</tr>
								</table>
							</td>
						<cfelse>
							<td  align="center"><span class="pix13bold"><a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=#HA#&DivisionID=#QFixtureDate.CurrentDivisionID#&DisplayAA=show">Click here</a> to show the appearance analysis</span></td>
						</cfif>
					</tr>
				</table>
			</td>
		</tr>
		<cfset TotalGoalsScored = 0 >
		<cfset StarPlayerCount = 0 >
		<cfset StartedCount = 0 >
		<cfset SubUsedCount = 0 >
		<cfset SubNotUsedCount = 0 >
		<cfif PlayerCount GT 0>
			<tr valign="TOP">
			<cfloop index="ColN" from="1" to="#NoOfCols#" step="1" >
				<cfset xxx=((#ColN#-1) * #NoOfPlayersPerCol#)+1>
				<cfset yyy=MIN((#ColN# * #NoOfPlayersPerCol#),#PlayerCount#)>
				<td>
<!---
							*************************************************************
							* Produce the list of players who played	                *
							* across the top half of screen in columns ( see NoOfCols)	*
							*************************************************************
--->
					<table border="0" cellspacing="1" cellpadding="2" class="loggedinScreen">
					
					
					
						<tr>
							<td><span class="pix10">Select</span></td>
							<td><span class="pix10">Started</span></td>
							<td colspan="2" align="center"><span class="pix10">Sub<br>Played?</span></td>
							
							<td align="center"><span class="pix10">Goals</span></td>
							<td align="center" bgcolor="Yellow"><span class="pix13boldblack">Y</span></td>
							<td align="center" bgcolor="Red"><span class="pix13boldwhite">R</span></td>
							<td align="center"><img src="star1.gif"></td> <!--- Star Player --->
							<td align="center"><span class="pix10">RegNo</span></td>
							<td colspan="2" align="left"><span class="pix10">Player Name</span>
						</tr>
						<tr>
							<td colspan="2" align="center"></td>
							<td align="center" bgcolor="Silver"><span class="pix10">Y</span></td>
							<td align="center" bgcolor="white"><span class="pix10">N</span></td>
							<td colspan="7" align="center"></td>
						</tr>						
						
						
						<cfloop index="RowN" from="#xxx#" to="#yyy#" step="1">
						<cfif RowN Mod 2 IS 0>
							<cfset rowcolor = "#BlueColor1#" >
						<cfelse>
							<cfset rowcolor = "#BlueColor2#" >
						</cfif>
						
						<cfset ThisPlayerID = ListGetAt(PlayerIDList, RowN)>
						<input type="Hidden" name="ppid#RowN#" value="#ThisPlayerID#">
						<tr bgcolor="#rowcolor#">
							<cfset ThisRegType = ListGetAt(RegTypeList, RowN)>
							<cfset ThisSurname = ListGetAt(PlayerSurnameList, RowN)>
							<cfset ThisForename = ListGetAt(PlayerForenameList, RowN)>
							<cfif ListGetAt(RegNoList, RowN) IS 0 >
								<cfset OG = "Yes">
							<cfelse>
								<cfset OG = "No">
							</cfif>
							
							<!--- Select check box --->
								<td align="center" valign="top" <cfif ListGetAt(ActivityList, RowN) IS 2>bgcolor="Silver"<cfelseif ListGetAt(ActivityList, RowN) IS 3>bgcolor="white"</cfif> > 
									<input type="Checkbox" name="pp#RowN#" checked>
								</td>
							
							<!--- Activity radio button --->
								<!--- Started --->
								<td align="center" valign="top" <cfif ListGetAt(ActivityList, RowN) IS 2>bgcolor="Silver"<cfelseif ListGetAt(ActivityList, RowN) IS 3>bgcolor="white"</cfif>>
									<input name="activ#RowN#" type="radio" value="1" <cfif ListGetAt(ActivityList, RowN) IS 1>checked</cfif> >
								</td>
								<!--- Subs Played YES -- note that if SubsUsedPlayerCount is zero then don't allow entry --->
								<td align="center" valign="top" 
								<cfif ListGetAt(ActivityList, RowN) IS 2>bgcolor="Silver"<cfelseif ListGetAt(ActivityList, RowN) IS 3>bgcolor="white"</cfif>>
									<input name="activ#RowN#" type="radio" value="2" <cfif ListGetAt(ActivityList, RowN) IS 2>checked</cfif> <cfif OG OR (SubsUsedPlayerCount IS 0) >disabled</cfif>>
								</td>
								<!--- Subs Played NO -- note that if SubsNotUsedPlayerCount is zero then don't allow entry --->
								<td align="center" valign="top"  <cfif ListGetAt(ActivityList, RowN) IS 2>bgcolor="Silver"<cfelseif ListGetAt(ActivityList, RowN) IS 3>bgcolor="white"</cfif><cfif OG >disabled</cfif>>
									<input name="activ#RowN#" type="radio" value="3" <cfif ListGetAt(ActivityList, RowN) IS 3>checked</cfif> <cfif OG OR (SubsNotUsedPlayerCount IS 0) >disabled</cfif> >
								</td>
								<cfif ListGetAt(ActivityList, RowN) IS 1>
									<cfset StartedCount = StartedCount + 1 >
								</cfif>
								<cfif ListGetAt(ActivityList, RowN) IS 2>
									<cfset SubUsedCount = SubUsedCount + 1 >
								</cfif>
								<cfif ListGetAt(ActivityList, RowN) IS 3>
									<cfset SubNotUsedCount = SubNotUsedCount + 1 >
								</cfif>
								<!--- check for a non playing substitute who has scored goal(s) --->
								<cfset GScore = ListGetAt(GoalsScoredList, RowN)>
								<cfif GScore GT 0 AND ListGetAt(ActivityList, RowN) IS 3> <!--- ERROR --->
									<td align="center" valign="top" bgcolor="Red" > <!--- Goals text box --->
											<span class="pix16boldwhite">ERROR<br>non playing<br>substitute<br>has scored</span>
											<cfset TotalGoalsScored = TotalGoalsScored + GScore>
											<cfinput type="Text" name="gg#RowN#" value="#GScore#" message="Goals scored invalid" validate="integer" required="No" size="1" maxlength="2"> 
									</td>
								<cfelse>
									<td align="CENTER" valign="top" <cfif ListGetAt(ActivityList, RowN) IS 2>bgcolor="Silver"<cfelseif ListGetAt(ActivityList, RowN) IS 3>bgcolor="white"</cfif>> <!--- Goals text box --->
											<cfset TotalGoalsScored = TotalGoalsScored + GScore>
											<cfinput type="Text" name="gg#RowN#" value="#GScore#" message="Goals scored invalid" validate="integer" required="No" size="1" maxlength="2"> 
									</td>
								</cfif>

								<!--- Yellow Card check box --->
								<td   align="center" valign="top" <cfif ListGetAt(CardList, RowN) IS 1>bgcolor="Yellow"<cfelseif ListGetAt(CardList, RowN) IS 4>bgcolor="Orange"</cfif> > <!--- Yellow Card check box --->
									<input type="Checkbox" name="yy#RowN#"  <cfif ListGetAt(CardList, RowN) IS 1 OR ListGetAt(CardList, RowN) IS 4>checked</cfif> <cfif OG or (ListFind("Yellow",request.SecurityLevel) AND SuppressRedYellowCardsEntry)>disabled</cfif> >
								</td>
								<!--- Red Card check box --->
								<td   align="center" valign="top" <cfif ListGetAt(CardList, RowN) IS 3>bgcolor="Red"<cfelseif ListGetAt(CardList, RowN) IS 4>bgcolor="Orange"</cfif> > <!--- Red Card check box --->
									<input type="Checkbox" name="rr#RowN#"  <cfif ListGetAt(CardList, RowN) IS 3 OR ListGetAt(CardList, RowN) IS 4>checked</cfif> <cfif OG or (ListFind("Yellow",request.SecurityLevel) AND SuppressRedYellowCardsEntry)>disabled</cfif> >
								</td>
								<!--- Star Player check box --->
								<td align="center" valign="top" <cfif ListGetAt(StarPlayerList, RowN) IS 1>bgcolor="Blue"</cfif>>
									<cfif ListGetAt(StarPlayerList, RowN) IS 1>
										<cfset StarPlayerCount = StarPlayerCount + 1 >
									</cfif>
									<input type="Checkbox" name="ss#RowN#"  <cfif ListGetAt(StarPlayerList, RowN) IS 1 >checked</cfif> <cfif OG >disabled</cfif> >
								</td>

							<cfif ListGetAt(CardList, RowN) IS 0> <!--- Not carded --->
								<cfif OG>
									<td align="right" valign="top" bgcolor="#rowcolor#"><span class="pix13">&nbsp;</span></td><!--- Player's number will be blank --->
									<td align="left"  valign="top" bgcolor="#rowcolor#"><span class="pix13bold">Own Goal</span></td><!--- Player's Surname "Own Goal" --->
									<td align="left"  valign="top" bgcolor="#rowcolor#"><span class="pix13bold">&nbsp;</span></td><!--- Player's Forename " " --->
								<cfelse>
									<td align="right" valign="top" bgcolor="#rowcolor#"><span class="pix13realblack">#ListGetAt(RegNoList, RowN)#</span></td><!--- Player's number --->
									<td align="left"  valign="top" bgcolor="#rowcolor#"><a href="PlayersHist.cfm?PI=#ThisPlayerID#&LeagueCode=#LeagueCode#"><span class="pix13boldrealblack">#ThisSurname#</span></a></td><!--- Player's name --->
									<td align="left"  valign="top" bgcolor="#rowcolor#"><span class="pix13realblack">#ThisForename#</span></td><!--- Player's Forename(s) --->
								</cfif>
							<cfelseif ListGetAt(CardList, RowN) IS 1> <!--- YELLOW CARD --->
								<cfif OG>
									<td align="left"  valign="top" bgcolor="Yellow"><span class="pix13"><strong>ERROR</strong></span></td><!--- "Own Goal" must not have Yellow card --->
								<cfelse>
									<td align="right" valign="top" bgcolor="Yellow"><span class="pix13">#ListGetAt(RegNoList, RowN)#</span></td><!--- Player's number --->
									<td align="left"  valign="top" bgcolor="Yellow"><a href="PlayersHist.cfm?PI=#ThisPlayerID#&LeagueCode=#LeagueCode#"><span class="pix13boldrealblack">#ThisSurname#</span></a></td><!--- Player's name --->
									<td align="left"  valign="top" bgcolor="Yellow"><span class="pix13realblack">#ThisForename#</span></td><!--- Player's Forename(s) --->
								</cfif>
							<cfelseif ListGetAt(CardList, RowN) IS 3> <!--- RED CARD --->
								<cfif OG>
									<td align="left"  valign="top" bgcolor="Red"><span class="pix13boldwhite">ERROR</span></td><!--- "Own Goal" must not have Red card --->
								<cfelse>
									<td align="right" valign="top" bgcolor="Red"><span class="pix13boldwhite">#ListGetAt(RegNoList, RowN)#</span></td><!--- Player's number --->
									<td align="left"  valign="top" bgcolor="Red"><a href="PlayersHist.cfm?PI=#ThisPlayerID#&LeagueCode=#LeagueCode#"><span class="pix13boldrealblack">#ThisSurname#</span></a></td><!--- Player's name --->
									<td align="left"  valign="top" bgcolor="Red"><span class="pix13realblack">#ThisForename#</span></td><!--- Player's Forename(s) --->
								</cfif>
							<cfelseif ListGetAt(CardList, RowN) IS 4> <!--- YELLOW CARD + straight RED CARD = ORANGE --->
								<cfif OG>
									<td align="left"  valign="top" bgcolor="Orange"><span class="pix13bold">ERROR</span></td><!--- "Own Goal" must not have Orange card --->
								<cfelse>
									<td valign="top" align="right" bgcolor="Orange"><span class="pix13">#ListGetAt(RegNoList, RowN)#</span></td><!--- Player's number --->
									<td align="left"  valign="top" bgcolor="Orange"><a href="PlayersHist.cfm?PI=#ThisPlayerID#&LeagueCode=#LeagueCode#"><span class="pix13boldrealblack">#ThisSurname#</span></a></td><!--- Player's name --->
									<td align="left"  valign="top" bgcolor="Orange"><span class="pix13realblack">#ThisForename#</span></td><!--- Player's Forename(s) --->
								</cfif>
							</cfif>
								<!--- Registration Type --->
								<cfif     ThisRegType Is 'A'>
								<cfelseif ThisRegType Is 'B'>
								<cfelseif ThisRegType Is 'C'>
									<td valign="top"><table border="1" cellspacing="1" cellpadding="1" bgcolor="black" class="loggedinScreen"><tr><td class="bg_white"><span class="pix10bold">Short Loan</span></td></tr></table></td>
								<cfelseif ThisRegType Is 'D'>
									<td valign="top"><table border="1" cellpadding="1" cellspacing="1" bgcolor="black" class="loggedinScreen"><tr><td class="bg_highlight2"><span class="pix10bold">Long Loan</span></td></tr></table></td>
								<cfelseif ThisRegType Is 'E'>
									<td valign="top"><table border="1" cellpadding="1" cellspacing="1" bgcolor="black" class="loggedinScreen"><tr><td class="bg_lightgreen"><span class="pix10bold">Work Experience</span></td></tr></table></td>
								<cfelseif ThisRegType Is 'G'>
									<td valign="top"><table border="1" cellpadding="1" cellspacing="1" bgcolor="black" class="loggedinScreen"><tr><td class="bg_silver"><span class="pix10bold">Lapsed</span></td></tr></table></td>
								<cfelseif ThisRegType Is 'F'>
									<td valign="top"><table border="1" cellpadding="1" cellspacing="1" bgcolor="black" class="loggedinScreen"><tr><td class="bg_yellow"><span class="pix10bold">Temporary</span></td></tr></table></td>
								<cfelseif ThisRegType Is 'Z'>	
									<td valign="top">
										<table border="1" cellspacing="2" cellpadding="2" bgcolor="Red">
											<tr>
												<td bgcolor="White"><span class="pix10boldblack">Played while<br />unregistered<br /></span><a href="PlayedWhileUnregistered.cfm?LeagueCode=#LeagueCode#"><span class="pix10">see full report</span></a></td>
											</tr>
										</table>
									</td>
								<cfelse>	
									<td valign="top" class="bg_pink"><span class="pix10">ERROR</span></td>
								</cfif>
							
							<cfif ListFind(SuspendedPlayerIDList,ThisPlayerID)>
								<cfset ThisPlayerSuspended = "Yes">
							<cfelse>
								<cfset ThisPlayerSuspended = "No">
							</cfif>
							<cfif ThisPlayerSuspended >
								<td valign="top">
									<table border="1" cellspacing="2" cellpadding="2" bgcolor="Red" class="loggedinScreen">
										<tr>
											<td align="left" bgcolor="White"><span class="pix10boldblack">Played while<BR>suspended</span></td>
										</tr>
									</table>
								</td>
							</cfif>

							<cfif ThisDisplayAA IS "Show">
								<!--- check for appearances for other teams but same club --->
								<cfinclude template = "inclGetSame.cfm">
								<!--- check for appearances for other clubs --->
								<cfinclude template = "inclGetOther.cfm">
							<cfelse>
							</cfif>
							<cfinclude template="queries/qry_QGetCountAppearances.cfm">
							<cfif QGetCountAppearances.AppearedCount GT 1>
								<td valign="top">
									<table border="1" cellspacing="2" cellpadding="2" class="loggedinScreen">
										<tr>
											<td align="left" bgcolor="navy"><span class="pix10boldwhite">Played<br>#QGetCountAppearances.AppearedCount# games<br>today</span></td>
										</tr>
									</table>
								</td>
							</cfif>
						</tr>
						<cfif ListGetAt(CardList, RowN) GE 3> <!--- RED CARD --->
							<cfinclude template="InclAddUpdDelSuspension.cfm">
						</cfif>
						</cfloop>
					</table>
				</td>
			</cfloop>
			
			<cfoutput> 
				<!--- produces a warning line above the table even though it was calculated 
						after the table contents were processed 
						because the cfoutput is immediate --->
				<cfif OwnGoalUpper IS "Yes">
					<cfset PldCount = QPlayersWhoPlayed.RecordCount - 1>
					<cfset StartedCount = StartedCount - 1 >
				<cfelse>
					<cfset PldCount = QPlayersWhoPlayed.RecordCount>		
				</cfif>
				
				<cfif StartingPlayerCount GE StartedCount>
				<cfelse>
					<span class="pix24boldred">ERROR: Too many Started, maximum allowed #NumberFormat(StartingPlayerCount, '99')#</span><br />
				</cfif>
				
				<!---
				<cfif SubsUsedPlayerCount GE SubUsedCount>
				<cfelse>
					<span class="pix24boldred">ERROR: Too many Subs Played, maximum allowed #NumberFormat(SubsUsedPlayerCount, '99')#</span><br />
				</cfif>
				--->
				
				<cfset Allowance = MAX(0,SubsUsedPlayerCount - SubUsedCount)>
				<!---
				<cfif (SubsNotUsedPlayerCount+Allowance) GE SubNotUsedCount >
				<cfelse>
					<span class="pix24boldred">ERROR: Too many Subs Not Played, maximum allowed #NumberFormat((SubsNotUsedPlayerCount+Allowance), '99')#</span><br />
				</cfif>
				--->
				<cfset ShortLoanCount = 0>
				<cfset LongLoanCount = 0>
				<cfset WorkExperienceCount = 0>
				<cfloop index="ListElement" list="#RegTypeList#">
					<cfif #ListElement# IS "C">
						<cfset ShortLoanCount=ShortLoanCount+1>
					<cfelseif #ListElement# IS "D">
						<cfset LongLoanCount=LongLoanCount+1>
					<cfelseif #ListElement# IS "E">
						<cfset WorkExperienceCount=WorkExperienceCount+1>
					</cfif>
				</cfloop>
				<cfif ShortLoanCount GT 2 >
					<span class="pix24boldred">WARNING: Too many Short Loan players on team sheet. Max. 2 allowed.</span><br />
				</cfif>
				<cfif LongLoanCount GT 2 >
					<span class="pix24boldred">WARNING: Too many Long Loan players on team sheet. Max. 2 allowed.</span><br />
				</cfif>
				<cfif WorkExperienceCount GT 2 >
					<span class="pix24boldred">WARNING: Too many  Work Experience players on team sheet. Max. 2 allowed.</span><br />
				</cfif>
				<cfif ShortLoanCount+LongLoanCount+WorkExperienceCount GT 5 >
					<span class="pix24boldred">WARNING: Too many Short Loan, Long Loan or Work Experience players on team sheet. Max. 5 allowed.</span>
				</cfif>
				
				<cfif HA IS "H">
					<cfif QTeamName.HomeGoals IS ''>
						<cfset HGoals = 0 >
					<cfelse>
						<cfset HGoals = QTeamName.HomeGoals >
					</cfif>
					<input type="Hidden" name="HGoals" value="#HGoals#">
				</cfif>
				<cfif HA IS "A">
					<cfif QTeamName.AwayGoals IS ''>
						<cfset AGoals = 0 >
					<cfelse>
						<cfset AGoals = QTeamName.AwayGoals >
					</cfif>
					<input type="Hidden" name="AGoals" value="#AGoals#">
				</cfif>
				
				
				<cfif HA IS "H" AND TotalGoalsScored LT HGoals><span class="pix24boldred">WARNING: Goals must add up to #HGoals#</span></cfif>
				<cfif HA IS "A" AND TotalGoalsScored LT AGoals><span class="pix24boldred">WARNING: Goals must add up to #AGoals#</span></cfif>		
				<cfif HA IS "H" AND TotalGoalsScored GT HGoals><span class="pix24boldred">WARNING: Goals must add up to #HGoals#</span></cfif>
				<cfif HA IS "A" AND TotalGoalsScored GT AGoals><span class="pix24boldred">WARNING: Goals must add up to #AGoals#</span></cfif>
				
				<cfif StarPlayerCount GT 1>
					<span class="pix24boldred">WARNING: #StarPlayerCount# Star Players on team sheet.</span>
				</cfif>
				
			</cfoutput>
		</tr>
		<tr>
			<td colspan="#NoOfCols#" align="center" valign="middle" >
				<table border="0" cellpadding="2" cellspacing="0">
					<tr>
						<td align="left"><span class="pix13bold">Total=#PldCount#</span></td>
						<td align="left">&nbsp;&nbsp;</td>
						<td align="left"><span class="pix13bold">Started=#StartedCount#</span></td>
						<td align="left">&nbsp;&nbsp;</td>
						<td align="left" bgcolor="Silver"><span class="pix13bold">Subs Played=#SubUsedCount#</span></td>
						<td align="left">&nbsp;&nbsp;</td>
						<td align="left" bgcolor="White"><span class="pix13bold">Subs Not Played=#SubNotUsedCount#</span></td>
						<td align="left">&nbsp;&nbsp;</td>
						<td align="left"><span class="pix13bold">Total Goals=#TotalGoalsScored#</span></td>
						<td align="left">&nbsp;&nbsp;</td>
						<td align="left"><span class="pix13bold">Star Player=<img src="star1.gif" width="23" height="20" border="0" align="absmiddle"></span></td>
					</tr>
				</table>
			</td>
		</tr>
		</cfif>
	</cfoutput>
	<cfset PlayerCount = QPlayersWhoDidNotPlay.RecordCount>
	<input type="Hidden" name="PlayersWhoDidNotPlayCount" value="<cfoutput>#PlayerCount#</cfoutput>">
	<cfif PlayerCount Mod NoOfCols IS 0 >
		<cfset NoOfPlayersPerCol = PlayerCount / NoOfCols>
	<cfelse>
		<cfset NoOfPlayersPerCol = Round((PlayerCount / NoOfCols)+ 0.5) >
	</cfif>
	<cfset PlayerIDList=ValueList(QPlayersWhoDidNotPlay.PlayerID)>
	<cfset PlayerSurnameList=ValueList(QPlayersWhoDidNotPlay.PlayerSurname)>
	<cfset PlayerForenameList=ValueList(QPlayersWhoDidNotPlay.PlayerForename)>
	<cfset PlayerNotesList=ValueList(QPlayersWhoDidNotPlay.PlayerNotes,"¬")>
	<cfset DOBList=QuotedValueList(QPlayersWhoDidNotPlay.PlayerDOB)>	
	<cfset RegNoList=ValueList(QPlayersWhoDidNotPlay.PlayerRegNo)>
	<input type="Hidden" name="LowerRegNoList" value="<cfoutput>#RegNoList#</cfoutput>">
	<cfif ListFind(RegNoList, 0)>
		<cfset OwnGoalLower = "Yes">
	<cfelse>
		<cfset OwnGoalLower = "No">
	</cfif>
<!---
							*************************************************************
							* Produce the list of players who did not play              *
							* across the bottom half of screen in columns (see NoOfCols)*
							*************************************************************
--->
	<cfoutput>
		<cfset ExternalTokenStart = Find( "External", QTeamName.DivisionNotes)>
		<cfif IsDate(CutOffDate)>
			<tr>
				<td colspan="#NoOfCols#" align="CENTER" bgcolor="white">
					<cfif YearBandNo IS 3> <!--- three years allowed --->
						<span class="pix13bold">3 year age band is allowed. Players with dates of birth in range #DateFormat(DateAdd('d', 1, CutOffDate),'DD/MM/YYYY')# to #DateFormat(DateAdd('yyyy', 3, CutOffDate),'DD/MM/YYYY')#. Players shown in grey, green and pink are eligible. </span>
					<cfelseif YearBandNo IS 2> <!--- two years allowed --->
						<span class="pix13bold">2 year age band is allowed. Players with dates of birth in range #DateFormat(DateAdd('d', 1, CutOffDate),'DD/MM/YYYY')# to #DateFormat(DateAdd('yyyy', 2, CutOffDate),'DD/MM/YYYY')# are shown. Players in grey are eligible. Players in green are also eligible but a year younger. </span>
					<cfelse> <!--- default only one year allowed --->
						<span class="pix13bold">Only 1 year age band is allowed. Players with dates of birth in range #DateFormat(DateAdd('d', 1, CutOffDate),'DD/MM/YYYY')# to #DateFormat(DateAdd('yyyy', 1, CutOffDate),'DD/MM/YYYY')# are shown. Players in grey are eligible.  </span>
					</cfif>
				</td>
			</tr>
		</cfif>
		<tr valign="top"  bgcolor="#bg_highlight#">
			<cfloop index="ColN" from="1" to="#NoOfCols#" step="1" >
				<cfset xxx=((#ColN#-1) * #NoOfPlayersPerCol#)+1>
				<cfset yyy=MIN((#ColN# * #NoOfPlayersPerCol#),#PlayerCount#)>
				<td>
					<table border="0" cellpadding="2" cellspacing="1" >
						<tr>
							<td align="left"><span class="pix10">Select</span></td>
							<td align="left"><span class="pix10">Started</span></td>
							<td align="center" colspan="2" ><span class="pix10">Sub<br>Played?</span></td>
							<td align="center"><span class="pix10">Goals</span></td>
							<td align="center" bgcolor="Yellow"><span class="pix13boldblack">Y</span></td>
							<td align="center" bgcolor="Red"><span class="pix13boldwhite">R</span></td>
							<td align="center"><img src="star1.gif"></td> <!--- Star Player --->
							<td align="center"><span class="pix10">RegNo</span></td>
							<td align="left"><span class="pix10">Player Name</span>
						</tr>
							<td colspan="2" align="center"></td>
							<td align="center" bgcolor="Silver"><span class="pix10">Y</span></td>
							<td align="center" bgcolor="white"><span class="pix10">N</span></td>
							<td colspan="7" align="center"></td>
						
						<cfloop index="RowN" from="#xxx#" to="#yyy#" step="1">
						<cfif RowN Mod 2 IS 0>
							<cfset rowcolor = "##FFD0E3" >
						<cfelse>
							<cfset rowcolor = "pink" >
						</cfif>
						<cfset ThisPlayerID = ListGetAt(PlayerIDList, RowN)>
						<input type="Hidden" name="PID#RowN#" value="#ThisPlayerID#">
						<cfif ListFind(SuspendedPlayerIDList,ThisPlayerID)>
							<cfset ThisPlayerSuspended = "Yes">
						<cfelse>
							<cfset ThisPlayerSuspended = "No">
						</cfif>
						<cfif ListGetAt(RegNoList, RowN) IS 0 >
							<cfset OG = "Yes">
						<cfelse>
							<cfset OG = "No">
						</cfif>

						<tr>
							<!--- Played --->
							<td bgcolor="#rowcolor#" align="center" valign="top"><input type="Checkbox" name="P#RowN#" ></td>
							
							
							<!--- Activity radio button --->
								<!--- Started --->
								<td bgcolor="#rowcolor#" align="center" valign="top">
									<input name="actv#RowN#" type="radio" value="1" checked >
								</td>
								<!--- Subs Played YES -- note that if SubsUsedPlayerCount is zero then don't allow entry --->
								<td bgcolor="#rowcolor#" align="center" valign="top">
									<input name="actv#RowN#" type="radio" value="2" <cfif OG OR (SubsUsedPlayerCount IS 0) >disabled</cfif>>
								</td>
								<!--- Subs Played NO -- note that if SubsNotUsedPlayerCount is zero then don't allow entry --->
								<td bgcolor="#rowcolor#" align="center" valign="top">
									<input name="actv#RowN#" type="radio" value="3" <cfif OG OR (SubsNotUsedPlayerCount IS 0) >disabled</cfif>>
								</td>

							
							 <!--- Goals --->
							<td bgcolor="#rowcolor#" align="center" valign="top"><span class="pix13"><cfinput type="Text" name="G#RowN#" message="Goals scored invalid" validate="integer" required="No" size="1" maxlength="2"></span></td>
							<!--- Yellow Card --->
							<td bgcolor="#rowcolor#" align="CENTER" valign="top" ><input type="Checkbox" name="yc#RowN#" <cfif (ListFind("Yellow",request.SecurityLevel) AND SuppressRedYellowCardsEntry) OR ListGetAt(RegNoList, RowN) IS 0>disabled</cfif> ></td>		
							<!--- Red Card --->
							<td bgcolor="#rowcolor#" align="CENTER" valign="top" ><input type="Checkbox" name="rc#RowN#" <cfif (ListFind("Yellow",request.SecurityLevel) AND SuppressRedYellowCardsEntry) OR ListGetAt(RegNoList, RowN) IS 0>disabled</cfif> ></td>
							<!--- Star Player check box --->
							<td bgcolor="#rowcolor#" align="center" valign="top" ><input type="Checkbox" name="S#RowN#" <cfif ListGetAt(RegNoList, RowN) IS 0>disabled</cfif> ></td>
							<cfset ThisPlayerIsInAgeBand = "No">
							<cfset ThisPlayerIsYoung = "No">
							<cfset ThisDOB = "">
							<cfif AgeBandTokenStart GT 0>
								<!--- Player's DOB --->
								<cfset ThisDOB = Replace(ListGetAt(DOBList, RowN), "'", "", "ALL")>
								<cfif ThisDOB IS "">
								<cfelse>
									<cfset DayCount = DateDiff( "D", CutOffDate, ThisDOB )>
									<cfif DayCount GT 0 AND DayCount LT 366> <!--- 1 year band --->
										<cfset ThisPlayerIsInAgeBand = "Yes">
									</cfif>
									<cfif DayCount GE 366 AND DayCount LT 730> <!--- 2 year band --->
										<cfset ThisPlayerIsYoung = "Yes">
									</cfif>
								</cfif>
							</cfif>
							<cfif ThisPlayerSuspended >
								<cfset this_bgcolor="White">
							<cfelseif ThisPlayerIsInAgeBand >
								<cfset this_bgcolor="Silver">
							<cfelseif ThisPlayerIsYoung >
								<cfset this_bgcolor="Lime">
							<cfelse>
								<cfset this_bgcolor="#bg_highlight#">
							</cfif>
							<cfset ThisSurname = ListGetAt(PlayerSurnameList, RowN)>
							<cfset ThisForename = ListGetAt(PlayerForenameList, RowN)>
							<cfset ThisNotes = ListGetAt(PlayerNotesList, RowN, "¬")>
							<cfif OG >
								<td align="right" bgcolor="#rowcolor#" valign="top"><span class="pix13">&nbsp;</span></td><!--- Player's number will be blank --->
								<td align="left"  bgcolor="#rowcolor#" valign="top"><span class="pix13bold">Own Goal</span></td><!--- Player's Surname "Own Goal" --->
								<td align="left"  bgcolor="#rowcolor#" valign="top"><span class="pix13bold">&nbsp;</span></td><!--- Player's Forename " " --->
							<cfelseif AgeBandTokenStart GT 0> 
								<td align="right" bgcolor="#this_bgcolor#" valign="top"><span class="pix13">#ListGetAt(RegNoList, RowN)#</span></td><!--- Player's number --->
								<td align="left"  bgcolor="#this_bgcolor#" valign="top"><span class="pix13bold">#ThisSurname#</span></td><!--- Player's Surname --->
								<td align="left"  bgcolor="#this_bgcolor#" valign="top"><span class="pix13">#ThisForename#</span></td><!--- Player's Forename --->
							<cfelse>
								<td align="right" bgcolor="#rowcolor#" valign="top"><span class="pix13">#ListGetAt(RegNoList, RowN)#</span></td><!--- Player's number --->
								<td align="left"  bgcolor="#rowcolor#" valign="top"><span class="pix13bold">#ThisSurname#</span></td><!--- Player's Surname --->
								<td align="left"  bgcolor="#rowcolor#" valign="top"><span class="pix13">#ThisForename#</span></td><!--- Player's Forename --->
							</cfif>
							<cfif AgeBandTokenStart GT 0>
								<cfif ThisDOB IS "">
									<cfset AgeTxt = "">
								<cfelse>
									<cfset AgeTxt = "#DateDiff( "YYYY",  ThisDOB, QFixtureDate.FixtureDate )#" >
								</cfif>
								<cfif OG >
									<td align="left"   bgcolor="#rowcolor#" valign="top" ><span class="pix9">#DateFormat(ThisDOB, 'DD/MM/YY')#</span></td>
									<td align="center" bgcolor="#rowcolor#" valign="top" width="30"><span class="pix9">#AgeTxt#</span></td>
									<td align="left"   bgcolor="#rowcolor#" valign="top" ><span class="pix9">#ThisNotes#</span></td><!--- Player's Notes --->
								<cfelse>
									<td align="left"   bgcolor="#this_bgcolor#" valign="top" ><span class="pix9">#DateFormat(ThisDOB, 'DD/MM/YY')#</span></td>
									<td align="center" bgcolor="#this_bgcolor#" valign="top" width="30"><span class="pix9">#AgeTxt#</span></td>
									<td align="left"   bgcolor="#this_bgcolor#" valign="top" ><span class="pix9">#ThisNotes#</span></td><!--- Player's Notes --->
								</cfif>							
							</cfif>
							<cfif ThisPlayerSuspended><td bgcolor="white"><span class="pix13boldred">Suspended</span></td></cfif>
							<cfif ThisDisplayAA IS "Show">
								<!--- check for appearances for other teams but same club --->
								<cfinclude template = "inclGetSame.cfm">
								<!--- check for appearances for other clubs --->
								<cfinclude template = "inclGetOther.cfm">
							<cfelse>
							</cfif>
						</cfloop>
					</table>
				</td>
				
			</cfloop>
		</tr>
		<!---
		**********************************
		*  Is the OK button displayed?   *
		**********************************
		--->
		<cfif ListFind("Silver,Skyblue,Orange",request.SecurityLevel) >
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
								ERROR IN TeamList.cfm - ABORTING
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
						<span class="pix18boldred">Team sheet can't be updated. Your league has suppressed this feature.</span>
					</center>
				</cfoutput>
			
			<!--- Is this teamsheet for a future game? Only allow team sheets to be updated after the game has been completed. --->
			<cfelseif DateCompare(QFixtureDate.FixtureDate, Now()) IS 1 >
			<!--- produces a warning line above the table because the cfoutput is immediate --->
				<cfoutput>
					<center>
						<span class="pix18boldred">Team sheet can't be updated until the match day or later.</span>
					</center>
				</cfoutput>
			<cfelseif QValidFID.AwayID IS request.DropDownTeamID AND HA IS "H" AND NOT (QValidFID.HomeID IS request.DropDownTeamID) >
			<!--- The Home Team sheet is read only, unless parent team (e.g. Reds Utd) is the same e.g. Reds Utd Eagles v Reds Utd Blues (different ordinals) --->
			
			<cfelseif QValidFID.HomeID IS request.DropDownTeamID AND HA IS "A" AND NOT (QValidFID.AwayID IS request.DropDownTeamID) >
			<!--- The Away Team sheet is read only, unless parent team (e.g. Reds Utd) is the same e.g. Reds Utd Eagles v Reds Utd Blues (different ordinals) --->
				
			<!--- Has this teamsheet previously been OK'd by a Silver or Skyblue security level person? 
			If so, the Club is not allowed to change the team sheet for this fixture --->
			<cfelseif HA IS "H" AND QValidFID.HomeTeamSheetOK >
					<!--- produces a warning line above the table because the cfoutput is immediate --->
					<cfoutput>
						<center>
						<span class="pix18boldred">No further updating of this Home team sheet is allowed by your club.</span><br />
						<span class="pix13boldred">If you believe this team sheet to be incomplete or inaccurate then please contact your Registration Secretary.</span>
						</center>
					</cfoutput>
			<cfelseif HA IS "A" AND QValidFID.AwayTeamSheetOK >
					<!--- produces a warning line above the table because the cfoutput is immediate --->
					<cfoutput>
						<center>
						<span class="pix18boldred">No further updating of this Away team sheet is allowed by your club.</span><br />
						<span class="pix13boldred">If you believe this team sheet to be incomplete or inaccurate then please contact your Registration Secretary.</span>
						</center>
					</cfoutput>
			<cfelse>
				<!--- For Yellow security, Goals & Ref Marks can also be entered if neither team has been prevented --->
				<cfif HA IS "H" AND QValidFID.HomeTeamSheetOK>
				<cfelseif HA IS "A" AND QValidFID.AwayTeamSheetOK>
				<cfelse>
					<tr>
						<td align="center"colspan="#NoOfCols#">
							<table align="center"  border="1" cellpadding="8" cellspacing="0" bgcolor="beige">
								<tr>
								<cfif SuppressScorelineEntry >
									<td align="left" colspan="5">
									<span class="pix13boldnavy"> #QTeamName.TeamName1# #QTeamName.OrdinalName1# </span><span class="pix13bold"> #QTeamName.HomeGoals# </span><span class="pix13boldnavy"> v </span><span class="pix13bold"> #QTeamName.AwayGoals# </span><span class="pix13boldnavy"> #QTeamName.TeamName2# #QTeamName.OrdinalName2# </span>
									<br><span class="pix9">updating of the score has been suppressed by the league</span>
									</td>
								<cfelseif QFixtureDate.MatchNumber GT 0 >
									<td align="left" colspan="5">
									<span class="pix13boldnavy"> #QTeamName.TeamName1# #QTeamName.OrdinalName1# </span><span class="pix13bold"> #QTeamName.HomeGoals# </span><span class="pix13boldnavy"> v </span><span class="pix13bold"> #QTeamName.AwayGoals# </span><span class="pix13boldnavy"> #QTeamName.TeamName2# #QTeamName.OrdinalName2# </span>
									<br><span class="pix9">The match number is #QFixtureDate.MatchNumber# and you are not allowed<br>to enter the score
									for a cup game with a match number.</span>
									</td>
								<!---
								A=awarded away win, 
								D=awarded draw, 
								H=awarded home win, 
								U=home win on penalties, 
								V=away win on penalties, 
								P=Postponed, 
								Q=Abandoned, 
								W=Void, 
								T=TEMP fixture hidden
								--->			
								<cfelseif ListFind("A,D,H,U,V,P,Q,W,T",QFixtureDate.Result)>
									<cfif ListFind("A,D,H",QFixtureDate.Result)>
										<cfset ExplanationText = "Awarded">
									<cfelseif ListFind("U,V",QFixtureDate.Result)>
										<cfset ExplanationText = "Decided on Penalties">
									<cfelseif ListFind("P",QFixtureDate.Result)>
										<cfset ExplanationText = "Postponed">
									<cfelseif ListFind("Q",QFixtureDate.Result)>
										<cfset ExplanationText = "Abandoned">
									<cfelseif ListFind("W",QFixtureDate.Result)>
										<cfset ExplanationText = "Void">
									<cfelseif ListFind("T",QFixtureDate.Result)>
										<cfset ExplanationText = "TEMP">
									</cfif>
									<td align="left" colspan="5">
									<span class="pix13boldnavy"> #QTeamName.TeamName1# #QTeamName.OrdinalName1# v #QTeamName.TeamName2# #QTeamName.OrdinalName2# </span>
									<br><span class="pix9">You are not allowed<br>to enter a score
									for this #ExplanationText# game.</span>
									</td>
								<cfelse>
									<td align="left" ><span class="pix13boldnavy">#QTeamName.TeamName1# #QTeamName.OrdinalName1#</span></td>
									<td align="left" ><span class="pix9">Goals</span><br /><cfinput type="Text" name="HomeGoals" value="#QTeamName.HomeGoals#" message="Home goals invalid" validate="integer" required="No" size="1" maxlength="2"></td>
									<td align="center">
										<span class="pix13boldnavy">v</span>
									</td>
									<td align="left" ><span class="pix13boldnavy">#QTeamName.TeamName2# #QTeamName.OrdinalName2#</span></td>
									<td align="left" ><span class="pix9">Goals</span><br /><cfinput type="Text" name="AwayGoals" value="#QTeamName.AwayGoals#" message="Away goals invalid" validate="integer" required="No" size="1" maxlength="2"></td>
								</cfif>
								
									<cflock scope="session" timeout="10" type="readonly">
										<cfset request.RefereeLowMarkWarning = session.RefereeLowMarkWarning >
										<cfset request.RefereeMarkMustBeEntered = session.RefereeMarkMustBeEntered > 
									</cflock>		
								
									<cfset MaxMarks = IIF( QLeagueCode.RefMarksOutOfHundred IS "Yes", 100, 10 ) >

									<!---  <cfif NOT SuppressRedYellowCardsEntry AND ExternalTokenStart IS 0 > not an External Competition --->
										<td align="center" bgcolor="silver">
										<cfif request.RefereeMarkMustBeEntered IS 1>
											<table><tr><td bgcolor="white"><span class="pix10boldred"> You must enter the marks for the referee </span></td></tr></table>
										</cfif>
										<span class="pix9">Marks out of #MaxMarks#</span>
										<br />
										<cfif HA IS "H">
											<cfinput name="RefereeMarksH" type="text" value="#QTeamName.RefereeMarksH#" size="1" maxlength="3" range="0,#MaxMarks#" required="no" message="Marks invalid. Must be 0 to #MaxMarks#." validate="integer">
										<cfelseif HA IS "A">
											<cfinput name="RefereeMarksA" type="text" value="#QTeamName.RefereeMarksA#" size="1" maxlength="3" range="0,#MaxMarks#" required="no" message="Marks invalid. Must be 0 to #MaxMarks#." validate="integer">
										</cfif>
										<br />
										<span class="pix9">awarded to the referee: #QTeamName.RefsName# 
										
										<cfif request.RefereeLowMarkWarning GT 0>
											<strong><br>Where a mark of #request.RefereeLowMarkWarning# or less is given you must<br>submit a written explanation to the League</strong>
										</cfif>
										</td>
									<!--- </cfif> --->
									<cfif HA IS "H">
										<td align="center" bgcolor="black"><span class="pix9boldwhite">Match Officials</span>
										<br />
										<cfinput name="MatchOfficialsExpenses" type="text" value="#QTeamName.MatchOfficialsExpenses#" size="3" maxlength="6" >
										<br />
										<span class="pix9boldwhite">Expenses</span></td>
									</cfif>
									<cfif HA IS "A">
										<td align="center" bgcolor="silver"><span class="pix9">Marks out of 100</span>
										<br />
										<cfinput name="HospitalityMarks" type="text" value="#QTeamName.HospitalityMarks#" size="1" maxlength="3" range="0,100" required="no" message="Marks invalid. Must be 0 to 100." validate="integer">
										<br />
										<span class="pix9">awarded for hospitality</span></td>
									</cfif>
									<!--- Sportsmanship Marks --->
									<cfif ClubsCanInputSportsmanshipMarks IS 1 AND HA IS "A"> <!--- Away team can award sportsmanship marks for Home Team --->
										<cfif request.SportsmanshipMarksOutOfHundred IS "1" >
											<td align="center" bgcolor="gray"><span class="pix9boldwhite">Marks out of 100</span>
											<br />
											<cfinput name="HomeSportsmanshipMarks" type="text" value="#QTeamName.HomeSportsmanshipMarks#" size="1" maxlength="3" range="0,100" required="no" message="Marks invalid. Must be 0 to 100." validate="integer">
										<cfelse>
											<td align="center" bgcolor="gray"><span class="pix9boldwhite">Marks out of 10</span>
											<br />
											<cfinput name="HomeSportsmanshipMarks" type="text" value="#QTeamName.HomeSportsmanshipMarks#" size="1" maxlength="3" range="0,10" required="no" message="Marks invalid. Must be 0 to 10." validate="integer">
										</cfif>
										<br />
										<span class="pix9boldwhite">Home team's Sportsmanship</span></td>
									</cfif>
									<cfif ClubsCanInputSportsmanshipMarks IS 1 AND HA IS "H"> <!--- Home team can award sportsmanship marks for Away Team --->
										<cfif request.SportsmanshipMarksOutOfHundred IS "1" >
											<td align="center" bgcolor="gray"><span class="pix9boldwhite">Marks out of 100</span>
											<br />
											<cfinput name="AwaySportsmanshipMarks" type="text" value="#QTeamName.AwaySportsmanshipMarks#" size="1" maxlength="3" range="0,100" required="no" message="Marks invalid. Must be 0 to 100." validate="integer">
										<cfelse>
											<td align="center" bgcolor="gray"><span class="pix9boldwhite">Marks out of 10</span>
											<br />
											<cfinput name="AwaySportsmanshipMarks" type="text" value="#QTeamName.AwaySportsmanshipMarks#" size="1" maxlength="3" range="0,10" required="no" message="Marks invalid. Must be 0 to 10." validate="integer">
										</cfif>	
										<br />
										<span class="pix9boldwhite">Away team's Sportsmanship</span></td>
									</cfif>
									
								</tr>
								<cfif SuppressTeamCommentsEntry IS '1'> <!--- suppressed --->
								<cfelse>
									<tr>
										<cfif HA IS "H" AND Len(Trim(QTeamName.HomeTeamNotes)) IS 0 >
											<td align="left" colspan="7"><span class="pix10navy">Home team's comments (max 255 chars)<br></span><textarea name="HomeTeamNotes" cols="80" rows="2" wrap="virtual">#ThisText#</textarea></td>
										<cfelseif HA IS "H" AND Len(Trim(QTeamName.HomeTeamNotes)) GT 0 >
											<td align="left" colspan="7"><span class="pix10navy">Home team's comments (max 255 chars)<br></span><textarea name="HomeTeamNotes" cols="80" rows="2" wrap="virtual">#QTeamName.HomeTeamNotes#</textarea></td>
										<cfelseif HA IS "A" AND Len(Trim(QTeamName.AwayTeamNotes)) IS 0 >
											<td align="left" colspan="7"><span class="pix10navy">Away team's comments (max 255 chars)<br></span><textarea name="AwayTeamNotes" cols="80" rows="2" wrap="virtual">#ThisText#</textarea></td>
										<cfelseif HA IS "A" AND Len(Trim(QTeamName.AwayTeamNotes)) GT 0 >
											<td align="left" colspan="7"><span class="pix10navy">Away team's comments (max 255 chars)<br></span><textarea name="AwayTeamNotes" cols="80" rows="2" wrap="virtual">#QTeamName.AwayTeamNotes#</textarea></td>
										</cfif>
									</tr>
								</cfif>
							</table>
						</td>
					</tr>
				</cfif>
				<tr>
					<td height="30" colspan="6" align="center" ><input name="OK_Button" type="submit" value="OK"></td>
				</tr>
			</cfif>
		</cfif>	
					<tr>
						<td align="left" colspan="2"><span class="pix10">Maximums allowed:<br>#NumberFormat(MaxAllowedOnTeamSheet,'99')# players selected<br>#NumberFormat(StartingPlayerCount,'99')# players starting<br>#NumberFormat(SubsUsedPlayerCount,'99')# substitutes playing<br>#NumberFormat(SubsNotUsedPlayerCount,'99')# substitutes not playing</span></td>
					</tr>
	
	</table>
	</cfoutput>
</cfform>
<cflock scope="session" timeout="10" type="exclusive">
	<cfset session.DisplayAA = ThisDisplayAA >
</cflock>
<script language="JavaScript" type="text/javascript" src="wz_tooltip.js"></script>
