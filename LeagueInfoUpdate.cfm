<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<!---
																					***************
																					* 2nd time in *
																					***************
--->
<cfif StructKeyExists(form, "Button")>
	<cfif Form.Button IS "Update">
		<cfinclude template="queries/upd_LeagueInfo1.cfm">
		<CFLOCATION URL="LeagueInfoUpdate.cfm?LeagueCode=#Form.LeagueCode#"	ADDTOKEN="NO">
	</cfif>
	<!---
	<cfif Form.Button IS "ChangePrefix">
		<cfif LEN(request.filter) IS LEN(form.AltLeagueCodePrefix) >
			<cfset NewDefaultLeagueCode = "#UCase(form.AltLeagueCodePrefix)##RIGHT(LeagueCode,4)#" >
			<cfset NewLeagueCodePrefix = "#UCase(form.AltLeagueCodePrefix)#" >
			<cfset OldLeagueCodePrefix = "#UCase(request.filter)#" >
			<cfinclude template="queries/upd_ChangeLeagueCodePrefix.cfm">
			<CFLOCATION URL="LeagueInfoUpdate.cfm?LeagueCode=#Form.LeagueCode#"	ADDTOKEN="NO">
		<cfelse>
			Old and New Prefixes must be the same length
			<cfabort>
		</cfif>
	</cfif>
	--->
</cfif>
<!--- ====================================================================================================================================================== --->
<!--- InclLeagueInfo.cfm in InclBegin.cfm loads most of the LeagueInfo values 
but we need to load the password from zmast.identity --->
<cfset request.LeagueCodePrefix = LeagueCodePrefix >
<cfinclude template="queries/qry_QThisPWD.cfm">

<CFFORM NAME="LeagueInfoUpdate" ACTION="LeagueInfoUpdate.cfm" >
<cfoutput>
	<input type="Hidden" name="LeagueCode" value="#LeagueCode#">
	<input type="Hidden" name="ID" value="#QLeagueCode.ID#">
</cfoutput>
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="2">
<cfoutput query="QLeagueCode" >
	<!---                                       
	                                        ********************
	                                        *  SeasonStartDate *
	                                        ********************
	--->
		<tr>
			<td align="right"colspan="2">
				<span class="pix10bold">SeasonStartDate:</span>
			</td>
			<td align="left" colspan="2">
				<input type="Text" name="SeasonStartDate" value="#DateFormat( SeasonStartDate , "DD MMMM YYYY")#" size="20">
			</td>
		</tr>
	<!---                                       
	                                        ******************
	                                        *  SeasonEndDate *
	                                        ******************
	--->
		<tr>
			<td align="right"colspan="2">
				<span class="pix10bold">SeasonEndDate:</span>
			</td>
			<td align="left" colspan="2">
				<input type="Text" name="SeasonEndDate" value="#DateFormat( SeasonEndDate , "DD MMMM YYYY")#" size="20">
			</td>
		</tr>
	<!---                                       
	                                        *****************
	                                        *  CountiesList *
	                                        *****************
	--->
		<tr>
			<td align="right"colspan="2">
				<span class="pix10bold">CountiesList:</span>
			</td>
			<td align="left" colspan="2">
				<input type="Text" name="CountiesList" value="#CountiesList#" size="80"><BR>
				<span class="pix10">Remember that the first county is the default</span>
			
			</td>
		</tr>
	<!---                                       
	                                        *************
	                                        *  NameSort *
	                                        *************
	--->
		<tr>
			<td align="right"colspan="2">
				<span class="pix10bold">NameSort:</span>
			</td>
			<td align="left" colspan="2">
				<input type="Text" name="NameSort" value="#NameSort#" size="80">
				<cfif FindNoCase(",", NameSort) GT 0 >
					<span class="pix18boldred"><BR>ERROR: NameSort contains forbidden comma</span>
				</cfif>
				
			</td>
		</tr>	
	<!---                                       
	                                        ***************
	                                        *  LeagueName *
	                                        ***************
	--->
		<tr>
			<td align="right"colspan="2">
				<span class="pix10bold">LeagueName:</span>
			</td>
			<td align="left" colspan="2">
				<input type="Text" name="LeagueName" value="#LeagueName#" size="80"><BR>
				<span class="pix10">Contains sponsor's name</span>
				
				<cfif FindNoCase(",", LeagueName) GT 0 >
					<span class="pix18boldred"><BR>ERROR: LeagueName contains forbidden comma</span>
				</cfif>

			</td>
		</tr>	
	<!---                                       
	                                        ***************
	                                        *  BadgeJpeg  *
	                                        ***************
	--->
		<tr>
			<td align="right"colspan="2">
				<span class="pix10bold">BadgeJpeg:</span>
			</td>
			<td align="left" colspan="2">
				<input type="Text" name="BadgeJpeg" value="#BadgeJpeg#" size="8"><BR>
				<span class="pix10">same root as leaguecode else enter "blank" if none</span>
			</td>
		</tr>	

	<!---                                       
	                                        ****************
	                                        *  WebsiteLink *
	                                        ****************
	--->
		<tr>
			<td align="right"colspan="2">
				<span class="pix10bold">WebsiteLink:</span>
			</td>
			<td align="left" colspan="2">
				<input type="Text" name="WebsiteLink" value="#WebsiteLink#" size="50">
			</td>
		</tr>	

	<!---                                       
	                                        *************
	                                        *  Password *
	                                        *************
	--->
		<tr>
			<td align="right"colspan="2">
				<span class="pix10bold">Password:</span>
			</td>
			<td align="left" colspan="2">
				<input type="Text" name="Password" value="#ThisPWD#" size="15">
			</td>
		</tr>
	<!---                                       
	                                        **********************
	                                        *  DefaultDivisionID *
	                                        **********************
	--->
		<tr>
			<td align="right"colspan="2">
				<span class="pix10bold">DefaultDivisionID:</span>
			</td>
			<td align="left" colspan="2">
				<input type="Text" name="DefaultDivisionID" value="#DefaultDivisionID#" size="6">
			</td>
		</tr>	

	<!---                                       
	                                        *******************************
	                                        * Points for Win, Draw & Loss *
	                                        *******************************
	--->
		<tr>
						<td align="right"colspan="2">
