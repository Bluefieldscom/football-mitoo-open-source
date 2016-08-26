<cfif ListFind("Silver,Skyblue,Yellow,White",request.SecurityLevel) >
<cfelse>
	<cfoutput>
		<cflocation url="http://www.mitoo.com/beta?league&leaguecode=#request.CurrentLeagueCodePrefix#&nonko=1" addtoken="no">
	</cfoutput>
	<cfabort>
</cfif>

<!--- include toolbar.cfm--->
<cfinclude template="InclBegin.cfm">
<!--- Check to see if this "Division" is a Cup or Trophy i.e. a Knock-Out Competition --->
<CFPARAM name="KO" default="No">

<cfset ToolTipText = "Look at the future scheduled dates for these two teams">

<cfinclude template="queries/qry_QKnockOut.cfm">

<cfif Find( "MultipleMatches", QKnockOut.Notes ) >
	<!--- teams can play more than once on any single date --->
	<cfset MultipleMatches = "Yes">
	<span class="pix10boldnavy">Teams are allowed to play more than one game per day in this competition.</span>
<cfelse>		
	<cfset MultipleMatches = "No">
</cfif>

<cfif Left(QKnockOut.Notes,2) IS "P1" >
	<cfset PlayOne = "Yes">
<cfelse>
	<cfset PlayOne = "No">
</cfif>
	
<cfif Left(QKnockOut.Notes,2) IS "P3" >
	<cfset PlayThree = "Yes">
<cfelse>
	<cfset PlayThree = "No">
</cfif>

<cfif Left(QKnockOut.Notes,2) IS "P4" >
	<cfset PlayFour = "Yes">
<cfelse>
	<cfset PlayFour = "No">
</cfif>

<cfif Left(QKnockOut.Notes,2) IS "KO" >
	<cfset KO = "Yes">
	<cfset ThisDivisionID = DivisionID >
	<cfinclude template="queries/qry_QNewLeagueTable.cfm">
	<cfif QNewLeagueTable.RecordCount IS 0 >
		<cfinclude template="RefreshLeagueTable.cfm">
		<cfinclude template="queries/qry_QNewLeagueTable.cfm">
	</cfif>
	<cfinclude template="queries/qry_QNeverDefeated.cfm">
	<cfset NeverDefeatedList = ValueList(QNeverDefeated.ConstitutionID)>
	<cfif QNeverDefeated.RecordCount IS 0 >
		<cfset NeverDefeatedList = ListAppend(NeverDefeatedList,0)>
	</cfif>
<cfelse>
	<cfset KO = "No">
</cfif>
<cfinclude template="queries/qry_QMatches.cfm">

<cfset ListOfFixturePitchAvailabilityIDs = "">
<!---
<cfset ListOfHomeTeamIDs = "">
<cfset ListOfHomeOrdinalIDs = "">
--->


<cfset ListOfHomeIDs = "">
<cfset ListOfAwayIDs = "">
<cfif QMatches.RecordCount IS "0">
	<span class="pix13bold">No unscheduled matches</span>
<cfelse>

	<cflock scope="session" timeout="10" type="readonly">
		<cfif StructKeyExists(session, "CurrentDate") >
			<cfset request.CurrentDate = session.CurrentDate >
		<cfelse>
			<cfset request.CurrentDate = Now() >
		</cfif>
		
		<cfif request.CurrentDate GT SeasonEndDate >
			<cfset request.CurrentDate = SeasonEndDate >
		</cfif>
	</cflock>
	
	<cfset request.ChangeDate = "No">
	<cfif ListFind("Silver,Skyblue",request.SecurityLevel) AND StructKeyExists(url, "ChangeDate") >
		<cfif url.ChangeDate IS "Yes">
			<cfset request.ChangeDate = "Yes">
		</cfif>
	</cfif>
	
	<cfinclude template="queries/qry_GetKORnd.cfm">
	
	<!--- Load all the Unscheduled Matches into arrays --->
	<cfset ArrHomeString = ArrayNew(2)>
	<cfset ArrAwayString = ArrayNew(2)>
	<cfoutput query="QMatches">
		<cfif HomeOrdinal IS "">						
			<cfset HomeString = "#HomeTeam#">				
		<cfelse>				
			<cfset HomeString = "#HomeTeam# #HomeOrdinal#">				
		</cfif>
		<cfset RetValue = ArrayAppend(ArrHomeString[1],HomeString)>
		<cfset RetValue = ArrayAppend(ArrHomeString[2],HomeGuest)>
		<cfset RetValue = ArrayAppend(ArrHomeString[3],HomeTeamID)>
		<cfif PlayOne IS "Yes" OR PlayThree IS "Yes" OR PlayFour IS "Yes">
			<cfset RetValue = ArrayAppend(ArrHomeString[4],HomeCount)>
		</cfif>
		<cfset RetValue = ArrayAppend(ArrHomeString[5],HomeMatchNo)>
		<cfset RetValue = ArrayAppend(ArrHomeString[6],HomeTeamPlusOrdinal)>
		<cfset RetValue = ArrayAppend(ArrHomeString[7],HomeOrdinalID)>

		
		<cfif AwayOrdinal IS "">						
			<cfset AwayString = "#AwayTeam#">				
		<cfelse>				
			<cfset AwayString = "#AwayTeam# #AwayOrdinal#">				
		</cfif>
		<cfset RetValue = ArrayAppend(ArrAwayString[1],AwayString)>
		<cfset RetValue = ArrayAppend(ArrAwayString[2],AwayGuest)>      
		<cfset RetValue = ArrayAppend(ArrAwayString[3],AwayTeamID)>
		<cfif PlayOne IS "Yes" OR PlayThree IS "Yes" OR PlayFour IS "Yes">
			<cfset RetValue = ArrayAppend(ArrAwayString[4],AwayCount)>
		</cfif>
		<cfset RetValue = ArrayAppend(ArrAwayString[5],AwayMatchNo)>
		<cfset RetValue = ArrayAppend(ArrAwayString[6],AwayTeamPlusOrdinal)>
		<cfset RetValue = ArrayAppend(ArrAwayString[7],AwayOrdinalID)>
