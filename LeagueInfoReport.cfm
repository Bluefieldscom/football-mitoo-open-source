<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<cfinclude template="InclBegin.cfm">
<!---
						***************************************************
						* Show the league administrator all his settings  *
						***************************************************
--->

<cfinclude template="queries\qry_QLeagueInfoReport.cfm">

<table width="100%" border="0" align="center" cellpadding="2" cellspacing="2">

	<!---                                       
	                                        ****************************************
	                                        *  How many players, referees, teams   *
	                                        *  newsitems  etc                    ? *
	                                        ****************************************
	--->
		<tr>
			<cfif QHowManyMemberClubs.tcount IS 0>
				<td bgcolor="black" align="left"><cfoutput><span class="pix13boldwhite">You have no member clubs. If you want to record member clubs please let me know so I can help.</span></cfoutput></td>
			<cfelse>
				<td bgcolor="gray" align="left"><cfoutput><span class="pix13boldwhite">You have #QHowManyMemberClubs.tcount# member clubs</span></cfoutput></td>
			</cfif>
		</tr>
		<tr>
			<cfif QHowManyGuestClubs.tcount IS 0>
				<td bgcolor="black" align="left"><cfoutput><span class="pix13boldwhite">You have no guest clubs. You need guest clubs for external competitions.</span></cfoutput></td>
			<cfelse>
				<td bgcolor="gray" align="left"><cfoutput><span class="pix13boldwhite">You have #QHowManyGuestClubs.tcount# guest clubs</span></cfoutput></td>
			</cfif>
		</tr>
		<tr>
			<cfif QHowManyReferees.rcount-1 IS 0>
				<td bgcolor="black" align="left"><cfoutput><span class="pix13boldwhite">You have no referees. If you want to record referees please let me know so I can help.</span></cfoutput></td>
			<cfelse>
				<td bgcolor="gray" align="left"><cfoutput><span class="pix13boldwhite">You have #QHowManyReferees.rcount-1# referees</span></cfoutput></td>
			</cfif>
		</tr>
		<tr>
			<cfif QHowManyPlayers.pcount-1 IS 0>
				<td bgcolor="black" align="left"><cfoutput><span class="pix13boldwhite">You have no players. If you want to register players please let me know so I can help.</span></cfoutput></td>
			<cfelse>
				<td bgcolor="gray" align="left"><cfoutput><span class="pix13boldwhite">You have #QHowManyPlayers.pcount-1# players</span></cfoutput></td>
			</cfif>
		</tr>
		<tr>
			<cfif QHowManyNOTICE.ncount IS 0>
				<td bgcolor="black" align="left"><cfoutput><span class="pix13boldwhite">You have no NOTICE. If you want to display a NOTICE on every screen please let me know so I can help.</span></cfoutput></td>
			<cfelse>
				<td bgcolor="silver" align="left"><cfoutput><span class="pix13boldwhite">NOTICE says: </span><span class="pix10">#QHowManyNOTICE.notes#</span></cfoutput></td>
			</cfif>
		</tr>
		
		<tr>
			<cfif QHowManyNewsitems.ncount IS 0>
				<td bgcolor="black" align="left"><cfoutput><span class="pix13boldwhite">You have no visible newsitems. If you want to display newsitems please let me know so I can help.</span></cfoutput></td>
			<cfelse>
				<td bgcolor="gray" align="left"><cfoutput><span class="pix13boldwhite">You have #QHowManyNewsitems.ncount# visible newsitems</span></cfoutput></td>
			</cfif>
		</tr>
		<tr>
			<cfif QHowManyHiddenNewsitems.ncount IS 0>
				<td bgcolor="black" align="left"><cfoutput><span class="pix13boldwhite">You have no hidden newsitems.</span></cfoutput></td>
			<cfelse>
				<td bgcolor="gray" align="left"><cfoutput><span class="pix13boldwhite">You have #QHowManyHiddenNewsitems.ncount# hidden newsitems</span></cfoutput></td>
			</cfif>
		</tr>
		
		<cfif VenueAndPitchAvailable IS 1>
			<tr>
				<cfif QHowManyVenues.vcount IS 0>
					<td bgcolor="black" align="left"><cfoutput><span class="pix13boldwhite">You have no venues.</span></cfoutput></td>
				<cfelse>
					<td bgcolor="gray" align="left"><cfoutput><span class="pix13boldwhite">You have #QHowManyVenues.vcount# venues</span></cfoutput></td>
				</cfif>
			</tr>
			<tr>
				<cfif QHowManyVenuesWithMaps.vcount IS 0>
					<td bgcolor="black" align="left"><cfoutput><span class="pix13boldwhite">You have no venues with map links. If you want to display maps please let me know so I can help.</span></cfoutput></td>
				<cfelse>
					<td bgcolor="gray" align="left"><cfoutput><span class="pix13boldwhite">You have #QHowManyVenuesWithMaps.vcount# venues with map links.</span></cfoutput></td>
				</cfif>
			</tr>
		</cfif>
