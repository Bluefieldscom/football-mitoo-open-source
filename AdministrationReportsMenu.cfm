	<cfoutput>
			<table width="700" border="0" cellspacing="0" cellpadding="5" align="center" class="loggedinScreen">
			<!--- applies to season 2012 onwards only --->
			<cfif RIGHT(request.dsn,4) GE 2012>
				<cfinclude template="queries/qry_QUpdateHistoryCount.cfm">
				<tr align="center" bgcolor="red"  >
					<cfif QUpdateHistoryCount.IntervalCount GT "0">
						<td colspan="2" align="center" valign="top">
							<cfoutput><span class="pix18boldwhite">WARNING<br></span><span class="pix13boldwhite">Changes have been made to Referee Details, Referee Availability and Team Details by clubs, referees or administrators during the last #Left(TheInterval,2)# days. Please look at the Recent Update History.</span></cfoutput>			
						</td>
					</cfif>
				</tr>
			</cfif>
			<tr bgcolor="white">
				<td colspan="2" align="center">
				<span class="pix13">The password to reveal the yellow League Reports and beige Team Reports menus above is<br></span><span class="pix24boldnavy">#request.PWD3#</span><br />
						<span class="pix13bold">Please give this short password (3 characters) to<br>everyone who would normally receive your league handbook.</span>
				</td>
			</tr>	
			<tr bgcolor="white">
				<td colspan="2" align="center">
				<span class="pix13">The password to see the registered players for the entire league is <b>#RIGHT(request.filter,1)#A#LEFT(Reverse(request.PWD3),2)#B#LEFT(request.filter,1)#</b><br /></span>
						<span class="pix10bold">Only give this to club secretaries if you want them to have access to this information.</span>
				</td>
			</tr>	
		
			<tr bgcolor="Aqua">
				<td colspan="2" align="center">
					<span class="pix18bold">Administration Reports</span>
				</td>
			</tr>
			
			<tr bgcolor="Aqua">
				<td colspan="2" align="center" >
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>			
								<ul>
										<!--- applies to season 2012 onwards only --->
										<cfif RIGHT(request.dsn,4) GE 2012>
									 		<span class="pix13bold"><li><a href="DateRangeF.cfm?LeagueCode=#LeagueCode#">Fixture Information</a><span class="pix14boldred"> <-------- This is a new report</span></li></span> 
										</cfif>
									 	<span class="pix13bold"><li><a href="LeagueInfoReport.cfm?LeagueCode=#LeagueCode#">League Profile</a></li></span> 
										<!--- applies to season 2012 onwards only --->
										<cfif RIGHT(request.dsn,4) GE 2012>
									 		<span class="pix13bold"><li>Referee Details, Referee Availability, Team Details<br><a href="RCLogReport.cfm?LeagueCode=#LeagueCode#">Recent Update History</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="RCLogReport.cfm?LeagueCode=#LeagueCode#&Full=Yes">Full Update History</a></li></span>
										</cfif>
								</ul>
							</td>		
						</tr>
					</table>
				</td>
			</tr>
			
			<tr bgcolor="Aqua">
				<td align="left" valign="top">
				
					<ul><span class="pix14boldblack">General</span>
						<li><a href="htm/FAQ.htm" target="_blank"><span class="pix13bold">Frequently Asked Questions</span></a></li>
						<li><a href="Help.cfm?LeagueCode=#LeagueCode#" ><span class="pix13bold">Telephone Support</span></a></li>
						<li><a href="LoginHistory.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Recent LogIn History</span></a></li>
						<li><span class="pix13bold">List of <a href="SecretWordList.cfm?LeagueCode=#LeagueCode#">Club</a> or  <a href="RSecretWordList.cfm?LeagueCode=#LeagueCode#">Referee</a> Passwords</span></li>
						
						<li><span class="pix13bold">Fixtures and Referee Appointments <a href="RefAppointsXLS.cfm?LeagueCode=#LeagueCode#">Microsoft Excel Report</span></a></li>
						<li><a href="PenaltyDeciders.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Check Penalty Deciders</span></a></li>
						<li><a href="HomeAwayTeamCommentsXLS.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Team Comments Microsoft Excel Report</span></a></li>
						<li><a href="PrivateCommentsXLS.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Private Comments Microsoft Excel Report</span></a></li>
						<li><span class="pix13bold">Top Fifty Page Request Counter Values</span></li>
						<li><a href="TopCounts.cfm?LeagueCode=#LeagueCode#&Year=2013" target="2013Counts"><span class="pix13bold">2013</span></a></li>						
						<li><a href="TopCounts.cfm?LeagueCode=#LeagueCode#&Year=2012" target="2012Counts"><span class="pix13bold">2012</span></a></li>
						<li><a href="TopCounts.cfm?LeagueCode=#LeagueCode#&Year=2011" target="2011Counts"><span class="pix13bold">2011</span></a></li>
						<li><a href="AwardedGames.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Awarded Games</span></a></li>						
						<li><a href="htm/MatchBans.htm" target="_blank"><span class="pix13bold">Match Bans</span></a></li>
						<li><a href="TopTwenty.cfm?LeagueCode=#LeagueCode#&Limit=No"><span class="pix13bold">Leading Goalscorers and Star Players</span></a></li>
					</ul>
					<ul><span class="pix14boldblack">Referees and Discipline</span>
						<li><a href="ListOfReferees.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">List of Referees</span></a></li>
						<li><a href="RefAnalysis.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Referee Coverage</span></a></li>
						<li><a href="RefereeDetailsXLS.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Referee Details Microsoft Excel Report</span></a></li>
						<li><a href="DateRange1.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Referees' Marks Microsoft Excel Report</span></a></li>
						<li><a href="RefsRanking.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Referees' Rankings</span></a></li>
						<li><a href="AsstRefsRanking.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Assistant Referees' Rankings</span></a></li>
						<li><span class="pix13bold">Referees' Availability + Notes <a href="RefereesAvailability.cfm?LeagueCode=#LeagueCode#">by Date</a> or <a href="RefereesAvailability2.cfm?LeagueCode=#LeagueCode#">by Name</a></span></li>
						<li><a href="MissingRefereesMarks.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Referees with missing marks</span></a></li>
						<li><a href="MissingRefereesMarks.cfm?LeagueCode=#LeagueCode#&External=N"><span class="pix13bold"> - as above but Ignoring External Competitions</span></a></li>
						<li><span class="pix13bold">Red Cards and Suspensions<br><a href="RedCardSuspens.cfm?LeagueCode=#LeagueCode#">All</a>&nbsp;&nbsp;or&nbsp;&nbsp;<a href="RedCardSuspensND.cfm?LeagueCode=#LeagueCode#">Numbers Disagree</a></span></li>
						<li><a href="CautionThresholds.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">See Player: Caution Thresholds</span></a></li>
						<li><a href="YellowRedCards.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">See Player: Yellow & Red Cards</span></a></li>
						<li><span class="pix13bold">Team Disciplinary Analysis</span><br><a href="DiscipAnalysis.cfm?LeagueCode=#LeagueCode#&cups=Y"><span class="pix13bold">including</span></a><span class="pix13bold"> or </span><a href="DiscipAnalysis.cfm?LeagueCode=#LeagueCode#&cups=N"><span class="pix13bold">excluding</span></a><span class="pix13bold"> cup matches </span></li>
						<li><a href="AverageRefMarks.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Average Marks Awarded to Referee by Team</span></a></li>
						<li><a href="CardAnalysis.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">See Club: Card Analysis</span></a></li>
					<cfif RIGHT(LeagueCode,2) GT "01" >
							<li><a href="RefsPromotionReport.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Referee's Promotion Report</span></a></li>
					</cfif>
						<li><a href="ReferToDiscipline.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Check Refer To Discipline</span></a></li>
						<li><a href="PlayersBanned.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Players Banned for 5+ Games</span></a></li>
				</ul>
					<cflock scope="session" timeout="10" type="readonly">
						<cfset request.LeagueType = session.LeagueType >
					</cflock>
					<cfif request.LeagueType IS "Contributory">
					<ul class="bg_highlight2"><span class="pix14boldblack">Contributory League</span>
						<li><a href="ContributoryReport.cfm?LeagueCode=#LeagueCode#&ReportType=#URLEncodedFormat('Home Club Officials Benches')#"><span class="pix13bold">Home Club Officials Benches</span></a></li>
						<li><a href="ContributoryReport.cfm?LeagueCode=#LeagueCode#&ReportType=#URLEncodedFormat('Away Club Officials Benches')#"><span class="pix13bold">Away Club Officials Benches</span></a></li>
						<li><a href="ContributoryReport.cfm?LeagueCode=#LeagueCode#&ReportType=#URLEncodedFormat('State of Pitch')#"><span class="pix13bold">State of Pitch</span></a></li>
						<li><a href="ContributoryReport.cfm?LeagueCode=#LeagueCode#&ReportType=#URLEncodedFormat('Club Facilities')#"><span class="pix13bold">Club Facilities</span></a></li>
						<li><a href="ContributoryReport.cfm?LeagueCode=#LeagueCode#&ReportType=#URLEncodedFormat('Hospitality')#"><span class="pix13bold">Hospitality</span></a></li>
					</ul>
					</cfif>

       </td>

				
      <td align="left" valign="top"><span class="pix14boldblack">
					<ul>Players, Appearances and Goalscorers
					<li><a href="CurrentRegistrationsXLS.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Current Player Registrations Microsoft Excel Report</span></a></li>
					<li><a href="PlayerDetailsXLS.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Player Details Microsoft Excel Report</span></a></li>
					<li><a href="PlayedUnderSuspension.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Played while under suspension</span></a></li>
					<li><a href="PlayedWhileUnregistered.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Played while unregistered</span></a></li>
					<li><a href="MissingAppearances.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Matches with missing player appearances</span></a></li>
					<li><a href="MissingAppearances.cfm?LeagueCode=#LeagueCode#&External=N"><span class="pix13bold"> - as above but Ignoring External Competitions</span></a></li>
					<li><a href="MissingAppearances2.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Matches with team sheets where updating ALLOWED</span></a></li>
					<li><a href="MissingGoalscorers.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Matches with missing/too many goalscorers</span></a></li>
					<li><a href="Goalscorer.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">See Player: Goals Scored</span></a></li>
					<li><a href="AppearanceAnalysis.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">See Club: Player Appearances & Goals Analysis</span></a></li>
					<li><a href="RegisteredPlayers.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Registered Players Analysis</span></a></li>
					<li><a href="PlayerUnusedNos.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Unused Player Registration Numbers</span></a></li>
					<li><a href="AppearancesQuery.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Appearances Query</span></a></li>
					<ul><span class="pix10bold">Export in .csv format</span>
					<li><a href="ExportSuspendedPlayers.cfm?LeagueCode=#LeagueCode#" target="#LeagueCode#SuspensionsExport"><span class="pix13bold">Player Suspensions</span></a></li>
					<li><a href="ExportUnregPlayers.cfm?LeagueCode=#LeagueCode#" target="#LeagueCode#UnregExport"><span class="pix13bold">Unregistered Players</span></a></li>
					<li><a href="ExportRegPlayers.cfm?LeagueCode=#LeagueCode#" target="#LeagueCode#RegExport"><span class="pix13bold">Current Player Registrations</span></a></li>
					<li><a href="ExportLapsedReg.cfm?LeagueCode=#LeagueCode#" target="#LeagueCode#LapsedExport"><span class="pix13bold">Transfers</span></a></li>
					</ul></ul>
					<span class="pix14boldblack">
					<ul>Sportsmanship
					<li><a href="SportsmanshipTable.cfm?LeagueCode=#LeagueCode#&Order=HighAtTop"><span class="pix13bold">High Marks at Top</span></a></li>
					<li><a href="SportsmanshipTable.cfm?LeagueCode=#LeagueCode#&Order=LowAtTop"><span class="pix13bold">Low Marks at Top</span></a></li>
					<li><a href="MissingSportsmanshipMarks.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Missing Sportsmanship marks</span></a></li>
					<li><a href="MissingSportsmanshipMarks.cfm?LeagueCode=#LeagueCode#&External=N"><span class="pix13bold"> - as above but Ignoring External Competitions</span></a></li>
        			</ul>
					<ul>Hospitality
					<li><a href="HospitalityTable.cfm?LeagueCode=#LeagueCode#&Order=HighAtTop"><span class="pix13bold">High Marks at Top</span></a></li>
					<li><a href="HospitalityTable.cfm?LeagueCode=#LeagueCode#&Order=LowAtTop"><span class="pix13bold">Low Marks at Top</span></a></li>
					<li><a href="MissingHospitalityMarks.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Missing Hospitality marks</span></a></li>
					<li><a href="HospitalityMarksXLS.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Hospitality Marks Microsoft Excel Report</span></a></li>
					</ul>
					<ul>Team Details
					<li><a href="TeamDetailsXLS.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Team Details Microsoft Excel Report</span></a></li>
					<li><a href="FreeDates.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Team - Dates Unavailable Report</span></a></li>
					</ul>
					<ul>Scheduling
					<li><a href="FutureScheduledDates.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Future Scheduled Dates</span></a></li>
					</ul>
					</td>
			</tr>

		</table>
	</cfoutput>