<span class="pix10bold">Points for Win, Draw & Loss:</span></td>
			<td align="left" colspan="2">
				<table border="1" cellpadding="0" cellspacing="2">
					<tr>			
						<td align="left">
							
						</td>
						<td width="20">
							<input type="Text" name="PointsForWin" value="#PointsForWin#" size="1">
						</td>
						<td width="20">
							<input type="Text" name="PointsForDraw" value="#PointsForDraw#" size="1">
						</td>
						<td width="20">
							<input type="Text" name="PointsForLoss" value="#PointsForLoss#" size="1">
						</td>
					</tr>
				</table>
			</td>

		</tr>	

	<!---                                       
	                                        ************************
	                                        *  LeagueTblCalcMethod *
	                                        ************************
	--->
		<tr>
			<td align="right"colspan="2">
				<span class="pix10bold">LeagueTblCalcMethod:</span>
			</td>
			<td align="left" colspan="2">
			<SELECT NAME="LeagueTblCalcMethod"     size="1">
				<OPTION VALUE="Goal Difference" <cfif LeagueTblCalcMethod IS "Goal Difference">selected</cfif> >Goal Difference</OPTION>
				<OPTION VALUE="Goal Average" <cfif LeagueTblCalcMethod IS "Goal Average">selected</cfif> >Goal Average</OPTION>			
				<OPTION VALUE="No Method" <cfif LeagueTblCalcMethod IS "No Method">selected</cfif> >No Method</OPTION>			
				<OPTION VALUE="Two Points for a Win" <cfif LeagueTblCalcMethod IS "Two Points for a Win">selected</cfif> >Two Points for a Win</OPTION>			
			</select>
			</td>
		</tr>	
	<!---                                       
	                                        ***************
	                                        *  SeasonName *
	                                        ***************
	--->
		<tr>
			<td align="right"colspan="2">
				<span class="pix10bold">SeasonName:</span>
			</td>
			<td align="left" colspan="2">
				<input type="Text" name="SeasonName" value="#SeasonName#" size="15">
			</td>
		</tr>
		<tr>
		<td colspan="4">
			<table  border="0" align="center" cellpadding="2" cellspacing="2" >
				<tr bgcolor="Ghostwhite">
					<td align="RIGHT">
						<span class="pix10bold">DefaultYouthLeague:</span>
					</td>
					<td align="left">
						<input type="Text" name="DefaultYouthLeague" value="#DefaultYouthLeague#" size="1"><BR>
						<span class="pix10">0=No, 1=Yes</span>
					</td>
					<td align="RIGHT">
						<span class="pix10bold">DefaultGoalScorers:</span>
					</td>
					<td align="left">
						<input type="Text" name="DefaultGoalScorers" value="#DefaultGoalScorers#" size="1"><BR>
						<span class="pix10">0=No, 1=Yes</span>
					</td>
				</tr>	
				<tr bgcolor="white">
					<td align="RIGHT">
						<span class="pix10bold">RefMarksOutOfHundred:</span>
					</td>
					<td align="left">
						<input type="Text" name="RefMarksOutOfHundred" value="#RefMarksOutOfHundred#" size="1"><BR>
						<span class="pix10">0=No, 1=Yes</span>
					</td>
					<td align="RIGHT">
						<span class="pix10bold">SuppressTeamSheetEntry:</span>
					</td>
					<td align="left">
						<input type="Text" name="SuppressTeamSheetEntry" value="#SuppressTeamSheetEntry#" size="1"><BR>
						<span class="pix10">0=No, 1=Yes</span>
					</td>
				</tr>
				<tr bgcolor="Ghostwhite">
					<td align="RIGHT">
						<span class="pix10bold">SuppressRedYellowCardsEntry:</span>
					</td>
					<td align="left">
						<input type="Text" name="SuppressRedYellowCardsEntry" value="#SuppressRedYellowCardsEntry#" size="1"><BR>
						<span class="pix10">0=No, 1=Yes</span>
					</td>
					<td align="RIGHT">
						<span class="pix10bold">SuppressTeamCommentsEntry:</span>
					</td>
					<td align="left">
						<input type="Text" name="SuppressTeamCommentsEntry" value="#SuppressTeamCommentsEntry#" size="1"><BR>
						<span class="pix10">0=No, 1=Yes</span>
					</td>
				</tr>
				<tr bgcolor="white">
					<td align="RIGHT">
						<span class="pix10bold">SuppressTeamDetailsEntry:</span>
					</td>
					<td align="left">
						<input type="Text" name="SuppressTeamDetailsEntry" value="#SuppressTeamDetailsEntry#" size="1"><BR>
						<span class="pix10">0=No, 1=Yes</span>
					</td>
					<td align="RIGHT">
						<span class="pix10bold">SuppressKOTimeEntry:</span>
					</td>
					<td align="left">
						<input type="Text" name="SuppressKOTimeEntry" value="#SuppressKOTimeEntry#" size="1"><BR>
						<span class="pix10">0=No, 1=Yes</span>
					</td>
				</tr>
				<tr bgcolor="Ghostwhite">
					<td align="RIGHT">
						<span class="pix10bold">SuppressLeadingGoalscorers:</span>
					</td>
					<td align="left">
						<input type="Text" name="SuppressLeadingGoalscorers" value="#SuppressLeadingGoalscorers#" size="1"><BR>
						<span class="pix10">0=No, 1=Yes</span>
					</td>
					<td align="RIGHT">
						<span class="pix10bold">SuppressScorelineEntry:</span>
					</td>
					<td align="left">
						<input type="Text" name="SuppressScorelineEntry" value="#SuppressScorelineEntry#" size="1"><BR>
						<span class="pix10">0=No, 1=Yes</span>
					</td>
				</tr>
				<tr bgcolor="white">
					<td align="RIGHT">
						<span class="pix10bold">GoalrunTeamSheet (redundant):</span>
					</td>
					<td align="left">
						<input type="Text" name="GoalrunTeamSheet" value="#GoalrunTeamSheet#" size="1"><BR>
						<span class="pix10">0=display everyone<br>1=display goalscorers & star players only<br>2=don't display any team sheet appearance data</span>
					</td>
					<td align="right" bgcolor="pink">
						<span class="pix10bold">HideThisSeason:</span>
					</td>
					<td align="left" bgcolor="pink">
						<input type="Text" name="HideThisSeason" value="#HideThisSeason#" size="1"><BR>
						<span class="pix10">0=display to everyone, 1=display to administrators only</span>
					</td>
				</tr>
				<tr bgcolor="Ghostwhite">
					<td align="RIGHT">
						<span class="pix10bold">Player Re-Registration Form (.PDF):</span>
					</td>
					<td align="left">
						<input type="Text" name="NoPlayerReRegistrationForm" value="#NoPlayerReRegistrationForm#" size="1"><BR>
						<span class="pix10">0=allow, 1=suppress</span>
					</td>
					<td align="RIGHT">
						<span class="pix10bold">Show on Goalrun only? :</span >
					</td>
					<td align="left">
						<input type="Text" name="ShowOnGoalrunOnly" value="#ShowOnGoalrunOnly#" size="1"><BR>
						<span class="pix10">0=No(default), 1=Yes</span>
					</td>
				</tr>
				<tr bgcolor="white">
					<td align="RIGHT">
						<span class="pix10bold">MatchBasedSuspensions? :</span >
					</td>
					<td align="left">
						<input type="Text" name="MatchBasedSuspensions" value="#MatchBasedSuspensions#" size="1"><BR>
						<span class="pix10">0=No, 1=Yes</span>
					</td>
					<td align="RIGHT">
						<span class="pix10bold">ShowAssessor? :</span >
					</td>
					<td align="left">
						<input type="Text" name="ShowAssessor" value="#ShowAssessor#" size="1"><BR>
						<span class="pix10">0=No, 1=Yes</span>
					</td>
				</tr>
				<tr bgcolor="Ghostwhite">
					<td align="RIGHT">
						<span class="pix10bold">Hide Suspension Info:</span >
					</td>
					<td align="left">
						<input type="Text" name="HideSuspensions" value="#HideSuspensions#" size="1"><BR>
						<span class="pix10">0=No(default), 1=Yes</span>
					</td>
					<td align="RIGHT">
						<span class="pix10bold">Suspension starts after:</span >
					</td>
					<td align="left">
						<input type="Text" name="SuspensionStartsAfter" value="#SuspensionStartsAfter#" size="3"><BR>
						<span class="pix10"> number of days</span>
					</td>
				</tr>
				<tr bgcolor="white">
					<td align="RIGHT">
						<span class="pix10bold">KickOffTimeOrder:</span>
					</td>
					<td align="left">
						<input type="Text" name="KickOffTimeOrder" value="#KickOffTimeOrder#" size="1"><BR>
						<span class="pix10">0=No, 1=Yes</span>
					</td>
					<td align="RIGHT">
						<span class="pix10bold">Clubs can input Sportsmanship Marks:</span>
					</td>
					<td align="left">
						<input type="Text" name="ClubsCanInputSportsmanshipMarks" value="#ClubsCanInputSportsmanshipMarks#" size="1"><BR>
						<span class="pix10">0=No, 1=Yes</span>
					</td>
				</tr>
				
			<!---                                       
													***************
													*  LeagueType *
													***************
			--->
				<tr bgcolor="Ghostwhite">
					<td align="right">
						<span class="pix10bold">LeagueType:</span>
					</td>
					<td align="left">
					<SELECT NAME="LeagueType"  size="1">
						<OPTION VALUE="Normal" <cfif LeagueType IS "Normal">selected</cfif> >Normal</OPTION>
						<OPTION VALUE="Contributory" <cfif LeagueType IS "Contributory">selected</cfif> >Contributory</OPTION>			
					</select>
					</td>
			<!---                                       
													********************************
													*  VenueAndPitchAvailable Flag *
													********************************
			--->
					<td align="right">
						<span class="pix10bold">VenueAndPitchAvailable Flag:</span>
					</td>
					<td align="left">
						<input type="Text" name="VenueAndPitchAvailable" value="#VenueAndPitchAvailable#" size="1"><BR>
					</td>
				</tr>	
			<!---                                       
													**********************
													*  Email Alert       *
													**********************
			--->
				<tr bgcolor="white">
					<td align="right">
						<span class="pix10bold">Email Alert:</span>
					</td>
					<td align="left">
						<input type="Text" name="Alert" value="#Alert#" size="1"><BR>
					</td>
					
			<!---                                       
													**********************
													*  RandomPlayerRegNo *
													**********************
			--->
					<td align="right">
						<span class="pix10bold">RandomPlayerRegNo:</span>
					</td>
					<td align="left">
						<input type="Text" name="RandomPlayerRegNo" value="#RandomPlayerRegNo#" size="1"><BR>
					</td>
				</tr>


				<tr bgcolor="Ghostwhite">
					<td align="RIGHT">
						<span class="pix10bold">SportsmanshipMarksOutOfHundred:</span>
					</td>
					<td align="left">
						<input type="Text" name="SportsmanshipMarksOutOfHundred" value="#SportsmanshipMarksOutOfHundred#" size="1"><BR>
						<span class="pix10">0=No, 1=Yes</span>
					</td>
					
			<!---                                       
													*******************
													*  FANPlayerRegNo *
													*******************
			--->
					
					<td align="right">
						<span class="pix10bold">FANPlayerRegNo:</span>
					</td>
					<td align="left">
						<input type="Text" name="FANPlayerRegNo" value="#FANPlayerRegNo#" size="1"><BR><span class="pix10">0=No, 1=Yes</span>
					</td>
				</tr>

				<tr bgcolor="white">
			<!---                                       
													*****************************
													*  Referee Low Mark Warning *
													*****************************
			--->
				
					<td align="right">
						<span class="pix10bold">Referee Low Mark Warning:</span>
					</td>
					<td align="left">
						<input type="Text" name="RefereeLowMarkWarning" value="#RefereeLowMarkWarning#" size="1"><BR>
					</td>
					
			<!---                                       
													*****************************
													* See Opposition Team Sheet *
													*****************************
			--->
					<td align="right">
						<span class="pix10bold">See Opposition Team Sheet:</span>
					</td>
					<td align="left">
						<input type="Text" name="SeeOppositionTeamSheet" value="#SeeOppositionTeamSheet#" size="1"><BR>
					</td>
				</tr>
				<tr bgcolor="white">
			<!---                                       
													*********************************
													*  Referee Mark must be Entered *
													*********************************
			--->
				
					<td align="right">
						<span class="pix10bold">Referee Mark must be Entered:</span>
					</td>
					<td align="left">
						<input type="Text" name="RefereeMarkMustBeEntered" value="#RefereeMarkMustBeEntered#" size="1"><BR>
					</td>
					
			<!---                                       
													*****************************
													* spare01                   *
													*****************************
			--->
					<td align="right">
						<span class="pix10bold">spare01:</span>
					</td>
					<td align="left">
						<input type="Text" name="spare01" value="#spare01#" size="1"><BR>
					</td>
				</tr>
				<tr bgcolor="white">
			<!---                                       
													*********************************
													*  spare02                      *
													*********************************
			--->
				
					<td align="right">
						<span class="pix10bold">spare02:</span>
					</td>
					<td align="left">
						<input type="Text" name="spare02" value="#spare02#" size="1"><BR>
					</td>
					
			<!---                                       
													******************************
													* Hide Double Header Message *
													******************************
			--->
					<td align="right">
						<span class="pix10bold">HideDoubleHdrMsg:</span>
					</td>
					<td align="left">
						<input type="Text" name="HideDoubleHdrMsg" value="#HideDoubleHdrMsg#" size="1"><BR>
					</td>
				</tr>

			</table>
		</td>
	</tr>
</cfoutput>
</table>
	
<cfoutput>
	<!---
								*************
								* OK Button *
								*************
	--->
<table width="100%" border="0" cellspacing="0"  align="CENTER">
	<tr>
		<td height="40" align="CENTER">
			<input type="Submit" name="Button" value="Update">
		</td>
		<td height="40" align="CENTER">
			<input type="Reset" name="Button" value="Reset">
		</td>
	</tr>
</table>
</cfoutput>
</cfform>