<cfoutput query="QLeagueCode" >
	<!---                                       
	                                        ********************
	                                        *  SeasonStartDate *
	                                        ********************
	--->
		<tr bgcolor="Ghostwhite">
			<td align="left">
				<span class="pix13">1. Season Start Date: <strong>#DateFormat( SeasonStartDate , "DD MMMM YYYY")#</strong></span>
			</td>
		</tr>
	<!---                                       
	                                        ******************
	                                        *  SeasonEndDate *
	                                        ******************
	--->
		<tr>
			<td align="left">
				<span class="pix13">2. Season End Date: <strong>#DateFormat( SeasonEndDate , "DD MMMM YYYY")#</strong></span>
			</td>
		</tr>
	<!---                                       
	                                        *****************
	                                        *  CountiesList *
	                                        *****************
	--->
		<tr bgcolor="Ghostwhite">
			<td align="left">
				<span class="pix13">3. Counties in which the site appears: <strong>#CountiesList#</strong><br></span>
			</td>
		</tr>
	<!---                                       
	                                        *************
	                                        *  NameSort *
	                                        *************
	--->
		<tr>
			<td align="left">
				<span class="pix13">4. Basic league name: <strong>#NameSort#</strong></span>
			</td>
		</tr>	
	<!---                                       
	                                        ***************
	                                        *  LeagueName *
	                                        ***************
	--->
		<tr bgcolor="Ghostwhite">
			<td align="left">
				<span class="pix13">5. League name with sponsor: <strong>#LeagueName#</strong></span>
			</td>
		</tr>	

	<!---                                       
	                                        ****************
	                                        *  WebsiteLink *
	                                        ****************
	--->
		<tr>
			<td align="left">
			<cfif Trim(WebsiteLink) IS "">
				<span class="pix13">6. Link for League Website: <strong>NOT SPECIFIED</strong></span>
			<cfelse>
				<span class="pix13">6. Link for League Website: <strong>#WebsiteLink#</strong></span>
			</cfif>
			</td>
		</tr>	

	<!---                                       
	                                        **********************
	                                        *  DefaultDivisionID *
	                                        **********************
	--->
		<cfset DivisionID = DefaultDivisionID>
		<cfinclude template="queries/qry_GetDivision_v2.cfm">
		<tr bgcolor="Ghostwhite">
			<td align="left">
				<span class="pix13">7. Default Competition: <strong>#GetDivision.DesiredDivisionName#</strong></span>
			</td>
		</tr>	

	<!---                                       
	                                        *******************************
	                                        * Points for Win, Draw & Loss *
	                                        *******************************
	--->
		<tr>
			<td align="left">
				<span class="pix13">8. Points for Win: <strong>#PointsForWin#</strong>&nbsp;&nbsp;&nbsp;Points for Draw: <strong>#PointsForDraw#</strong>&nbsp;&nbsp;&nbsp;Points for Loss: <strong>#PointsForLoss#</strong></span></td>
			</td>
		</tr>	
	<!---                                       
	                                        ************************
	                                        *  LeagueTblCalcMethod *
	                                        ************************
	--->
		<tr bgcolor="Ghostwhite">
			<td align="left">
				<span class="pix13">9. League Table Calculated using: <strong>#LeagueTblCalcMethod#</strong></span></td>
			</td>
		</tr>	
	<!---                                       
	                                        ***************
	                                        *  SeasonName *
	                                        ***************
	--->
		<tr>
			<td align="left">
				<span class="pix13">10. Season: <strong>#SeasonName#</strong></span></td>
			</td>
		</tr>	
	<!---                                       
	                                        ******************
	                                        *  Youth League  *
	                                        ******************
	--->
		<tr bgcolor="Ghostwhite">
			<td align="left">
			<cfif DefaultYouthLeague IS 1>
				<span class="pix13">11. Youth League? : <strong>Yes</strong></span>
			<cfelseif DefaultYouthLeague IS 0>
				<span class="pix13">11. Youth League? : <strong>No</strong></span>
			<cfelse>
				<span class="pix13">11. Youth League? : <strong>#DefaultYouthLeague#</strong></span>
			</cfif>
			</td>
		</tr>	
	<!---                                       
	                                        ************************
	                                        *  DefaultGoalScorers  *
	                                        ************************
	--->
		<tr>
			<td align="left">
			<cfif DefaultGoalScorers IS 1>
				<span class="pix13">12. Goal Scorers can be shown? : <strong>Yes</strong></span>
			<cfelseif DefaultGoalScorers IS 0>
				<span class="pix13">12. Goal Scorers can be shown? : <strong>No</strong></span>
			<cfelse>
				<span class="pix13">12. Goal Scorers can be shown? : <strong>#DefaultGoalScorers#</strong></span>
			</cfif>
			</td>
		</tr>	
	<!---                                       
	                                        ************************
	                                        *  Referee Marks       *
	                                        ************************
	--->
		<tr bgcolor="Ghostwhite">
			<td align="left">
			<cfif RefMarksOutOfHundred IS 1>
				<span class="pix13">13. Referee Marks are Out of a Hundred? : <strong>Yes</strong></span>
			<cfelseif RefMarksOutOfHundred IS 0>
				<span class="pix13">13. Referee Marks are Out of a Hundred? : <strong>No, they are out of ten</strong></span>
			<cfelse>
				<span class="pix13">13. Goal Scorers can be shown? : <strong>#RefMarksOutOfHundred#</strong></span>
			</cfif>
			</td>
		</tr>	
	<!---                                       
	                                        ****************************
	                                        * SuppressTeamSheetEntry   *
	                                        ****************************
	--->
		<tr>
			<td align="left">
			<cfif SuppressTeamSheetEntry IS 0>
				<span class="pix13">14. Allow the entry of team sheets by clubs? : <strong>Yes</strong></span>
			<cfelseif SuppressTeamSheetEntry IS 1>
				<span class="pix13">14. Allow the entry of team sheets by clubs? : <strong>No</strong></span>
			<cfelse>
				<span class="pix13">14. SuppressTeamSheetEntry : <strong>#SuppressTeamSheetEntry#</strong></span>
			</cfif>
			</td>
		</tr>	


	<!---                                       
	                                        *********************************
	                                        * SuppressRedYellowCardsEntry   *
	                                        *********************************
	--->
		<tr bgcolor="Ghostwhite">
			<td align="left">
			<cfif SuppressRedYellowCardsEntry IS 0>
				<span class="pix13">15. Allow the entry of Red & Yellow Cards on team sheet by clubs? : <strong>Yes</strong></span>
			<cfelseif SuppressRedYellowCardsEntry IS 1>
				<span class="pix13">15. Allow the entry of Red & Yellow Cards on team sheet by clubs? : <strong>No</strong></span>
			<cfelse>
				<span class="pix13">15. SuppressRedYellowCardsEntry : <strong>#SuppressRedYellowCardsEntry#</strong></span>
			</cfif>
			</td>
		</tr>	
	<!---                                       
	                                        *******************************
	                                        * SuppressTeamCommentsEntry   *
	                                        *******************************
	--->
		<tr>
			<td align="left">
			<cfif SuppressTeamCommentsEntry IS 0>
				<span class="pix13">16. Allow the entry of comments on team sheet by clubs? : <strong>Yes</strong></span>
			<cfelseif SuppressTeamCommentsEntry IS 1>
				<span class="pix13">16. Allow the entry of comments on team sheet by clubs? : <strong>No</strong></span>
			<cfelse>
				<span class="pix13">16. SuppressTeamCommentsEntry : <strong>#SuppressTeamCommentsEntry#</strong></span>
			</cfif>
			</td>
		</tr>	
	<!---                                       
	                                        *******************************
	                                        * SuppressTeamDetailsEntry    *
	                                        *******************************
	--->
		<tr bgcolor="Ghostwhite">
			<td align="left">
			<cfif SuppressTeamDetailsEntry IS 0>
				<span class="pix13">17. Allow the entry of Team Details by clubs? : <strong>Yes</strong></span>
			<cfelseif SuppressTeamDetailsEntry IS 1>
				<span class="pix13">17. Allow the entry of Team Details by clubs? : <strong>No</strong></span>
			<cfelse>
				<span class="pix13">17. SuppressTeamDetailsEntry : <strong>#SuppressTeamDetailsEntry#</strong></span>
			</cfif>
			</td>
		</tr>	
	<!---                                       
	                                        **************************
	                                        * SuppressKOTimeEntry    *
	                                        **************************
	--->
		<tr>
			<td align="left">
			<cfif SuppressKOTimeEntry IS 0>
				<span class="pix13">18. Allow the entry of Kick Off Time by clubs? : <strong>Yes</strong></span>
			<cfelseif SuppressKOTimeEntry IS 1>
				<span class="pix13">18. Allow the entry of Kick Off Time by clubs? : <strong>No</strong></span>
			<cfelse>
				<span class="pix13">18. SuppressKOTimeEntry : <strong>#SuppressKOTimeEntry#</strong></span>
			</cfif>
			</td>
		</tr>	

	<!---                                       
	                                        *********************************
	                                        * Suppress Leading Goalscorers  *
	                                        *********************************
	--->
		<tr bgcolor="Ghostwhite">
			<td align="left">
			<cfif SuppressLeadingGoalscorers IS 0>
				<span class="pix13">19. Allow Leading Goalscorer Table? : <strong>Yes</strong></span>
			<cfelseif SuppressLeadingGoalscorers IS 1>
				<span class="pix13">19. Allow Leading Goalscorer Table? : <strong>No</strong></span>
			<cfelse>
				<span class="pix13">19. SuppressLeadingGoalscorers : <strong>#SuppressLeadingGoalscorers#</strong></span>
			</cfif>
			</td>
		</tr>	
	<!---                                       
	                                        *********************************
	                                        * Suppress Scoreline Entry      *
	                                        *********************************
	--->
		<tr>
			<td align="left">
			<cfif SuppressScorelineEntry IS 0>
				<span class="pix13">20. Allow Scoreline Entry by Clubs? : <strong>Yes</strong></span>
			<cfelseif SuppressScorelineEntry IS 1>
				<span class="pix13">20. Allow Scoreline Entry by Clubs? : <strong>No</strong></span>
			<cfelse>
				<span class="pix13">20. SuppressScorelineEntry : <strong>#SuppressScorelineEntry#</strong></span>
			</cfif>
			</td>
		</tr>	
	<!---                                       
	                                        **********************
	                                        * Hide this season ? *
	                                        **********************
	--->
		<tr bgcolor="Ghostwhite">
			<td align="left">
			<cfif HideThisSeason IS 0>
				<span class="pix13">21. Hide this Season from Public view. Display to administrators only? : <strong>No</strong></span>
			<cfelseif HideThisSeason IS 1>
				<span class="pix13">21. Hide this Season from Public view. Display to administrators only? : <strong>Yes</strong></span>
			<cfelse>
				<span class="pix13">21. HideThisSeason : <strong>#HideThisSeason#</strong></span>
			</cfif>
			</td>
		</tr>	
	<!---                                       
	                                        *****************************************
	                                        * Player Re-Registration Form (.PDF): ? *
	                                        *****************************************
	--->
		<tr>
			<td align="left">
			<cfif NoPlayerReRegistrationForm IS 0>
				<span class="pix13">22. Player Re-Registration Form (.PDF)? : <strong>Yes</strong></span>
			<cfelseif NoPlayerReRegistrationForm IS 1>
				<span class="pix13">22. Player Re-Registration Form (.PDF)? : <strong>No</strong></span>
			<cfelse>
				<span class="pix13">22. NoPlayerReRegistrationForm : <strong>#NoPlayerReRegistrationForm#</strong></span>
			</cfif>
			</td>
		</tr>	
	<!---                                       
	                                        *******************************
	                                        * Match Based Suspensions ?   *
	                                        *******************************
	--->
		<tr bgcolor="Ghostwhite">
			<td align="left">
			<cfif MatchBasedSuspensions IS 0>
				<span class="pix13">23. Match Based Suspensions? : <strong>No</strong></span>
			<cfelseif MatchBasedSuspensions IS 1>
				<span class="pix13">23. Match Based Suspensions? : <strong>Yes</strong></span>
			<cfelse>
				<span class="pix13">23. MatchBasedSuspensions : <strong>#MatchBasedSuspensions#</strong></span>
			</cfif>
			</td>
		</tr>	
	<!---                                       
	                                        *******************************
	                                        * Show Assessor ?             *
	                                        *******************************
	--->
		<tr>
			<td align="left">
			<cfif ShowAssessor IS 0>
				<span class="pix13">24. Show Assessor name? : <strong>No</strong></span>
			<cfelseif ShowAssessor IS 1>
				<span class="pix13">24. Show Assessor name? : <strong>Yes</strong></span>
			<cfelse>
				<span class="pix13">24. ShowAssessor : <strong>#ShowAssessor#</strong></span>
			</cfif>
			</td>
		</tr>	
	<!---                                       
	                                        *******************************
	                                        * Hide Suspension Info ?      *
	                                        *******************************
	--->
		<tr bgcolor="Ghostwhite">
			<td align="left">
			<cfif HideSuspensions IS 0>
				<span class="pix13">25. Hide Suspension Info from public? : <strong>No</strong></span>
			<cfelseif HideSuspensions IS 1>
				<span class="pix13">25. Hide Suspension Info from public? : <strong>Yes</strong></span>
			<cfelse>
				<span class="pix13">25. HideSuspensions : <strong>#HideSuspensions#</strong></span>
			</cfif>
			</td>
		</tr>	
	<!---                                       
	                                        *******************************
	                                        * Suspension Starts after  ?  *
	                                        *******************************
	--->
		<tr>
			<td align="left">
				<span class="pix13">26. Match Based Suspensions Start after : <strong>#SuspensionStartsAfter# days</strong></span>
			</td>
		</tr>
	<!---                                       
	                                        *******************************
	                                        * Kick Off Time Order?        *
	                                        *******************************
	--->
		<tr bgcolor="Ghostwhite">
			<td align="left">
			<cfif KickOffTimeOrder IS 0>
				<span class="pix13">27. Display match day fixtures in Kick Off Time order? : <strong>No</strong></span>
			<cfelseif KickOffTimeOrder IS 1>
				<span class="pix13">27. Display match day fixtures in Kick Off Time order? : <strong>Yes</strong></span>
			<cfelse>
				<span class="pix13">27. KickOffTimeOrder : <strong>#KickOffTimeOrder#</strong></span>
			</cfif>
			</td>
		</tr>	
	<!---                                       
	                                        ******************************************
	                                        * Clubs can input Sportsmanship Marks?   *
	                                        ******************************************
	--->
		<tr>
			<td align="left">
			<cfif ClubsCanInputSportsmanshipMarks IS 0>
				<span class="pix13">28. Clubs can input Sportsmanship Marks? : <strong>No</strong></span>
			<cfelseif ClubsCanInputSportsmanshipMarks IS 1>
				<span class="pix13">28. Clubs can input Sportsmanship Marks? : <strong>Yes</strong></span>
			<cfelse>
				<span class="pix13">28. ClubsCanInputSportsmanshipMarks : <strong>#ClubsCanInputSportsmanshipMarks#</strong></span>
			</cfif>
			</td>
		</tr>	
	<!---                                       
	                                        ******************************************
	                                        * League Type Normal or Contributory ?   *
	                                        ******************************************
	--->
		<tr bgcolor="Ghostwhite">
			<td align="left">
				<span class="pix13">29. League Type Normal or Contributory ? : <strong>#LeagueType#</strong></span>
			</td>
		</tr>
		
		
			<!---                                       
													*********************************
													*  Referee Mark must be Entered *
													*********************************
			--->
		<tr>
			<td align="left">
			<cfif RefereeMarkMustBeEntered IS 0>
				<span class="pix13">30. Referee Mark MUST be entered by club on Team Sheet? : <strong>No</strong></span>
			<cfelseif RefereeMarkMustBeEntered IS 1>
				<span class="pix13">30. Referee Mark MUST be entered by club on Team Sheet? : <strong>Yes</strong></span>
			<cfelse>
				<span class="pix13">30. RefereeMarkMustBeEntered : <strong>#RefereeMarkMustBeEntered#</strong></span>
			</cfif>
			</td>
		</tr>	
		
		
		
			
	<!---                                       
	                                        ******************************************
	                                        * Venues And Pitch Availability used ?   *
	                                        ******************************************
	--->
		<tr>
			<cfif VenueAndPitchAvailable IS 0>
				<td align="left" bgcolor="Black"><span class="pix13boldwhite">31. Venues And Pitch Availability used? : <strong>No</strong></span></td>
			<cfelseif VenueAndPitchAvailable IS 1>
				 <td align="left" bgcolor="Ghostwhite"><span class="pix13">31. Venues And Pitch Availability used? : <strong>Yes</strong></span></td>
			<cfelse>
				<td align="left" bgcolor="red"><span class="pix13">31. VenueAndPitchAvailable : <strong>#VenueAndPitchAvailable#</strong></span></td>
			</cfif>
		</tr>	
	<!---                                       
	                                        ******************************************
	                                        * Random Player Registration Numbers ?   *
	                                        ******************************************
	--->
		<tr>
			<td align="left">
			<cfif RandomPlayerRegNo IS 0>
				<span class="pix13">32. Random Player Registration Numbers used? : <strong>No</strong></span>
			<cfelseif RandomPlayerRegNo IS 1>
				<span class="pix13">32. Random Player Registration Numbers used? : <strong>Yes</strong></span>
			<cfelse>
				<span class="pix13">32. RandomPlayerRegNo : <strong>#RandomPlayerRegNo#</strong></span>
			</cfif>
			</td>
		</tr>	
	<!---                                       
	                                        ******************************************
	                                        * Sportsmanship Marks Out Of Hundred ?   *
	                                        ******************************************
	--->
		<tr bgcolor="Ghostwhite">
			<td align="left">
			<cfif SportsmanshipMarksOutOfHundred IS 0>
				<span class="pix13">33. Sportsmanship Marks Out Of Ten or Hundred? : <strong>Ten</strong></span>
			<cfelseif SportsmanshipMarksOutOfHundred IS 1>
				<span class="pix13">33. Sportsmanship Marks Out Of Ten or Hundred? : <strong>Hundred</strong></span>
			<cfelse>
				<span class="pix13">33. SportsmanshipMarksOutOfHundred : <strong>#SportsmanshipMarksOutOfHundred#</strong></span>
			</cfif>
			</td>
		</tr>	

	<!---                                       
	                                        ****************************************************
	                                        * Make Player Reg No and FAN one and the same: ?   *
	                                        ****************************************************
	--->
		<tr>
			<td align="left">
			<cfif FANPlayerRegNo IS 0>
				<span class="pix13">34. Record the Player Reg. No. and the FAN no. as the same? : <strong>No</strong></span>
			<cfelseif FANPlayerRegNo IS 1>
				<span class="pix13">34. Record the Player Reg. No. and the FAN no. as the same? : <strong>Yes</strong></span>
			<cfelse>
				<span class="pix13">34. FANPlayerRegNo : <strong>#FANPlayerRegNo#</strong></span>
			</cfif>
			</td>
		</tr>	

			<!---                                       
													*****************************
													*  Referee Low Mark Warning *
													*****************************
			--->
		<tr bgcolor="Ghostwhite">
			<td align="left">
			<cfif RefereeLowMarkWarning IS 0>
				<span class="pix13">35. Referee Low Mark Warning applied? : <strong>No</strong></span>
			<cfelseif RefereeLowMarkWarning GT 0>
				<span class="pix13">35. Referee Low Mark Warning applied? : <strong>Yes, #RefereeLowMarkWarning# marks</strong></span>
			<cfelse>
				<span class="pix13">35. RefereeLowMarkWarning : <strong>#RefereeLowMarkWarning#</strong></span>
			</cfif>
			</td>
		</tr>	
			<!---                                       
													*****************************
													* See Opposition Team Sheet *
													*****************************
			--->
		<tr>
			<td align="left">
			<cfif SeeOppositionTeamSheet IS 0>
				<span class="pix13">36. Clubs are allowed to see the opposition's team sheet? : <strong>No</strong></span>
			<cfelseif SeeOppositionTeamSheet IS 1>
				<span class="pix13">36. Clubs are allowed to see the opposition's team sheet? : <strong>Yes</strong></span>
			<cfelse>
				<span class="pix13">36. SeeOppositionTeamSheet : <strong>#SeeOppositionTeamSheet#</strong></span>
			</cfif>
			</td>
		</tr>
			<!---                                       
													*********************** 
													* League Badge Used ? *
													***********************
			--->
		<tr bgcolor="Ghostwhite">
			<td align="left">
			<cfif BadgeJPEG IS "blank">
				<span class="pix13">37. League Badge Displayed in page heading? : <strong>No (why not?)</strong></span>
			<cfelse>
				<span class="pix13">37. League Badge Displayed in page heading? : <strong>Yes, #BadgeJPEG#.jpg</strong></span>
			</cfif>
			</td>
		</tr>
</cfoutput>
</table>