<!---
		<cfset ListOfHomeTeamIDs = ListAppend(ListOfHomeTeamIDs,#HomeTeamID#)>	
		<cfset ListOfHomeOrdinalIDs = ListAppend(ListOfHomeOrdinalIDs,#HomeOrdinalID#)>	
--->
		<cfset ListOfHomeIDs = ListAppend(ListOfHomeIDs,#HomeID#)>	
		<cfset ListOfAwayIDs = ListAppend(ListOfAwayIDs,#AwayID#)>	
	</cfoutput>
	
	<cfset UnschedCount = QMatches.RecordCount>
	<cfset NoOfCols = 2>
	<cfif UnschedCount Mod NoOfCols IS 0 >
		<cfset NoOfUMPerCol = UnschedCount / NoOfCols>
	<cfelse>
		<cfset NoOfUMPerCol = Round((UnschedCount / NoOfCols)+ 0.5) >
	</cfif>
	
	<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
		<cfinclude template="queries/qry_QPlayingToday.cfm">
		<cfinclude template="queries/qry_QFreeToday.cfm">
		
		<!---
		<cfoutput>#QPlayingToday.RecordCount# teams are busy today ( #request.CurrentDate# )</cfoutput><BR>
		<cfoutput query="QPlayingToday">
			<span class="pix10">#PlayingToday# - #TeamName# #OrdinalName#<BR></span>
		</cfoutput>
		--->
		<cfset PlayingTodayList = ValueList(QPlayingToday.PlayingToday)>
		<cfset FreeTodayList = ValueList(QFreeToday.FreeToday)>
	</cfif>
	
	<table width="100%" border="0" cellspacing="0" cellpadding="5">
	
		<FORM NAME="UnschedForm" ACTION="UnschedAction.cfm" METHOD="post"  >
			<cfif ListFind("Silver,Skyblue",request.SecurityLevel) AND request.ChangeDate IS "Yes">
					<SCRIPT type="text/javascript" src="CalendarPopup.js"></SCRIPT>	
					<!--- season dates - less one for start, plus one for end - this info used in calendar to block non-season dates! --->
					<cfset LOdate = DateAdd('D', -1, SeasonStartDate) >
					<cfset HIdate = DateAdd('D',  1, SeasonEndDate) >
					<SCRIPT type="text/javascript">
						// note date type on disable calls
						<cfoutput>
						var cal1 = new CalendarPopup(); 
						cal1.addDisabledDates(null, '#LSDateFormat(LOdate, "mmm dd, yyyy")#'); 
						cal1.addDisabledDates('#LSDateFormat(HIdate, "mmm dd, yyyy")#', null);
						cal1.offsetX = 150;
						cal1.offsetY = -150;
						</cfoutput>
					</SCRIPT>
			</cfif>
			<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
				<input name="VenueAndPitchAvailable" type="hidden" value="<cfoutput>#VenueAndPitchAvailable#</cfoutput>" >
			
			
			
							
				<tr>
					<td colspan="<cfoutput>#NoOfCols#</cfoutput>" align="CENTER">
						<table border="0" align="center" cellpadding="1" cellspacing="1">
							<cfif request.ChangeDate IS "No">
								<input name="FixtDate" type="hidden" value="<cfoutput>#request.CurrentDate#</cfoutput>" >
								<tr>
									<td align="center">
										<cfoutput>
										<span class="pix18bold"><a href="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(request.CurrentDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#">#DateFormat(request.CurrentDate, "DDDD, DD MMMM YYYY")#</a></span>
										</cfoutput>
									</td>
								</tr>
								<tr>
									<td align="center">
										<span class="pix13boldred">1. Please <a href="<cfoutput>Unsched.cfm?TblName=Matches&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#&ChangeDate=Yes</cfoutput>"><u>click here</u></a> to change this fixture date if necessary</span>
									</td>
								</tr>
								<cfif KO IS "Yes" >
										<tr>
											<td align="center">
												<table border="0" cellspacing="1" cellpadding="1">
													<tr>
														<!--- allow the user to choose a Knock Out Round from a dropdown list when adding a fixture --->
														<td align="center"><span class="pix10">KO Round<BR><select name="KORoundID" size="1"><cfoutput query="GetKORnd" ><OPTION VALUE="#ID#">#LongCol#</OPTION></cfoutput></select></span></td>
													</tr>
												</table>	
											</td>
										</tr>
								<cfelse>
									<input type="HIDDEN" name="KORoundID" value="<cfoutput>#GetKORnd.ID#</cfoutput>">
								</cfif>
							</cfif>
							<cfif request.ChangeDate IS "Yes">
								<tr>
									<td height="30" align="center">
										<cfoutput><input name="datebox" type="text" size="30" readonly="true" value="#DateFormat(request.CurrentDate, "DDDD, DD MMMM YYYY")#" ></cfoutput>
									</td>
								</tr>

								<tr>
									<td height="30" align="center">
										<cfoutput><span class="pix13">Please <a href="" onClick="cal1.select(UnschedForm.datebox,'anchor1','EE, dd MMM yyyy'); return false;"  name="anchor1" id="anchor1"><u>click here</u></a> to change the fixture date </span></cfoutput>
									</td>
								</tr>

								<tr>
									<td align="CENTER">
										<input type="Submit" name="Operation" value="Confirm">
									</td>
								</tr>
							</cfif>
							<cfif request.ChangeDate IS "No">
								<tr>
									<td ><span class="pix13boldred">2. Then choose a KO Round if it's a cup match<br> 3. Then tick boxes to choose games <br>4. Then click on one of the Add Ticked buttons at the bottom</span></td>
								</tr>
							</cfif>
						</table>
					 </td>
				</tr>
			</cfif>
			<cfoutput>
				<input type="Hidden" name="TblName" value="MatchGroup">
				<input type="Hidden" name="LeagueCode" value="#LeagueCode#">
				<input type="Hidden" name="DivisionID" value="#DivisionID#">
			</cfoutput>
			
			<cfif NOT (ListFind("Silver,Skyblue",request.SecurityLevel) AND request.ChangeDate IS "Yes") >
				<tr>
					<cfoutput>
						<td colspan="#NoOfCols#" align="CENTER"><span class="pix13bold">
							#QMatches.RecordCount# in list
							<cfif PlayOne IS "Yes"> - Teams must play each other <i>once</i> only</cfif>				
							<cfif PlayThree IS "Yes"> - Teams must play each other <i>three</i> times</cfif>
							<cfif PlayFour IS "Yes"> - Teams must play each other <i>four</i> times</cfif>
							</span>
						</td>
					</cfoutput>
				</tr>
			</cfif>
			
			
			<cfif request.ChangeDate IS "No">
				<td height="11"><tr valign="TOP">
					<cfoutput>
					<cfloop index="ColN" from="1" to="#NoOfCols#" step="1" >
						<cfset xxx=((#ColN#-1) * #NoOfUMPerCol#)+1>
						<cfset yyy=MIN((#ColN# * #NoOfUMPerCol#),#UnschedCount#)>
						
						<td>
							<cfset ThisHomeString = "">
							
							<cfloop index="RowN" from="#xxx#" to="#yyy#" step="1">
							<!--- a little bit of space and a line between groups of Home Teams --->
									
										
									
										<cfif ThisHomeString IS NOT ArrHomeString[1][RowN]>
											<cfset ThisHomeString = ArrHomeString[1][RowN]>
											<cfset RedXWarning = "No">
	<!---
														******************************************************************************
														*                                  30 day view                               *
														******************************************************************************
	--->
											
											
											<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
												<HR>
												
													<cfset ThisHomeID = ListGetAt(ListOfHomeIDs, RowN ) >
													<cfset ThisAwayID = ListGetAt(ListOfAwayIDs, RowN ) >
													<cfset StartDate = DateAdd('D', -15, request.CurrentDate)>
													<cfset SDate = DateAdd('D', -2, request.CurrentDate)>
													<cfset EndDate   = DateAdd('D',  15, request.CurrentDate)>
													<cfset EDate   = DateAdd('D',  2, request.CurrentDate)>
													<cfinclude template="queries/qry_QVenueSequence.cfm">
													<cfset IDList = ValueList(QVenueSequence.ID)>
													<cfinclude template="queries/qry_QVenueSequence1.cfm">
													<cfset PrevDateList = ValueList(QVenueSequence1.FixtureDate)>
													<cfset PrevDate = ListLast(PrevDateList) >
													<cfinclude template="queries/qry_QVenueSequence2.cfm">
													<cfinclude template="queries/qry_QVenueSequence3.cfm">
													<cfset NextDateList = ValueList(QVenueSequence3.FixtureDate)>	
													<cfset NextDate = ListFirst(NextDateList) >
													<table border="1" cellpadding="1" cellspacing="1">

													<cfif VenueAndPitchAvailable IS "Yes" AND UCase(#ArrHomeString[2][RowN]#) IS NOT "GUEST">
														<tr>
															<cfloop query="QVenueSequence1">
																<td>&nbsp;</td>
															</cfloop>
															<cfset ThisTeamID = ArrHomeString[3][RowN] >
															<cfset ThisOrdinalID = ArrHomeString[7][RowN] >
															<cfset ThisDate = DateFormat(request.CurrentDate, 'YYYY-MM-DD')>
															<cfinclude template="queries/qry_FixturePitchAvailability.cfm">
															<cfif FixturePitchAvailability.RecordCount IS 0>
																<!--- OK, let's use the Normal Venue if it exists as a default --->
																<cfinclude template="queries/qry_DefaultVenue.cfm">		  
																<cfif QDefaultVenue.RecordCount IS 0>
																	<cfset RedXWarning = "Yes">
																	<td align="center" bgcolor="white"><span class="pix10boldred">No Pitch</span></td>
																<cfelseif QDefaultVenue.RecordCount IS 1>
																	<cfset RedXWarning = "No">
																	<td align="center" bgcolor="lightgreen"><span class="pix10boldred">assuming<br>Normal Venue<br></span><span class="pix10boldnavy">#QDefaultVenue.longcol#</span></td>
																<cfelse>
																	Error 34288 in Unsched.cfm - aborting
																	<cfabort>
																</cfif>
																
																<cfloop query="QVenueSequence3">
																	<td>&nbsp;</td>
																</cfloop>
															<cfelse>
																<cfset VenueNameList = ValueList(FixturePitchAvailability.VenueName)>
																<cfset PitchNameList = ValueList(FixturePitchAvailability.PitchName)>
																<cfset PitchStatusList = ValueList(FixturePitchAvailability.PitchStatus)>
																<cfloop index="i" from="1" to="1" step="1">
																	<cfif Trim(ListGetAt(PitchStatusList,i)) IS "OK" >
																		<cfset ThisClass = "pix10boldnavy">
																	<cfelse>
																		<cfset ThisClass = "pix10boldred">
																	</cfif>
																	<cfif Trim(ListGetAt(PitchNameList,i)) IS "1">
																		<cfset PitchNoString = "">
																	<cfelse>
																		<cfset PitchNoString = "(#Trim(ListGetAt(PitchNameList,i))#)">
																	</cfif>
																	<td align="center" bgcolor="white"><span class="#ThisClass#">#ListGetAt(PitchStatusList,i)#<br /></span><span class="pix10boldnavy">#ListGetAt(VenueNameList,i)##PitchNoString#</span></td>
																	<cfloop query="QVenueSequence3">
																		<td>&nbsp;</td>
																	</cfloop>
																</cfloop>
																<cfloop index="i" from="2" to="#FixturePitchAvailability.RecordCount#" step="1">
																	<cfif Trim(ListGetAt(PitchStatusList,i)) IS "OK" >
																		<cfset ThisClass = "pix10boldnavy">
																	<cfelse>
																		<cfset ThisClass = "pix10boldred">
																	</cfif>
																	<cfif Trim(ListGetAt(PitchNameList,i)) IS "1">
																		<cfset PitchNoString = "">
																	<cfelse>
																		<cfset PitchNoString = "(#Trim(ListGetAt(PitchNameList,i))#)">
																	</cfif>
																	<tr>
																		<cfloop query="QVenueSequence1">
																			<td>&nbsp;</td>
																		</cfloop>
																		<td align="center" bgcolor="white"><span class="#ThisClass#">#ListGetAt(PitchStatusList,i)#<br /></span><span class="pix10boldnavy">#ListGetAt(VenueNameList,i)##PitchNoString#</span></td>
																		<cfloop query="QVenueSequence3">
																			<td>&nbsp;</td>
																		</cfloop>
																	</tr>
																</cfloop>
																
																<!--- if none of the pitches is OK don't allow fixtures --->
																<cfset OKStatusCounter = 0 >
																<cfloop index="i" from="1" to="#FixturePitchAvailability.RecordCount#" step="1">
																	<cfif Trim(ListGetAt(PitchStatusList,i)) IS "OK" >
																		<cfset OKStatusCounter = OKStatusCounter + 1 >
																	</cfif>
																</cfloop>
																<cfif OKStatusCounter IS 0 >
																	<cfset RedXWarning = "Yes">
																</cfif>
																
															</cfif>
														</tr>
													</cfif>
													
														<tr>
															<cfloop query="QVenueSequence1">
																	<cfif Result IS "P">
																		<cfset ResultText = "Postponed">
																	<cfelseif Result IS "H">
																		<cfset ResultText = "Home Win was awarded">
																	<cfelseif Result IS "A">
																		<cfset ResultText = "Away Win was awarded">
																	<cfelseif Result IS "D">
																		<cfset ResultText = "Draw was awarded">
																	<cfelseif Result IS "Q">
																		<cfset ResultText = "Abandoned">
																	<cfelseif Result IS "W">
																		<cfset ResultText = "Void">
																	<cfelseif Result IS "T">
																		<cfset ResultText = "TEMP">
																	<cfelseif Result IS "U">
																		<cfset ResultText = "Home Win on Penalties">
																	<cfelseif Result IS "V">
																		<cfset ResultText = "Away Win on Penalties">
																	<cfelse>
																		<cfset ResultText = "">
																	</cfif>	
																	<cfif IsNumeric(HomeGoals) AND IsNumeric(AwayGoals)>
																		<cfset ScoreText = "#HomeGoals# - #AwayGoals#">
																	<cfelse>
																		<cfset ScoreText = "">
																	</cfif>															
																	<cfif Venue IS "H">
																		<td width="80" height="80" align="center" valign="top" bgcolor="white"><table border="0" align="center" cellpadding="2" cellspacing="0" <cfif ResultText IS "TEMP">bgcolor="aqua"</cfif>><tr><td align="center"><span class="pix10boldnavy">#ScoreText# #ResultText#</span></td></tr></table><span class="pix10">#DateFormat(FixtureDate,'DDDD')#<BR>#DateFormat(FixtureDate,'DD MMMM')#<BR>#CompetitionCode#</span><BR><span class="pix13bold">H</span><BR><span class="pix10">#TeamName# #OrdinalName#</span></td>
																	<cfelse>
																		<td width="80" height="80" align="center" valign="top" bgcolor="white"><table border="0" align="center" cellpadding="2" cellspacing="0" <cfif ResultText IS "TEMP">bgcolor="aqua"</cfif>><tr><td align="center"><span class="pix10boldnavy">#ScoreText# #ResultText#</span></td></tr></table><span class="pix10">#DateFormat(FixtureDate,'DDDD')#<BR>#DateFormat(FixtureDate,'DD MMMM')#<BR>#CompetitionCode#</span><BR><span class="pix13bold">A</span><BR><span class="pix10">#TeamName# #OrdinalName#</span></td>
																	</cfif>
															</cfloop>
															<cfif QVenueSequence2.RecordCount IS 0>
																<cfif IsDate(PrevDate) AND DateDiff('D', PrevDate, request.CurrentDate) LE 2 >
																	<td width="80" height="80" align="center" valign="top" bgcolor="silver"><span class="pix10">#DateFormat(request.CurrentDate,'DDDD')#<BR>#DateFormat(request.CurrentDate,'DD MMMM')#<BR>&nbsp;</span><BR><span class="pix13boldnavy">H</span><span class="pix10boldred"><BR>Less than 2 days since last game</span></td>
																<cfelseif IsDate(NextDate) AND DateDiff('D', request.CurrentDate, NextDate) LE 2 >
																	<td width="80" height="80" align="center" valign="top" bgcolor="silver"><span class="pix10">#DateFormat(request.CurrentDate,'DDDD')#<BR>#DateFormat(request.CurrentDate,'DD MMMM')#<BR>&nbsp;</span><BR><span class="pix13boldnavy">H</span><span class="pix10boldred"><BR>Less than 2 days until next game</span></td>
																<cfelse>
																	<td width="80" height="80" align="center" valign="top" bgcolor="silver"><span class="pix10">#DateFormat(request.CurrentDate,'DDDD')#<BR>#DateFormat(request.CurrentDate,'DD MMMM')#<BR>&nbsp;</span><BR><span class="pix13boldnavy">H</span></td>
																</cfif>
															<cfelse>
																<cfloop query="QVenueSequence2">
																	<cfif Result IS "P">
																		<cfset ResultText = "Postponed">
																	<cfelseif Result IS "H">
																		<cfset ResultText = "Home Win was awarded">
																	<cfelseif Result IS "A">
																		<cfset ResultText = "Away Win was awarded">
																	<cfelseif Result IS "D">
																		<cfset ResultText = "Draw was awarded">
																	<cfelseif Result IS "Q">
																		<cfset ResultText = "Abandoned">
																	<cfelseif Result IS "W">
																		<cfset ResultText = "Void">
																	<cfelseif Result IS "T">
																		<cfset ResultText = "TEMP">
																	<cfelseif Result IS "U">
																		<cfset ResultText = "Home Win on Penalties">
																	<cfelseif Result IS "V">
																		<cfset ResultText = "Away Win on Penalties">
																	<cfelse>
																		<cfset ResultText = "">
																	</cfif>	
																	<cfif IsNumeric(HomeGoals) AND IsNumeric(AwayGoals)>
																		<cfset ScoreText = "#HomeGoals# - #AwayGoals#">
																	<cfelse>
																		<cfset ScoreText = "">
																	</cfif>															
																	<cfif Venue IS "H">
																		<td width="80" height="80" align="center" valign="top" bgcolor="##F5F5F5"><table border="0" align="center" cellpadding="2" cellspacing="0" <cfif ResultText IS "TEMP">bgcolor="aqua"</cfif>><tr><td align="center"><span class="pix10boldnavy">#ScoreText# #ResultText#</span></td></tr></table><span class="pix10">#DateFormat(FixtureDate,'DDDD')#<BR>#DateFormat(FixtureDate,'DD MMMM')#<BR>#CompetitionCode#</span><BR><span class="pix13bold">H</span><BR><span class="pix10">#TeamName# #OrdinalName#</span></td>
																	<cfelse>
																		<td width="80" height="80" align="center" valign="top" bgcolor="##F5F5F5"><table border="0" align="center" cellpadding="2" cellspacing="0" <cfif ResultText IS "TEMP">bgcolor="aqua"</cfif>><tr><td align="center"><span class="pix10boldnavy">#ScoreText# #ResultText#</span></td></tr></table><span class="pix10">#DateFormat(FixtureDate,'DDDD')#<BR>#DateFormat(FixtureDate,'DD MMMM')#<BR>#CompetitionCode#</span><BR><span class="pix13bold">A</span><BR><span class="pix10">#TeamName# #OrdinalName#</span></td>
																	</cfif>
																</cfloop>
															</cfif>
															<cfloop query="QVenueSequence3">
																<cfif Result IS "P">
																	<cfset ResultText = "Postponed">
																<cfelseif Result IS "H">
																	<cfset ResultText = "Home Win was awarded">
																<cfelseif Result IS "A">
																	<cfset ResultText = "Away Win was awarded">
																<cfelseif Result IS "D">
																	<cfset ResultText = "Draw was awarded">
																<cfelseif Result IS "Q">
																	<cfset ResultText = "Abandoned">
																<cfelseif Result IS "W">
																	<cfset ResultText = "Void">
																<cfelseif Result IS "T">
																	<cfset ResultText = "TEMP">
																<cfelseif Result IS "U">
																	<cfset ResultText = "Home Win on Penalties">
																<cfelseif Result IS "V">
																	<cfset ResultText = "Away Win on Penalties">
																<cfelse>
																	<cfset ResultText = "">
																</cfif>	
																<cfif IsNumeric(HomeGoals) AND IsNumeric(AwayGoals)>
																	<cfset ScoreText = "#HomeGoals# - #AwayGoals#">
																<cfelse>
																	<cfset ScoreText = "">
																</cfif>															
																<cfif Venue IS "H">
																		<td width="80" height="80" align="center" valign="top" bgcolor="white"><table border="0" align="center" cellpadding="2" cellspacing="0" <cfif ResultText IS "TEMP">bgcolor="aqua"</cfif>><tr><td align="center"><span class="pix10boldnavy">#ScoreText# #ResultText#</span></td></tr></table><span class="pix10">#DateFormat(FixtureDate,'DDDD')#<BR>#DateFormat(FixtureDate,'DD MMMM')#<BR>#CompetitionCode#</span><BR><span class="pix13bold">H</span><BR><span class="pix10">#TeamName# #OrdinalName#</span></td>
																<cfelse>
																		<td width="80" height="80" align="center" valign="top" bgcolor="white"><table border="0" align="center" cellpadding="2" cellspacing="0" <cfif ResultText IS "TEMP">bgcolor="aqua"</cfif>><tr><td align="center"><span class="pix10boldnavy">#ScoreText# #ResultText#</span></td></tr></table><span class="pix10">#DateFormat(FixtureDate,'DDDD')#<BR>#DateFormat(FixtureDate,'DD MMMM')#<BR>#CompetitionCode#</span><BR><span class="pix13bold">A</span><BR><span class="pix10">#TeamName# #OrdinalName#</span></td>
																</cfif>
															</cfloop>
														</tr>

													</table>
<!---
<table bgcolor="silver"><tr><td valign="middle"><span class="pix10white">Temp? Yes</span></td><td valign="middle"><input name="P#RowN#" type="radio" value="1" checked ></td><td valign="middle"><span class="pix10white">No</span></td><td valign="middle"><input name="P#RowN#" type="radio" value="0" ></td></tr></table>
--->
											




											<cfelse>
												<HR>
											</cfif>
										</cfif>
									
	
								<table border="0" cellspacing="0" cellpadding="0" >
									<tr>

											<cfset Highlight = "No">
											<cfif request.fmTeamID IS ArrHomeString[3][RowN]>
												<cfset Highlight = "Yes">
											</cfif>
											<cfif request.fmTeamID IS ArrAwayString[3][RowN]>
												<cfset Highlight = "Yes">
											</cfif>
											<cfset SuppressLine = "No">
											<cfset TooManyMeetings = "No">
		
											<cfif PlayOne IS "Yes" >
												<cfif ArrHomeString[4][RowN] GT 1 >
													<cfset SuppressLine = "Yes">
												</cfif>
												<cfif (ArrHomeString[4][RowN] + ArrAwayString[4][RowN]) GT 0 >
													<cfset SuppressLine = "Yes">
												</cfif>
												<cfif (ArrHomeString[4][RowN] + ArrAwayString[4][RowN]) GT 1 >
													<cfset SuppressLine = "Yes">
													<cfset TooManyMeetings = "Yes">
												</cfif>
									
											</cfif>
											
											<cfif PlayThree IS "Yes" >
												<cfif ArrHomeString[4][RowN] GT 1 >
													<cfset SuppressLine = "Yes">
												</cfif>
												<cfif (ArrHomeString[4][RowN] + ArrAwayString[4][RowN]) GT 2 >
													<cfset SuppressLine = "Yes">
												</cfif>
												<cfif (ArrHomeString[4][RowN] + ArrAwayString[4][RowN]) GT 3 >
													<cfset SuppressLine = "Yes">
													<cfset TooManyMeetings = "Yes">
												</cfif>
									
											</cfif>
											<cfif PlayFour IS "Yes" >
												<cfif ArrHomeString[4][RowN] GT 1 >
													<cfset SuppressLine = "Yes">
												</cfif>
												<cfif (ArrHomeString[4][RowN] + ArrAwayString[4][RowN]) GT 4 >
													<cfset SuppressLine = "Yes">
													<cfset TooManyMeetings = "Yes">
												</cfif>
		
											</cfif>
										<td <cfif Highlight>class="bg_highlight"</cfif>>
										
										<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
										
											<cfif VenueAndPitchAvailable IS "Yes">
												<cfif UCase(#ArrHomeString[2][RowN]#) IS "GUEST" >
													<cfset ListOfFixturePitchAvailabilityIDs = ListAppend(ListOfFixturePitchAvailabilityIDs,0)>	
												<cfelse>
													<cfif FixturePitchAvailability.RecordCount IS 1>
														<cfset ListOfFixturePitchAvailabilityIDs = ListAppend(ListOfFixturePitchAvailabilityIDs,#FixturePitchAvailability.FPA_ID#)>	
													<cfelse>
														<cfset ListOfFixturePitchAvailabilityIDs = ListAppend(ListOfFixturePitchAvailabilityIDs,0)>	
													</cfif>
												</cfif>
											</cfif>			
										
											<cfif SuppressLine IS "No" >
												<!---
												<cfdump var="#PlayingTodayList#"><br />
												<cfdump var="#FreeTodayList#"><br />
												--->
												<cfif ListFind(FreeTodayList, ArrHomeString[6][RowN]) >
													<cfset HomeTeamFree = "Yes">
												<cfelse>
													<cfset HomeTeamFree = "No">
												</cfif>
												
												<cfif ListFind(PlayingTodayList, ArrHomeString[6][RowN]) >
													<cfset HomeTeamBusy = "Yes">
												<cfelse>
													<cfset HomeTeamBusy = "No">
												</cfif>
												<cfif MultipleMatches IS "Yes"><cfset HomeTeamBusy = "No"></cfif>
												
												<cfif ListFind(FreeTodayList, ArrAwayString[6][RowN]) >
													<cfset AwayTeamFree = "Yes">
												<cfelse>
													<cfset AwayTeamFree = "No">
												</cfif>
												
												<cfif ListFind(PlayingTodayList, ArrAwayString[6][RowN])>
													<cfset AwayTeamBusy = "Yes">
												<cfelse>
													<cfset AwayTeamBusy = "No">
												</cfif>
												<cfif MultipleMatches IS "Yes"><cfset AwayTeamBusy = "No"></cfif>
												
												<cfif HomeTeamBusy IS "Yes" OR AwayTeamBusy IS "Yes" OR HomeTeamFree IS "Yes" OR AwayTeamFree IS "Yes">
													<input name="R#RowN#" type="checkbox" disabled="true" value="0" >
												</cfif>
												<cfif HomeTeamBusy IS "No" AND AwayTeamBusy IS "No" AND HomeTeamFree IS "No" AND AwayTeamFree IS "No">
													<cfif RedXWarning IS "Yes"><span class="pix13boldred">X</span></cfif>
													<input name="R#RowN#" type="checkbox" >
													<cfif VenueAndPitchAvailable IS "Yes" AND UCase(#ArrHomeString[2][RowN]#) IS NOT "GUEST">
														<cfif FixturePitchAvailability.RecordCount IS 0>
															<cfif QDefaultVenue.RecordCount IS 1>
																<input type="Hidden" name="V#RowN#" value="#ThisTeamID# #ThisOrdinalID# #QDefaultVenue.VID# #QDefaultVenue.PNID# 1 #ThisDate# #request.filter# ">
															</cfif>
														</cfif>	
													</cfif>
												</cfif>
												
												<cfif HomeTeamFree IS "Yes" >
													<span class="bg_pink">
												</cfif>	
												<cfif UCase(#ArrHomeString[2][RowN]#) IS "GUEST">
													<cfif HomeTeamBusy IS "Yes">
														<span class="pix13bolditalic"><s>#ArrHomeString[1][RowN]#</s></span>
													<cfelse>
														<span class="pix13bolditalic">#ArrHomeString[1][RowN]#</span>
													</cfif>
												<cfelse>
													<cfif HomeTeamBusy IS "Yes">
														<span class="pix13bold"><s>#ArrHomeString[1][RowN]#</s></span>
													<cfelse>
														<span class="pix13bold">#ArrHomeString[1][RowN]#</span>
													</cfif>
												</cfif>
												<cfif HomeTeamFree IS "Yes" >
													<img src="gif/unavailable.gif"><!--- FREE DAY--->
													</span>
												</cfif>
													
												<span class="pix13">v</span>
												
												<cfif AwayTeamFree IS "Yes" >
													<span class="bg_pink">
												</cfif>	
												<cfif UCase(#ArrAwayString[2][RowN]#) IS "GUEST">
													<cfif AwayTeamBusy IS "Yes">
														<span class="pix13bolditalic"><s>#ArrAwayString[1][RowN]#</s></span>
													<cfelse>
														<span class="pix13bolditalic">#ArrAwayString[1][RowN]#</span>
													</cfif>
												<cfelse>
													<cfif AwayTeamBusy IS "Yes">
														<span class="pix13bold"><s>#ArrAwayString[1][RowN]#</s></span>
													<cfelse>
														<span class="pix13bold">#ArrAwayString[1][RowN]#</span>
													</cfif>
												</cfif>
												<cfif AwayTeamFree IS "Yes" >
													<img src="gif/unavailable.gif"><!--- FREE DAY--->
													</span>
												</cfif>
												
												
												<cfif KO IS "No" AND HomeTeamBusy IS "No" AND AwayTeamBusy IS "No">
												
												<cfset request.InList = "#ListGetAt(ListOfHomeIDs, RowN )#,#ListGetAt(ListOfAwayIDs, RowN )#" >
													<cfinclude template="queries/qry_QTeamsMeet.cfm">
													<cfloop query="QTeamsMeet">
														<cfset NoOfDays = ROUND(Evaluate((DateDiff("h", FixtureDate, request.CurrentDate) +25)/ 24)) - 1>
														<cfif NoOfDays IS 1 >
															<span class="pix10boldred">Met the day before on #DateFormat(FixtureDate,'DD MMMM')#</span>
														<cfelseif NoOfDays IS -1 >
															<span class="pix10boldred">Meet the day after on #DateFormat(FixtureDate,'DD MMMM')#</span>
														<cfelseif NoOfDays GT 0 AND NoOfDays LT 30 >
															<span class="pix10boldred">Met #NoOfDays# days earlier on #DateFormat(FixtureDate,'DD MMMM')#</span>
														<cfelseif NoOfDays LT 0 AND NoOfDays GT -30 >
															<span class="pix10boldred">Meet #Abs(NoOfDays)# days later on #DateFormat(FixtureDate,'DD MMMM')#</span>
														</cfif>
													</cfloop>
												</cfif>
	
											<cfelse> <!--- SuppressLine IS "Yes" --->
													<cfif UCase(#ArrHomeString[2][RowN]#) IS "GUEST">
														<span class="pix13boldsilver"><em>#ArrHomeString[1][RowN]#</em></span>
													<cfelse>
														<span class="pix13boldsilver">#ArrHomeString[1][RowN]#</span>
													</cfif>
													<span class="pix13silver">v</span>
													<cfif UCase(#ArrAwayString[2][RowN]#) IS "GUEST">
														<span class="pix13boldsilver"><em>#ArrAwayString[1][RowN]#</em></span>
													<cfelse>
														<span class="pix13boldsilver">#ArrAwayString[1][RowN]#</span>
													</cfif>
											</cfif>
											<a href="FutureScheduledDates.cfm?LeagueCode=#LeagueCode#&T1=#ArrHomeString[3][RowN]#&O1=#ArrHomeString[7][RowN]#&T2=#ArrAwayString[3][RowN]#&O2=#ArrAwayString[7][RowN]#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=300;return escape('#TooltipText#');"><span class="pix13bold"><img src="gif/plan.gif" width="24" height="10" border="1" align="baseline"></span></a>
										<cfelse> <!--- request.SecurityLevel is White --->
											<cfif SuppressLine IS "Yes">
												<cfif UCase(#ArrHomeString[2][RowN]#) IS "GUEST">
													<span class="pix13boldsilver"><em>#ArrHomeString[1][RowN]#</em></span>
												<cfelse>
													<span class="pix13boldsilver">#ArrHomeString[1][RowN]#</span>
												</cfif>
												<span class="pix13silver">v</span>
												<cfif UCase(#ArrAwayString[2][RowN]#) IS "GUEST">
													<span class="pix13boldsilver"><em>#ArrAwayString[1][RowN]#</em></span>
												<cfelse>
													<span class="pix13boldsilver">#ArrAwayString[1][RowN]#</span>
												</cfif>
											<cfelse>  <!--- SuppressLine IS "No" --->
												<cfif UCase(#ArrHomeString[2][RowN]#) IS "GUEST">
													<span class="pix13bold"><em>#ArrHomeString[1][RowN]#</em></span>
												<cfelse>
													<span class="pix13bold">#ArrHomeString[1][RowN]#</span>
												</cfif>
												<span class="pix13">v</span>
												<cfif UCase(#ArrAwayString[2][RowN]#) IS "GUEST">
													<span class="pix13bold"><em>#ArrAwayString[1][RowN]#</em></span>
												<cfelse>
													<span class="pix13bold">#ArrAwayString[1][RowN]#</span>
												</cfif>
											</cfif>
										</cfif>
	
										
										<cfif TRIM(#ArrHomeString[5][RowN]#)IS NOT "" >
											<span class="pix13">
												  <i> &nbsp;#ArrHomeString[5][RowN]#</i>
											</span>
										</cfif>
	
										<cfif SuppressLine IS "No"  >
											<cfif PlayOne IS "Yes">
												<cfif ArrHomeString[4][RowN] IS 1>
													<span class="pix10">xxxxxxxxxxxx</span>
												</cfif>
											</cfif> 
											<cfif PlayThree IS "Yes">
												<cfif ArrHomeString[4][RowN] IS 1>
													<span class="pix10">(2nd meeting)</span>
												</cfif>
											</cfif> 
											<cfif PlayFour IS "Yes">
												<cfif ArrHomeString[4][RowN] IS 1>
													<span class="pix10">(2nd meeting)</span>
												</cfif>
											</cfif> 
										</cfif>
										<cfif SuppressLine IS "Yes"  >
											<cfif PlayOne IS "Yes">
												<cfif TooManyMeetings IS "Yes">
													<span class="pix13boldred">WARNING: Meeting more than once</span>
												</cfif>
											</cfif> 
											<cfif PlayThree IS "Yes">
												<cfif TooManyMeetings IS "Yes"><span class="pix13boldred">WARNING: Meeting more than 3 times</span></cfif>
											</cfif> 
											<cfif PlayFour IS "Yes">
												<cfif TooManyMeetings IS "Yes"><span class="pix13boldred">WARNING: Meeting more than 4 times</span></cfif>
											</cfif> 
										</cfif>
		
										</td>
									</tr>
								</table>
							</cfloop>
						</td>
					</cfloop>
					</cfoutput>
				</tr>
			</cfif>
			<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
				<cfoutput>
					<cfif request.ChangeDate IS "No">
						<input type="Hidden" name="ListOfFixturePitchAvailabilityIDs" value="#ListOfFixturePitchAvailabilityIDs#" >
<!---					
						<input type="Hidden" name="ListOfHomeTeamIDs" value="#ListOfHomeTeamIDs#" >					
						<input type="Hidden" name="ListOfHomeOrdinalIDs" value="#ListOfHomeOrdinalIDs#" >
--->						
						<input type="Hidden" name="ListOfHomeIDs" value="#ListOfHomeIDs#" >					
						<input type="Hidden" name="ListOfAwayIDs" value="#ListOfAwayIDs#" >
						<input type="Hidden" name="UnschedCount" value="#QMatches.RecordCount#">
						<!---
						<table border="0" align="center" cellpadding="2" cellspacing="0" >
							<tr>
								<td height="20"><span class="pix13bold">&nbsp;</span></td>
							</tr>
							<tr>
								<td align="center" valign="top" bgcolor="aqua"><input name="Temp" type="radio" value="1" checked ><span class="pix13bold">TEMP  </span><span class="pix10"> fixtures will be hidden from the public</span></td>
								<td align="center" valign="top" bgcolor="white"><input name="Temp" type="radio" value="0" ><span class="pix13bold">Normal</span><span class="pix10"> fixtures will be published</span></td>
							</tr>
							<tr align="center"><td colspan="4"><cfinclude template="InclTblAddGroup.cfm"></td></tr>
						</table>
						--->
						<cfinclude template="InclTblAddGroup.cfm">
					</cfif>
				</cfoutput>
			</cfif>
		</FORM>
	</table>
</cfif>	

	<cfinclude template="queries/qry_QPostponedMatches.cfm">
	<cfif QPostponedMatches.RecordCount GT 0>
		<HR>
		<span class="pix16brand"><BR>Postponed<BR><BR></span>
		<cfoutput query="QPostponedMatches">
			<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel)>
				<span class="pix13">#DateFormat(FixtureDate, 'DD/MM/YYYY')# <strong>#HomeTeamName#</strong> v <strong>#AwayTeamName#</strong><BR></span><span class="pix10">#Trim(FixtureNotes)#<BR></span>
			<cfelse>
				<span class="pix13"><a href="MtchDay.cfm?TblName=Matches&MDate=#DateFormat(FixtureDate, 'YYYY-MM-DD')#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#"><u>#DateFormat(FixtureDate, 'DD/MM/YYYY')#</u></a> <a href="UpdateForm.cfm?TblName=Matches&id=#ID#&DivisionID=#DivisionID#&HomeID=#HomeID#&AwayID=#AwayID#&LeagueCode=#LeagueCode#&Whence=MD"><strong><u>#HomeTeamName#</u></strong></a> v <a href="UpdateForm.cfm?TblName=Matches&id=#ID#&DivisionID=#DivisionID#&HomeID=#HomeID#&AwayID=#AwayID#&LeagueCode=#LeagueCode#&Whence=MD"><strong><u>#AwayTeamName#</u></strong></a><BR></span><span class="pix10">#Trim(FixtureNotes)#<BR></span>
			</cfif>
		</cfoutput>
	</cfif>
	<cfinclude template="queries/qry_QAbandonedMatches.cfm">
	<cfif QAbandonedMatches.RecordCount GT 0>
		<HR>
		<span class="pix16brand"><BR>Abandoned<BR><BR></span>
		<cfoutput query="QAbandonedMatches">
			<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel)>
				<span class="pix13">#DateFormat(FixtureDate, 'DD/MM/YYYY')# <strong>#HomeTeamName#</strong> v <strong>#AwayTeamName#</strong><BR></span>
			<cfelse>
				<span class="pix13"><a href="MtchDay.cfm?TblName=Matches&MDate=#DateFormat(FixtureDate, 'YYYY-MM-DD')#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#"><u>#DateFormat(FixtureDate, 'DD/MM/YYYY')#</u></a> <a href="UpdateForm.cfm?TblName=Matches&id=#ID#&DivisionID=#DivisionID#&HomeID=#HomeID#&AwayID=#AwayID#&LeagueCode=#LeagueCode#&Whence=MD"><strong><u>#HomeTeamName#</u></strong></a> v <a href="UpdateForm.cfm?TblName=Matches&id=#ID#&DivisionID=#DivisionID#&HomeID=#HomeID#&AwayID=#AwayID#&LeagueCode=#LeagueCode#&Whence=MD"><strong><u>#AwayTeamName#</u></strong></a><BR></span>
			</cfif>
		</cfoutput>
	</cfif>
	<cfinclude template="queries/qry_QVoidMatches.cfm">
	<cfif QVoidMatches.RecordCount GT 0>
		<HR>
		<span class="pix16brand"><BR>Void<BR><BR></span>
		<cfoutput query="QVoidMatches">
			<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel)>
				<span class="pix13">#DateFormat(FixtureDate, 'DD/MM/YYYY')# <strong>#HomeTeamName#</strong> v <strong>#AwayTeamName#</strong><BR></span>
			<cfelse>
				<span class="pix13"><a href="MtchDay.cfm?TblName=Matches&MDate=#DateFormat(FixtureDate, 'YYYY-MM-DD')#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#"><u>#DateFormat(FixtureDate, 'DD/MM/YYYY')#</u></a> <a href="UpdateForm.cfm?TblName=Matches&id=#ID#&DivisionID=#DivisionID#&HomeID=#HomeID#&AwayID=#AwayID#&LeagueCode=#LeagueCode#&Whence=MD"><strong><u>#HomeTeamName#</u></strong></a> v <a href="UpdateForm.cfm?TblName=Matches&id=#ID#&DivisionID=#DivisionID#&HomeID=#HomeID#&AwayID=#AwayID#&LeagueCode=#LeagueCode#&Whence=MD"><strong><u>#AwayTeamName#</u></strong></a><BR></span>
			</cfif>
		</cfoutput>
	</cfif>
	<cfinclude template="queries/qry_QTEMPMatches.cfm">
	<cfif QTEMPMatches.RecordCount GT 0>
		<HR>
		<cfif ListFind("Silver,Skyblue",request.SecurityLevel)>
			<span class="pix16brand"><BR>TEMP hidden from the public<BR><BR></span>
		<cfelse>
			<span class="pix16brand"><BR>Awaiting confirmation of dates ...<BR><BR></span>
		</cfif>
		<cfoutput query="QTEMPMatches">
			<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel)>
				<span class="pix13"><strong>#HomeTeamName#</strong> v <strong>#AwayTeamName#</strong><BR></span>
			<cfelse>
				<span class="pix13"><a href="MtchDay.cfm?TblName=Matches&MDate=#DateFormat(FixtureDate, 'YYYY-MM-DD')#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#"><u>#DateFormat(FixtureDate, 'DD/MM/YYYY')#</u></a> <a href="UpdateForm.cfm?TblName=Matches&id=#ID#&DivisionID=#DivisionID#&HomeID=#HomeID#&AwayID=#AwayID#&LeagueCode=#LeagueCode#&Whence=MD"><strong><u>#HomeTeamName#</u></strong></a> v <a href="UpdateForm.cfm?TblName=Matches&id=#ID#&DivisionID=#DivisionID#&HomeID=#HomeID#&AwayID=#AwayID#&LeagueCode=#LeagueCode#&Whence=MD"><strong><u>#AwayTeamName#</u></strong></a><BR></span>
			</cfif>
		</cfoutput>
	</cfif>

<script language="JavaScript" type="text/javascript" src="wz_tooltip.js"></script>
