<SCRIPT type="text/javascript" src="CalendarPopup.js"></SCRIPT>	
<INPUT TYPE="HIDDEN" NAME="HomeID" VALUE="<cfoutput>#URL.HomeID#</cfoutput>">
<INPUT TYPE="HIDDEN" NAME="AwayID" VALUE="<cfoutput>#URL.AwayID#</cfoutput>">
<INPUT TYPE="HIDDEN" NAME="DivisionID" VALUE="<cfoutput>#URL.DivisionID#</cfoutput>">
<INPUT TYPE="HIDDEN" NAME="SeasonStart" VALUE="<cfoutput>#SeasonStartDate#</cfoutput>">
<INPUT TYPE="HIDDEN" NAME="SeasonFinish" VALUE="<cfoutput>#SeasonEndDate#</cfoutput>">
<cfinclude template="queries/qry_GetCompetitType.cfm">
<cfinclude template="queries/qry_GetKORnd.cfm">
<!--- Get Notes from newsitem table for this league where longcol is 'TeamComments' --->
<cfinclude template="queries/qry_QTeamComments.cfm">
<cfif QTeamComments.RecordCount IS 1>
	<cfset ThisText = Trim(QTeamComments.Notes) >
<cfelse>
	<cfset ThisText = '' >
</cfif>
<cfset FID = URL.ID >
<cfinclude template="queries/qry_QFixtureDate.cfm">
<cfif QFixtureDate.RecordCount IS 0>
	<span class="pix24boldred">Fixture has been deleted</span>
	<CFABORT>
</cfif>
<cfinclude template="queries/qry_GetReferee.cfm">

<!--- added by Terry for push to Goalrun --->
<input type="hidden" name="beforeHomeGoals" value="<cfoutput>#QFixtureDate.HomeGoals#</cfoutput>">
<input type="hidden" name="beforeAwayGoals" value="<cfoutput>#QFixtureDate.AwayGoals#</cfoutput>">
 
<cfif VenueAndPitchAvailable IS "Yes" <!--- AND UCase(QFixtureDate.HomeGuest) IS NOT "GUEST" ---> >
	<cfset ThisTeamID = QFixtureDate.ThisTeamID >
	<cfset ThisOrdinalID = QFixtureDate.ThisOrdinalID >
	<cfset ThisDate = DateFormat(QFixtureDate.FixtureDate, 'YYYY-MM-DD') >
	<cfinclude template="queries/qry_FixturePitchAvailability.cfm">
</cfif>


<input type="HIDDEN" name="Result" value="<cfoutput>#QFixtureDate.Result#</cfoutput>">
<!--- the DELETE button will be disabled if any of these have no null or non zero values --->
<cfif	QFixtureDate.RefereeMarksH  IS NOT "" OR
		QFixtureDate.RefereeMarksA  IS NOT "" OR
		QFixtureDate.AsstRef1Marks  IS NOT "" OR
		QFixtureDate.AsstRef2Marks  IS NOT "" OR
		QFixtureDate.AsstRef1MarksH IS NOT "" OR
		QFixtureDate.AsstRef1MarksA IS NOT "" OR
		QFixtureDate.AsstRef2MarksH IS NOT "" OR
		QFixtureDate.AsstRef2MarksA IS NOT "" OR
		QFixtureDate.Attendance     IS NOT "" OR
		QFixtureDate.HomeSportsmanshipMarks   IS NOT "" OR
		QFixtureDate.AwaySportsmanshipMarks   IS NOT "" OR
		QFixtureDate.AssessmentMarks          IS NOT "" OR
		QFixtureDate.HomeClubOfficialsBenches IS NOT "" OR
		QFixtureDate.AwayClubOfficialsBenches IS NOT "" OR
		QFixtureDate.StateOfPitch     IS NOT "" OR
		QFixtureDate.ClubFacilities   IS NOT "" OR
		QFixtureDate.Hospitality      IS NOT "" OR
		QFixtureDate.HospitalityMarks IS NOT "" OR	  
		QFixtureDate.MatchOfficialsExpenses IS NOT 0 OR
		QFixtureDate.AppearanceCount        IS NOT 0 >
		<cfset request.showdelete = 0>
</cfif>
<!--- season dates - less one for start, plus one for end - this info used in calendar to block non-season dates! --->
<cfset LOdate = DateAdd('D', -1, SeasonStartDate) >
<cfset HIdate = DateAdd('D',  1, SeasonEndDate) >
<SCRIPT type="text/javascript">
	// note date type on disable calls
	<cfoutput>
	var cal1 = new CalendarPopup(); 
	cal1.addDisabledDates(null, '#LSDateFormat(LOdate, "mmm dd, yyyy")#'); 
	cal1.addDisabledDates('#LSDateFormat(HIdate, "mmm dd, yyyy")#', null);
	cal1.offsetX = 75;
	cal1.offsetY = -150;
	</cfoutput>
</SCRIPT>

<table width="100%" border="0" cellspacing="0" cellpadding="0" align="CENTER" class="loggedinScreen">

	<!--- e.g. Middlesex Federation Football League Cup Group 2 --->
	<tr align="center"><td><cfoutput><span class="pix13bold">#ThisCompetitionDescription#</span></cfoutput></td></tr>
	<tr>
  		<td align="center">
			<table>
				<tr> 
					<td align="center"><span class="pix13bold"><cfoutput>#DateFormat(QFixtureDate.FixtureDate, "DDDD, DD MMMM YYYY")#</cfoutput></span>
					<span class="pix13bold"> - KO Time <input name="KOTime" type="text" value="<cfoutput>#TimeFormat(QFixtureDate.KOTime, 'h:mm TT')#</cfoutput>" size="7"></span><span class="pix9"> e.g. 10:30 or 15:00 or 7:30 PM</span></td>
				</tr>
				<tr>
          			<td align="center"> <span class="pix13"> <a href="javascript:void(0);" onClick="cal1.select(terry.datebox,'anchor1','EE, dd MMM yyyy'); return true;" NAME="anchor1" ID="anchor1"> 
            			move to</a> 
            			<input name="datebox" type="text" size="30" readonly="true" value=<cfoutput>"#DateFormat(QFixtureDate.FixtureDate, 'DDDD, DD MMMM YYYY')#"</cfoutput> >
            			</span><br /><span class="pix9">To force through a fixture date change and to suppress the warning message tick here</span><input type="checkbox" name="DateCheckSuppress">
					</td>
				</tr>

			</table>
		</td>
	</tr>
	<cflock scope="session" timeout="10" type="exclusive">
		<cfset session.CurrentDate = QFixtureDate.FixtureDate>
	</cflock>

	<tr> 
		<!--- this is the Team Name, Team Sheet and score boxes section --->
		<td  valign="top"> 
			<table width="100%" border="0" align="center" cellpadding="2" cellspacing="0">
				<tr> 
          			<!---
						*********************
						* Home Team+Ordinal *
						*********************
					--->
					<cfif UCase(QFixtureDate.HomeGuest) IS "GUEST">
						<td width="40%" align="right"><span class="pix18bold"><cfoutput><em>#QFixtureDate.HomeTeam# #QFixtureDate.HomeOrdinal#</em></cfoutput></span></td>
					<cfelse>
						<td width="40%" align="right"><span class="pix18bold"><cfoutput>#QFixtureDate.HomeTeam# #QFixtureDate.HomeOrdinal#</cfoutput></span></td>
					</cfif>
					<!---
						*******************
						* Home Team Sheet *
						*******************
					--->
						<td width="4%" align="CENTER">
							<a href=<cfoutput>"TeamList.cfm?LeagueCode=#LeagueCode#&FID=#URL.ID#&HA=H&DivisionID=#DivisionID#"</cfoutput> ><img src="gif/TeamSheet.gif" alt="Team Sheet" width="35" height="23" border="1" align="top"></a>
						</td>
					<!---
						**************
						* Home Score *
						**************
					--->
					<td width="4%" align="RIGHT">
						<cfinput type="Text" name="HomeGoals" value="#QFixtureDate.HomeGoals#" message="Home goals invalid" validate="integer" required="No" size="1" maxlength="2">
					</td>
					<!---
						**********
						* VERSUS *
						**********
					--->
					<td width="2%" align="CENTER">
						<span class="pix13boldnavy">v</span>
					</td>
          			<!---
						**************
						* Away Score *
						**************
					--->
					<td width="4%" align="LEFT">
						<cfinput type="Text" name="AwayGoals" value="#QFixtureDate.AwayGoals#" message="Away goals invalid" validate="integer" required="No" size="1" maxlength="2">
					</td>
					<!---
						*******************
						* Away Team Sheet *
						*******************
					--->
						<td width="4%" align="CENTER">
							<a href=<cfoutput>"TeamList.cfm?LeagueCode=#LeagueCode#&FID=#URL.ID#&HA=A&DivisionID=#DivisionID#"</cfoutput>><img src="gif/TeamSheet.gif" alt="Team Sheet" width="35" height="23" border="1" align="top"></a>
						</td>
          			<!---
						*********************
						* Away Team+Ordinal *
						*********************
					--->
					<cfif UCase(QFixtureDate.AwayGuest) IS "GUEST">
						<td width="40%" align="left"><span class="pix18bold"><cfoutput><em>#QFixtureDate.AwayTeam# #QFixtureDate.AwayOrdinal#</em></cfoutput></span></td>
					<cfelse>
						<td width="40%" align="left"><span class="pix18bold"><cfoutput>#QFixtureDate.AwayTeam# #QFixtureDate.AwayOrdinal#</cfoutput></span></td>
					</cfif>
				</tr>
				
				
				
					<cfif VenueAndPitchAvailable IS "No" <!--- OR UCase(QFixtureDate.HomeGuest) IS "GUEST" ---> >
						<INPUT TYPE="HIDDEN" NAME="PitchAvailableID" VALUE=0 >
					<cfelse>
						<!--- get the default venue and pitch no. IDs for the home team --->
						<cfinclude template="queries/qry_TeamDetails.cfm">
						<tr>
							<cfif FixturePitchAvailability.RecordCount IS 0>
								<INPUT TYPE="HIDDEN" NAME="PitchAvailableID" VALUE=0 >
								<td colspan="1">&nbsp;</td>
								<td colspan="5" align="center" bgcolor="lightgreen">
								<cfoutput>
									<a href="UpdateForm.cfm?TblName=PitchAvailable&LeagueCode=#LeagueCode#&VenueID=#QTeamDetails.VenueID#&TeamID=#QFixtureDate.ThisTeamID#&OrdinalID=#QFixtureDate.ThisOrdinalID#&PA=Team&PitchNoID=#QTeamDetails.PitchNoID#&PitchStatusID=0&FixtureDate=#DateFormat(QFixtureDate.FixtureDate, 'YYYY-MM-DD')#"><span class="pix10boldred">Add a Pitch for this Fixture</span></a>
								</cfoutput>
								</td>
								<td colspan="1">&nbsp;</td>
							<cfelseif FixturePitchAvailability.RecordCount IS 1 >
								<cfoutput>
									<INPUT TYPE="HIDDEN" NAME="PitchAvailableID" VALUE=#FixturePitchAvailability.FPA_ID# >
									<td colspan="1">&nbsp;</td>
									<td colspan="5" align="center" bgcolor="lightgreen">
										<span class="pix10">#FixturePitchAvailability.VenueName#</span>
										<cfif Trim(FixturePitchAvailability.PitchName) IS "1">
										<cfelse>
											<span class="pix10">(Pitch #Trim(FixturePitchAvailability.PitchName)#)</span>
										</cfif>
										<cfif Trim(FixturePitchAvailability.PitchStatus) IS "OK">
										<cfelse>
											<span class="pix13boldred">#FixturePitchAvailability.PitchStatus#</span>
										</cfif>
										<br /><a href="PitchAvailableList.cfm?LeagueCode=#LeagueCode#&ThisFixtureDate=#DateFormat(QFixtureDate.FixtureDate, 'YYYY-MM-DD')#&TeamID=#QFixtureDate.ThisTeamID#&OrdinalID=#QFixtureDate.ThisOrdinalID#&PA=Team">
										<span class="pix10">upd/del</span></a>
									</td>
									<td colspan="1">&nbsp;</td>
								</cfoutput>
							<cfelse>
								<td colspan="7" align="center"><span class="pix10">Venue(PitchNo) Status</span><br />
								<select name="PitchAvailableID" size="1">
									<cfoutput query="FixturePitchAvailability">
										<option <cfif FPA_ID IS #QFixtureDate.PitchAvailableID#>selected</cfif> value=#FPA_ID#>#FixturePitchAvailability.VenueName#(#Trim(FixturePitchAvailability.PitchName)#) #FixturePitchAvailability.PitchStatus#</option>
									</cfoutput>
								</select>
								<cfoutput>
									<a href="PitchAvailableList.cfm?LeagueCode=#LeagueCode#&TeamID=#QFixtureDate.ThisTeamID#&OrdinalID=#QFixtureDate.ThisOrdinalID#&PA=Team"><span class="pix10">upd/del</span></a>
								</cfoutput>
								</td>
					
								
							</cfif>
						</tr>
					</cfif>
				
			</table>
		</td>
	</tr>
	<tr>
		<cfif Left(GetCompetitType.Notes,2) IS "KO">
			<td align="center" valign="top" bgcolor="beige">
				<span class="pix9">If this match is decided on penalties then use the score boxes above to show the AET drawn result.<br>
				Put the FT, AET and penalties scores in the Notes Section and then click on the appropriate "penalty kicks" button.
				</span>
			</td>
		</cfif>
	</tr>
	<cfif Left(GetCompetitType.Notes,2) IS "KO">
		<tr> 
			<td align="center">
				<table>
					<tr>
					<!---
					*****************************
					* Knock Out round Pull Down *
					*****************************
					--->
						<td align="CENTER"><span class="pix9">KO Round<BR></span>
							<select name="KORoundID" size="1">
							<cfoutput query="GetKORnd" > 
							  <option value="#GetKORnd.ID#"<cfif GetKORnd.LongCol IS #QFixtureDate.RoundName#>selected</cfif>>#GetKORnd.LongCol#</option>
							</cfoutput>
							</select>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	<cfelse>
		<input type="HIDDEN" name="KORoundID" value="<cfoutput>#GetKORnd.ID#</cfoutput>">
	</cfif>
	<tr>
		<td align="center">
			<table>
						<!---
							***********************
							* Text area for Notes *
							***********************
						--->
				<tr>
					<td align="right"><span class="pix10navy"><strong>PUBLIC</strong> Notes<br>Max. 255 characters<br>Don't use for Match Reports</span></td>
 					<td><textarea name="TextNotes" cols="80" rows="1" wrap="virtual"><cfoutput>#QFixtureDate.FixtureNotes#</cfoutput></textarea></td>
				</tr>
				<tr>
					<td align="right"><span class="pix10navy"><strong>PRIVATE</strong> Notes<br>Max. 255 characters<br>Hidden from the public</span></td>
 					<td><textarea name="PrivateNotes" cols="80" rows="1" wrap="virtual"><cfoutput>#QFixtureDate.PrivateNotes#</cfoutput></textarea></td>
				</tr>
				<cfif Len(Trim(QFixtureDate.HomeTeamNotes)) IS 0 AND QTeamComments.RecordCount IS 0 >
					<INPUT TYPE="HIDDEN" NAME="HomeTeamNotes" VALUE="" >
				<cfelseif Len(Trim(QFixtureDate.HomeTeamNotes)) IS 0 AND QTeamComments.RecordCount IS 1 >
					<tr>
						<td align="right"><span class="pix10navy">Home Team's notes</span></td>
						<td><textarea name="HomeTeamNotes" cols="80" rows="1" wrap="virtual"><cfoutput>#ThisText#</cfoutput></textarea></td>
					</tr>
				<cfelse>
					<tr>
						<td align="right"><span class="pix10navy">Home Team's notes</span></td>
						<td><textarea name="HomeTeamNotes" cols="80" rows="1" wrap="virtual"><cfoutput>#QFixtureDate.HomeTeamNotes#</cfoutput></textarea></td>
					</tr>
				</cfif>
				<cfif Len(Trim(QFixtureDate.AwayTeamNotes)) IS 0 AND QTeamComments.RecordCount IS 0 >
					<INPUT TYPE="HIDDEN" NAME="AwayTeamNotes" VALUE="" >
				<cfelseif Len(Trim(QFixtureDate.AwayTeamNotes)) IS 0 AND QTeamComments.RecordCount IS 1 >
					<tr>
						<td align="right"><span class="pix10navy">Away Team's notes</span></td>
						<td><textarea name="AwayTeamNotes" cols="80" rows="1" wrap="virtual"><cfoutput>#ThisText#</cfoutput></textarea></td>
					</tr>
				<cfelse>
					<tr>
						<td align="right"><span class="pix10navy">Away Team's notes</span></td>
						<td><textarea name="AwayTeamNotes" cols="80" rows="1" wrap="virtual"><cfoutput>#QFixtureDate.AwayTeamNotes#</cfoutput></textarea></td>
					</tr>
				</cfif>
			</table>
		</td>
	</tr>
    <!---
	************************************************
	* Referees and Assistant Referees 3 Pull Downs *
	************************************************
	--->
	<tr bgcolor="Silver">
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="10%" align="right"><span class="pix10bold">Referee&nbsp;</td></span>
					<td width="13%">
						<table border="0" align="center" cellpadding="2" cellspacing="0" >
							<tr>
								<cfif RIGHT(request.dsn,4) GE 2012>		<!--- applies to season 2012 onwards only --->
									<cfoutput>
										<cfif QFixtureDate.RefereeReportReceived IS 1 > <!--- Match report received?  Yes --->
											<td bgcolor="silver">
												<span class="pix10bold">Match report received? 
													Yes <input name="RefereeReportReceived" type="radio" value=1 checked >
													No  <input name="RefereeReportReceived" type="radio" value=0 >
												</span>
											</td>
										<cfelse> <!--- Match report received?  No --->
											<td bgcolor="gray">
												<span class="pix10boldwhite">Match report received? 
													Yes<input name="RefereeReportReceived" type="radio" value=1 >
													No <input name="RefereeReportReceived" type="radio" value=0 checked >
												</span>
											</td>
										</cfif>
									</cfoutput>
								</cfif>
							</tr>
						</table>
					</td>
					<td  width="23%" align="CENTER"><span class="pix10bold">Assist. Referee 1</span></td>
					<td  width="23%" align="CENTER"><span class="pix10bold">Assist. Referee 2</span></td>
					<td  width="23%" align="CENTER"><span class="pix10bold">Fourth Official</span></td>
					<td  width="8%" align="center" bgcolor="black"><span class="pix10boldwhite">Match Officials<br />Expenses</span></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr bgcolor="Silver"> 
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="top">
					<td width="23%" align="CENTER">
						<img src="images/icon_referee.png" border="0" align="absmiddle"> 
						<select name="RefereeID" size="1"><cfoutput query="GetReferee"><option value="#GetReferee.ID#"<cfif GetReferee.LongCol IS #QFixtureDate.RefName#>selected</cfif><cfif GetReferee.Available IS "No">Disabled</cfif>  <cfif GetReferee.Available IS "Yes">class="bg_reallightgreen"<cfelseif GetReferee.Available IS "No">class="bg_pink"</cfif>>#GetReferee.LongCol#</option></cfoutput></select>
					</td>
					<!---
					Asst. Referee 1
					--->
					<td width="23%" align="CENTER">
						<img src="images/icon_line1.png" border="0" align="absmiddle"> 
						<select name="AsstRef1ID" size="1"><cfoutput query="GetReferee"><option value="#GetReferee.ID#"<cfif GetReferee.LongCol IS #QFixtureDate.AsstRef1Name#>selected</cfif><cfif GetReferee.Available IS "No">Disabled</cfif>  <cfif GetReferee.Available IS "Yes">class="bg_reallightgreen"<cfelseif GetReferee.Available IS "No">class="bg_pink"</cfif>>#GetReferee.LongCol#</option></cfoutput></select>
					</td>
					<!---
					Asst. Referee 2
					--->
					<td width="23%" align="CENTER">
						<img src="images/icon_line2.png" border="0" align="absmiddle"> 
						<select name="AsstRef2ID" size="1"><cfoutput query="GetReferee"><option value="#GetReferee.ID#"<cfif GetReferee.LongCol IS #QFixtureDate.AsstRef2Name#>selected</cfif><cfif GetReferee.Available IS "No">Disabled</cfif>  <cfif GetReferee.Available IS "Yes">class="bg_reallightgreen"<cfelseif GetReferee.Available IS "No">class="bg_pink"</cfif>>#GetReferee.LongCol#</option></cfoutput></select>
					</td>
					<!---
					Fourth Official
					--->
					<td width="23%" align="CENTER">
						<img src="images/icon_4th.png" border="0" align="absmiddle"> 
						<select name="FourthOfficialID" size="1"><cfoutput query="GetReferee"><option value="#GetReferee.ID#"<cfif GetReferee.LongCol IS #QFixtureDate.FourthOfficialName#>selected</cfif><cfif GetReferee.Available IS "No">Disabled</cfif>  <cfif GetReferee.Available IS "Yes">class="bg_reallightgreen"<cfelseif GetReferee.Available IS "No">class="bg_pink"</cfif>>#GetReferee.LongCol#</option></cfoutput></select>
					</td>

					<td width="8%" align="CENTER">
						<cfinput name="MatchOfficialsExpenses" type="text" value="#QFixtureDate.MatchOfficialsExpenses#" size="3" maxlength="6" >
					</td>

				</tr>
			</table>
		</td>
	</tr>
	<tr bgcolor="Silver">
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="top"> 
					<td width="23%" valign="top" align="CENTER">
						<span class="pix10bold">Marks H</span> 
						<!---
						Referees Marks from Home Team
						--->
						<cflock scope="session" timeout="10" type="readonly">
							<cfset request.LeagueType = session.LeagueType >
							<cfset request.RefMarksOutOfHundred = session.RefMarksOutOfHundred>
							<cfset request.SportsmanshipMarksOutOfHundred = session.SportsmanshipMarksOutOfHundred>							
						</cflock> 
						<cfif request.RefMarksOutOfHundred IS "Yes">
							<cfinput type="Text" name="RefereeMarksH" value="#QFixtureDate.RefereeMarksH#" message="Referee's marks from Home team must be 0 to 100" validate="integer" range="0,100" required="No" size="2" maxlength="3">
						<cfelse>
							<cfinput type="Text" name="RefereeMarksH" value="#QFixtureDate.RefereeMarksH#" message="Referee's marks from Home team must be 0 to 10" validate="integer" range="0,10" required="No" size="1" maxlength="2">
						</cfif>
						<!---
						Referees Marks from Away Team
						--->
						<span class="pix10bold">A</span>
						<cfif request.RefMarksOutOfHundred IS "Yes">
							<cfinput type="Text" name="RefereeMarksA" value="#QFixtureDate.RefereeMarksA#" message="Referee's marks from Away team must be 0 to 100" validate="integer" range="0,100" required="No" size="2" maxlength="3">
						<cfelse>
							<cfinput type="Text" name="RefereeMarksA" value="#QFixtureDate.RefereeMarksA#" message="Referee's marks from Away team must be 0 to 10" validate="integer" range="0,10" required="No" size="1" maxlength="2">
						</cfif>
					</td>

						<cfswitch expression="#request.LeagueType#">
							<cfcase value="Normal">
								<INPUT TYPE="HIDDEN" NAME="AsstRef1MarksH" VALUE="">
								<INPUT TYPE="HIDDEN" NAME="AsstRef1MarksA" VALUE="">
								<INPUT TYPE="HIDDEN" NAME="AsstRef2MarksH" VALUE="">
								<INPUT TYPE="HIDDEN" NAME="AsstRef2MarksA" VALUE="">
									<!---
									Asst. Referee 1
									--->
									<td width="23%" valign="top" align="CENTER"><span class="pix10bold">Marks</span>
										<!---
										Asst. Referee 1 Marks
										--->
										<cfif request.RefMarksOutOfHundred IS "Yes">
											<cfinput type="Text" name="AsstRef1Marks" value="#QFixtureDate.AsstRef1Marks#" message="Assist. Referee 1's marks must be 0 to 100" validate="integer" range="0,100" required="No" size="2" maxlength="3">
										<cfelse>
											<cfinput type="Text" name="AsstRef1Marks" value="#QFixtureDate.AsstRef1Marks#" message="Assist. Referee 1's marks must be 0 to 10" validate="integer" range="0,10" required="No" size="1" maxlength="2">
										</cfif>
				
									</td>
									<!---
									Asst. Referee 2
									--->
									<td width="23%" valign="top" align="CENTER"><span class="pix10bold">Marks</span>
										<!---
										Asst. Referee 2 Marks
										--->
										<cfif request.RefMarksOutOfHundred IS "Yes">
											<cfinput type="Text" name="AsstRef2Marks" value="#QFixtureDate.AsstRef2Marks#" message="Assist. Referee 2's marks must be 0 to 100" validate="integer" range="0,100" required="No" size="2" maxlength="3">
										<cfelse>
											<cfinput type="Text" name="AsstRef2Marks" value="#QFixtureDate.AsstRef2Marks#" message="Assist. Referee 2's marks must be 0 to 10" validate="integer" range="0,10" required="No" size="1" maxlength="2">
										</cfif>
									</td>
									<td width="31%" valign="top" align="CENTER"><span class="pix10bold">&nbsp;</span>
									
							</cfcase>
							<cfcase value="Contributory">
								<INPUT TYPE="HIDDEN" NAME="AsstRef1Marks" VALUE="">
								<INPUT TYPE="HIDDEN" NAME="AsstRef2Marks" VALUE="">
									<!---
									Asst. Referee 1
									--->
									<td width="23%" valign="top" align="CENTER"><span class="pix10bold">Marks H</span>
										<!---
										Asst. Referee 1 Marks from Home Team and from Away Team
										--->
										<cfinput type="Text" name="AsstRef1MarksH" value="#QFixtureDate.AsstRef1MarksH#" message="Asst. Referee 1 Marks from Home Team must be 0 to 100" validate="integer" range="0,100" required="No" size="2" maxlength="3">
										<span class="pix10bold">A</span>
										<cfinput type="Text" name="AsstRef1MarksA" value="#QFixtureDate.AsstRef1MarksA#" message="Asst. Referee 1 Marks from Away Team must be 0 to 100" validate="integer" range="0,100" required="No" size="2" maxlength="3">
									</td>
									<!---
									Asst. Referee 2
									--->
									<td width="23%" valign="top" align="CENTER"><span class="pix10bold">Marks H</span>
										<!---
										Asst. Referee 2 Marks from Home Team and from Away Team
										--->
										<cfinput type="Text" name="AsstRef2MarksH" value="#QFixtureDate.AsstRef2MarksH#" message="Asst. Referee 2 Marks from Home Team must be 0 to 100" validate="integer" range="0,100" required="No" size="2" maxlength="3">
										<span class="pix10bold">A</span>
										<cfinput type="Text" name="AsstRef2MarksA" value="#QFixtureDate.AsstRef2MarksA#" message="Asst. Referee 2 Marks from Away Team must be 0 to 100" validate="integer" range="0,100" required="No" size="2" maxlength="3">
									</td>
									<td width="31%" valign="top" align="CENTER"><span class="pix10bold">&nbsp;</span>
									
							</cfcase>
							<cfdefaultcase>
								Reached defaultcase in InclSchedule01 - Aborting
								<CFABORT>	
							</cfdefaultcase>
						</cfswitch>
					
					<!---
					Fourth Official
					--->
					<td width="23%" valign="top" align="CENTER"><span class="pix10bold">&nbsp;</span>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<cfif request.RefMarksOutOfHundred IS "Yes">
		<tr bgcolor="silver">
			<td>
				<table border="0" cellpadding="2" cellspacing="1" bgcolor="black">
					<tr>
						<td bgcolor="white">
							<span class="pix9">Referee and Assistant Referee marks are out of 100</span>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	<cfelse>
		<tr bgcolor="silver">
			<td>
				<table border="0" cellpadding="2" cellspacing="1" bgcolor="black">
					<tr>
						<td bgcolor="white">
							<span class="pix9">Referee and Assistant Referee marks are out of 10</span>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		
	</cfif>
	<!---
	**********************************
	* Assessor and Assessment Marks  *
	**********************************
	--->
	<cfif request.LeagueType IS "Contributory" >
		<tr bgcolor="silver">
			<td height="40">
				<table width="25%" border="0" cellpadding="0" cellspacing="0">
					<tr >
						<td align="CENTER"><span class="pix10bold">Assessor</span></td>
						<td align="CENTER"><span class="pix10bold">Marks</span></td>
						
					</tr>
					<tr>
						<td>
							&nbsp;<img src="images/icon_assesment.png" border="0" align="absmiddle">
							<select name="AssessorID" size="1"><cfoutput query="GetReferee"><option value="#GetReferee.ID#"<cfif GetReferee.LongCol IS #QFixtureDate.AssessorName#>selected</cfif><cfif GetReferee.Available IS "No">Disabled</cfif>  <cfif GetReferee.Available IS "Yes">class="bg_reallightgreen"<cfelseif GetReferee.Available IS "No">class="bg_pink"</cfif>>#GetReferee.LongCol#</option></cfoutput></select>
						</td>
						<td align="center">
							<cfinput type="Text" name="AssessmentMarks" value="#QFixtureDate.AssessmentMarks#" message="Assessment marks must be 0 to 100" validate="integer" range="0,100" required="No" size="2" maxlength="3">
						</td>
					</tr>
				</table>
			</td>
		</tr>
	<cfelse>
		<!--- get the ID of the "blank" referee i.e. No Referee --->
		<cfinclude template="queries/qry_QCheckRef.cfm">
		<cfoutput>
			<INPUT TYPE="HIDDEN" NAME="AssessorID" VALUE="#QCheckRef.ID#">
		</cfoutput>
		<INPUT TYPE="HIDDEN" NAME="AssessmentMarks" VALUE="">
	</cfif>
	
	<tr bgcolor="Gray">
	<!---
	*********************************************************
	* Attendance, Hospitality and Sportsmanship Marks area  *
	*********************************************************
	--->
		<td>
			<table width="100%">
				<tr>
				
				<!---
					**************
					* Attendance *
					**************
				--->
					<td width="10%" align="RIGHT">
						<span class="pix10white">Attendance</span>
					</td>
					<td width="6%" align="Left">
						<cfinput type="Text" name="Attendance" value="#QFixtureDate.Attendance#" message="Attendance must be numeric" validate="integer" range="0,65000" required="No" size="3" maxlength="5">
					</td>
				<!---
					*********************
					* Hospitality Marks *
					*********************
				--->
					<td width="10%" align="RIGHT">
						<span class="pix10white">Hospitality Marks</span>
					</td>
					<td width="6%" align="Left">
						<cfinput type="Text" name="HospitalityMarks" value="#QFixtureDate.HospitalityMarks#" message="Hospitality Marks must be 0 to 100" validate="integer" range="0,100" required="No" size="3" maxlength="3">
					</td>
					
				<!---
					***************************************************
					* Contributory League Referee's Report Section    *
					***************************************************
				--->
				<cfif request.LeagueType IS "Contributory" >
					<td width="36%" align="center">
						<table width="100%" border="1" cellpadding="1" cellspacing="1" bgcolor="white">
							<tr>
								<td colspan="2" bgcolor="Gray"><span class="pix9">&nbsp;</span></td>
								<td colspan="1" align="center" bgcolor="silver"><span class="pix10white">Untick</span></td>
								<td align="center"><span class="pix10bold">Excllnt</span></td>
								<td align="center"><span class="pix10bold">Good</span></td>
								<td align="center"><span class="pix10bold">Satisf</span></td>
								<td align="center"><span class="pix10bold">Poor</span></td>
							</tr>

							<tr>
								<td rowspan="2"><span class="pix10bold">Club Officials / Benches</span></td>
								<td align="center"><span class="pix10bold">Home</span></td>
								<td align="center" bgcolor="silver"><span class="pix10bold"><INPUT NAME="HomeClubOfficialsBenches" TYPE="radio" VALUE="" <cfif QFixtureDate.HomeClubOfficialsBenches IS "" >checked</cfif>></span></td>
								<td align="center"><span class="pix10bold"><INPUT NAME="HomeClubOfficialsBenches" TYPE="radio" VALUE="Excellent" <cfif QFixtureDate.HomeClubOfficialsBenches IS "Excellent" >checked</cfif>></span></td>
								<td align="center"><span class="pix10bold"><INPUT NAME="HomeClubOfficialsBenches" TYPE="radio" VALUE="Good" <cfif QFixtureDate.HomeClubOfficialsBenches IS "Good" >checked</cfif>></span></td>
								<td align="center"><span class="pix10bold"><INPUT NAME="HomeClubOfficialsBenches" TYPE="radio" VALUE="Satisfactory" <cfif QFixtureDate.HomeClubOfficialsBenches IS "Satisfactory" >checked</cfif>></span></td>
								<td align="center"><span class="pix10bold"><INPUT NAME="HomeClubOfficialsBenches" TYPE="radio" VALUE="Poor" <cfif QFixtureDate.HomeClubOfficialsBenches IS "Poor" >checked</cfif>></span></td>
							</tr>

							<tr>
								<td align="center"><span class="pix10bold">Away</span></td>
								<td align="center" bgcolor="silver"><span class="pix10bold"><INPUT NAME="AwayClubOfficialsBenches" TYPE="radio" VALUE="" <cfif QFixtureDate.AwayClubOfficialsBenches IS "" >checked</cfif>></span></td>
								<td align="center"><span class="pix10bold"><INPUT NAME="AwayClubOfficialsBenches" TYPE="radio" VALUE="Excellent" <cfif QFixtureDate.AwayClubOfficialsBenches IS "Excellent" >checked</cfif>></span></td>
								<td align="center"><span class="pix10bold"><INPUT NAME="AwayClubOfficialsBenches" TYPE="radio" VALUE="Good" <cfif QFixtureDate.AwayClubOfficialsBenches IS "Good" >checked</cfif>></span></td>
								<td align="center"><span class="pix10bold"><INPUT NAME="AwayClubOfficialsBenches" TYPE="radio" VALUE="Satisfactory" <cfif QFixtureDate.AwayClubOfficialsBenches IS "Satisfactory" >checked</cfif>></span></td>
								<td align="center"><span class="pix10bold"><INPUT NAME="AwayClubOfficialsBenches" TYPE="radio" VALUE="Poor" <cfif QFixtureDate.AwayClubOfficialsBenches IS "Poor" >checked</cfif>></span></td>
							</tr>
							<tr>
								<td colspan="2"><span class="pix10bold">State of pitch</span></td>
								<td align="center" bgcolor="silver"><span class="pix10bold"><INPUT NAME="StateOfPitch" TYPE="radio" VALUE="" <cfif QFixtureDate.StateOfPitch IS "" >checked</cfif>></span></td>
								<td align="center"><span class="pix10bold"><INPUT NAME="StateOfPitch" TYPE="radio" VALUE="Excellent" <cfif QFixtureDate.StateOfPitch IS "Excellent" >checked</cfif>></span></td>
								<td align="center"><span class="pix10bold"><INPUT NAME="StateOfPitch" TYPE="radio" VALUE="Good" <cfif QFixtureDate.StateOfPitch IS "Good" >checked</cfif>></span></td>
								<td align="center"><span class="pix10bold"><INPUT NAME="StateOfPitch" TYPE="radio" VALUE="Satisfactory" <cfif QFixtureDate.StateOfPitch IS "Satisfactory" >checked</cfif>></span></td>
								<td align="center"><span class="pix10bold"><INPUT NAME="StateOfPitch" TYPE="radio" VALUE="Poor" <cfif QFixtureDate.StateOfPitch IS "Poor" >checked</cfif>></span></td>
							</tr>
							<tr>
								<td colspan="2"><span class="pix10bold">Club Facilities</span></td>
								<td align="center" bgcolor="silver"><span class="pix10bold"><INPUT NAME="ClubFacilities" TYPE="radio" VALUE="" <cfif QFixtureDate.ClubFacilities IS "" >checked</cfif>></span></td>
								<td align="center"><span class="pix10bold"><INPUT NAME="ClubFacilities" TYPE="radio" VALUE="Excellent" <cfif QFixtureDate.ClubFacilities IS "Excellent" >checked</cfif>></span></td>
								<td align="center"><span class="pix10bold"><INPUT NAME="ClubFacilities" TYPE="radio" VALUE="Good" <cfif QFixtureDate.ClubFacilities IS "Good" >checked</cfif>></span></td>
								<td align="center"><span class="pix10bold"><INPUT NAME="ClubFacilities" TYPE="radio" VALUE="Satisfactory" <cfif QFixtureDate.ClubFacilities IS "Satisfactory" >checked</cfif>></span></td>
								<td align="center"><span class="pix10bold"><INPUT NAME="ClubFacilities" TYPE="radio" VALUE="Poor" <cfif QFixtureDate.ClubFacilities IS "Poor" >checked</cfif>></span></td>
							</tr>
							<tr>
								<td colspan="2"><span class="pix10bold">Hospitality</span></td>
								<td align="center" bgcolor="silver"><span class="pix10bold"><INPUT NAME="Hospitality" TYPE="radio" VALUE="" <cfif QFixtureDate.Hospitality IS "" >checked</cfif>></span></td>
								<td align="center"><span class="pix10bold"><INPUT NAME="Hospitality" TYPE="radio" VALUE="Excellent" <cfif QFixtureDate.Hospitality IS "Excellent" >checked</cfif>></span></td>
								<td align="center"><span class="pix10bold"><INPUT NAME="Hospitality" TYPE="radio" VALUE="Good" <cfif QFixtureDate.Hospitality IS "Good" >checked</cfif>></span></td>
								<td align="center"><span class="pix10bold"><INPUT NAME="Hospitality" TYPE="radio" VALUE="Satisfactory" <cfif QFixtureDate.Hospitality IS "Satisfactory" >checked</cfif>></span></td>
								<td align="center"><span class="pix10bold"><INPUT NAME="Hospitality" TYPE="radio" VALUE="Poor" <cfif QFixtureDate.Hospitality IS "Poor" >checked</cfif>></span></td>
							</tr>
						</table>
					</td>
				<cfelse>
					<INPUT TYPE="HIDDEN" NAME="HomeClubOfficialsBenches" VALUE="">
					<INPUT TYPE="HIDDEN" NAME="AwayClubOfficialsBenches" VALUE="">
					<INPUT TYPE="HIDDEN" NAME="StateOfPitch" VALUE="">
					<INPUT TYPE="HIDDEN" NAME="ClubFacilities" VALUE="">
					<INPUT TYPE="HIDDEN" NAME="Hospitality" VALUE="">
				<td width="36%" align="center">
				<!---
				<cfif ClubsCanInputSportsmanshipMarks IS 1>
					 <table bgcolor="white"><tr><td><span class="pix9">Clubs are allowed to enter marks for their opponents' sportsmanship.<br>Contact us to prevent.</span></td></tr></table>
				<cfelse>
					 <table bgcolor="white"><tr><td><span class="pix9">Clubs are prevented from entering marks for their opponents' sportsmanship.<br>Contact us to allow.</span></td></tr></table>
				</cfif>	
             	--->
            	</td>
				</cfif>
				<!---
					*********************
					* Home Team+Ordinal *
					*********************
				--->
					<td width="14%" align="RIGHT" >
						<span class="pix13boldwhite"><cfoutput>#QFixtureDate.HomeTeam# #QFixtureDate.HomeOrdinal#<BR></span></cfoutput>
						<span class="pix10white">Sportsmanship Marks</span>
					</td>
				<!---
					****************************
					* Home Sportsmanship Marks *
					****************************
				--->
					<td width="2%" align="center">
						<cfif request.SportsmanshipMarksOutOfHundred IS "1" >
							<cfinput type="Text" name="HomeSportsmanshipMarks" value="#QFixtureDate.HomeSportsmanshipMarks#" message="Home Team Sportsmanship marks must be 0 to 100      " validate="integer" range="0,100" required="No" size="2" maxlength="3">
						<cfelse>
							<cfinput type="Text" name="HomeSportsmanshipMarks" value="#QFixtureDate.HomeSportsmanshipMarks#" message="Home Team Sportsmanship marks must be 0 to 10       " validate="integer" range="0,10" required="No" size="1" maxlength="2">
						</cfif>
					</td>
				<!---
					****************************
					* Away Sportsmanship Marks *
					****************************
				--->
					<td width="2%" align="CENTER">
						<cfif request.SportsmanshipMarksOutOfHundred IS "1" >
							<cfinput type="Text" name="AwaySportsmanshipMarks" value="#QFixtureDate.AwaySportsmanshipMarks#" message="Away Team Sportsmanship marks must be 0 to 100      " validate="integer" range="0,100" required="No" size="2" maxlength="3">
						<cfelse>						
							<cfinput type="Text" name="AwaySportsmanshipMarks" value="#QFixtureDate.AwaySportsmanshipMarks#" message="Away Team Sportsmanship marks must be 0 to 10       " validate="integer" range="0,10" required="No" size="1" maxlength="2">
						</cfif>
					</td>
				<!---
					*********************
					* Away Team+Ordinal *
					*********************
				--->
					<td width="14%" align="left" >
						<span class="pix13boldwhite"><cfoutput>#QFixtureDate.AwayTeam# #QFixtureDate.AwayOrdinal#<BR></span></cfoutput><span class="pix10white">Sportsmanship Marks</span>
					</td>
				</tr>
			</table>
		</td>
	</tr>

	<tr> 
    	<td>
			<!---
			*************************************************
			* In the case of a "decision", award as a ..... *
				A=awarded away win, 
				D=awarded draw, 
				H=awarded home win, 
				U=home win on penalties, 
				V=away win on penalties, 
				P=Postponed, 
				Q=Abandoned, 
				W=Void, 
				T=TEMP fixture hidden			
			*************************************************
			--->
			<table  width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr align="center">
					<td width="25%" align="center">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr align="center">
								<td>
									<INPUT NAME="RadioButton" TYPE="radio" VALUE="Result" <cfif NOT ListFind("H,A,D,U,V",QFixtureDate.Result)>checked</cfif>>
								</td>
								<td>
									<cfif NOT ListFind("H,A,D,U,V,P,Q",QFixtureDate.Result)>
										<span class="pix13bold">as entered</span>
									<cfelse>
										<span class="pix10">as entered</span>
									</cfif>
								</td>
							</tr>
						</table>
					</td>
					<td width="25%" align="center" valign="top">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td <cfif ListFind("P,Q,W,T",QFixtureDate.Result) >bgcolor="Aqua"</cfif> colspan="2" align="center" >
									<cfif ListFind("P,Q,W,T",QFixtureDate.Result) >
										<span class="pix13bold">match</span>
									<cfelse>
										<span class="pix10bold">match</span>
									</cfif>
								</td>
							</tr>
							<tr>
								<td <cfif QFixtureDate.Result IS "P" >bgcolor="Aqua"</cfif>>
									<INPUT NAME="RadioButton" TYPE="radio" VALUE="Postponed" <cfif QFixtureDate.Result IS "P" >checked</cfif>>
								</td>
								<td <cfif QFixtureDate.Result IS "P" >bgcolor="Aqua"</cfif>>
									<cfif QFixtureDate.Result IS "P" >
										<span class="pix13bold">Postponed</span>
									<cfelse>
										<span class="pix10">Postponed</span>
									</cfif>
								</td>
							</tr>
							<tr>
								<td <cfif QFixtureDate.Result IS "Q" >bgcolor="Aqua"</cfif>>
									<INPUT NAME="RadioButton" TYPE="radio" VALUE="Abandoned" <cfif QFixtureDate.Result IS "Q" >checked</cfif>>
								</td>
								<td <cfif QFixtureDate.Result IS "Q" >bgcolor="Aqua"</cfif>>
									<cfif QFixtureDate.Result IS "Q" >
										<span class="pix13bold">Abandoned</span>
									<cfelse>
										<span class="pix10">Abandoned</span>
									</cfif>
								</td>
							</tr>
							<tr>
								<td <cfif QFixtureDate.Result IS "W" >bgcolor="Aqua"</cfif>>
									<INPUT NAME="RadioButton" TYPE="radio" VALUE="Void" <cfif QFixtureDate.Result IS "W" >checked</cfif>>
								</td>
								<td <cfif QFixtureDate.Result IS "W" >bgcolor="Aqua"</cfif>>
									<cfif QFixtureDate.Result IS "W" >
										<span class="pix13bold">Void</span>
									<cfelse>
										<span class="pix10">Void</span>
									</cfif>
								</td>
							</tr>
							<!--- development  --->
							<tr>
								<td <cfif QFixtureDate.Result IS "T" >bgcolor="Aqua"</cfif>>
									<INPUT NAME="RadioButton" TYPE="radio" VALUE="TEMP" <cfif QFixtureDate.Result IS "T" >checked</cfif>>
								</td>
								<td <cfif QFixtureDate.Result IS "T" >bgcolor="Aqua"</cfif>>
									<cfif QFixtureDate.Result IS "T" >
										 <span class="pix13bold">TEMP</span>
									<cfelse>
										<span class="pix10">TEMP</span>
									</cfif>
								</td>
							</tr>
							<!---     development --->
						</table>
					</td>

					<td width="25%" align="center" valign="top">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td <cfif ListFind("H,A,D",QFixtureDate.Result) >bgcolor="Aqua"</cfif> colspan="2" align="center" >
									<cfif ListFind("H,A,D",QFixtureDate.Result) >
										<span class="pix13bold">awarded as</span>
									<cfelse>
										<span class="pix10bold">awarded as</span>
									</cfif>
								</td>
							</tr>
							<tr>
								<td <cfif QFixtureDate.Result IS "H" >bgcolor="Aqua"</cfif>>
									<INPUT NAME="RadioButton" TYPE="radio" VALUE="Home Win" <cfif QFixtureDate.Result IS "H" >checked</cfif>>
								</td>
								<td <cfif QFixtureDate.Result IS "H" >bgcolor="Aqua"</cfif>>
									<cfif QFixtureDate.Result IS "H" >
										<span class="pix13bold">Home Win</span>
									<cfelse>
										<span class="pix10">Home Win</span>
									</cfif>
								</td>
							</tr>
							<tr>
								<td <cfif QFixtureDate.Result IS "A" >bgcolor="Aqua"</cfif>>
									<INPUT NAME="RadioButton" TYPE="radio" VALUE="Away Win" <cfif QFixtureDate.Result IS "A" >checked</cfif>>
								</td>
								<td <cfif QFixtureDate.Result IS "A" >bgcolor="Aqua"</cfif>>
									<cfif QFixtureDate.Result IS "A" >
										<span class="pix13bold">Away Win</span>
									<cfelse>
										<span class="pix10">Away Win</span>
									</cfif>
								</td>
							</tr>
							<tr>
								<td <cfif QFixtureDate.Result IS "D" >bgcolor="Aqua"</cfif>>
									<INPUT NAME="RadioButton" TYPE="radio" VALUE="Drawn" <cfif QFixtureDate.Result IS "D" >checked</cfif>>
								</td>
								<td <cfif QFixtureDate.Result IS "D" >bgcolor="Aqua"</cfif>>
									<cfif QFixtureDate.Result IS "D" >
										<span class="pix13bold">Draw</span>
									<cfelse>
										<span class="pix10">Draw</span>
									</cfif>
								</td>
							</tr>
						</table>
					</td>

					<cfif Left(GetCompetitType.Notes,2) IS "KO">
						<td width="25%" align="center" bgcolor="beige" valign="top">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td <cfif ListFind("U,V",QFixtureDate.Result) >bgcolor="Aqua"</cfif> colspan="2" align="center" >
										<cfif ListFind("U,V",QFixtureDate.Result) >
											<span class="pix13bold">penalty kicks</span>
										<cfelse>
											<span class="pix10bold">penalty kicks</span>
										</cfif>
									</td>
								</tr>
								<tr>
									<td <cfif QFixtureDate.Result IS "U" >bgcolor="Aqua"</cfif>>
										<INPUT NAME="RadioButton" TYPE="radio" VALUE="Home Win on penalties" <cfif QFixtureDate.Result IS "U" >checked</cfif>>
									</td>
									<td <cfif QFixtureDate.Result IS "U" >bgcolor="Aqua"</cfif>>
										<cfif QFixtureDate.Result IS "U" >
											<span class="pix13bold">Home Win</span>
										<cfelse>
											<span class="pix10">Home Win</span>
										</cfif>
									</td>
								</tr>
								<tr>
									<td <cfif QFixtureDate.Result IS "V" >bgcolor="Aqua"</cfif>>
										<INPUT NAME="RadioButton" TYPE="radio" VALUE="Away Win on penalties" <cfif QFixtureDate.Result IS "V" >checked</cfif>>
									</td>
									<td <cfif QFixtureDate.Result IS "V" >bgcolor="Aqua"</cfif>>
										<cfif QFixtureDate.Result IS "V" >
											<span class="pix13bold">Away Win</span>
										<cfelse>
											<span class="pix10">Away Win</span>
										</cfif>
									</td>
								</tr>
							</table>
						</td>
					<cfelse>
						<td width="25%">
				<!---
					************************
					* Adjustment of points *
					************************
				--->
							<table width="100%" border="0" cellspacing="0" cellpadding="2" align="CENTER">
								<tr>
									<td align="CENTER" valign="top">
									<span class="pix10bold">disciplinary points adjustment<br /><br /></span>
									<cfif QFixtureDate.HomePointsAdjust IS 0 OR QFixtureDate.HomePointsAdjust IS "">
										<span class="pix10">Home Team</span>
									<cfelse>
										<span class="pix13boldred">Home Team</span>
									</cfif>
									<SELECT NAME="HomePointsAdjust" size="1">
										<option value="6" <cfif QFixtureDate.HomePointsAdjust IS 6>selected</cfif>>+6 </option>
										<option value="5" <cfif QFixtureDate.HomePointsAdjust IS 5>selected</cfif>>+5 </option>
										<option value="4" <cfif QFixtureDate.HomePointsAdjust IS 4>selected</cfif>>+4 </option>
										<option value="3" <cfif QFixtureDate.HomePointsAdjust IS 3>selected</cfif>>+3 </option>
										<option value="2" <cfif QFixtureDate.HomePointsAdjust IS 2>selected</cfif>>+2 </option>
										<option value="1" <cfif QFixtureDate.HomePointsAdjust IS 1>selected</cfif>>+1 </option>
										<option value="0" <cfif QFixtureDate.HomePointsAdjust IS 0 OR QFixtureDate.HomePointsAdjust IS "">selected</cfif>>0</option>
										<option value="-1" <cfif QFixtureDate.HomePointsAdjust IS -1>selected</cfif>>-1 </option>
										<option value="-2" <cfif QFixtureDate.HomePointsAdjust IS -2>selected</cfif>>-2 </option>
										<option value="-3" <cfif QFixtureDate.HomePointsAdjust IS -3>selected</cfif>>-3 </option>
										<option value="-4" <cfif QFixtureDate.HomePointsAdjust IS -4>selected</cfif>>-4 </option>
										<option value="-5" <cfif QFixtureDate.HomePointsAdjust IS -5>selected</cfif>>-5 </option>
										<option value="-6" <cfif QFixtureDate.HomePointsAdjust IS -6>selected</cfif>>-6 </option>
									</select>
									<cfif QFixtureDate.AwayPointsAdjust IS 0 OR QFixtureDate.AwayPointsAdjust IS "">
										<span class="pix10">Away Team</span>
									<cfelse>
										<span class="pix13boldred">Away Team</span>
									</cfif>
									<SELECT NAME="AwayPointsAdjust" size="1">
										<option value="6" <cfif QFixtureDate.AwayPointsAdjust IS 6>selected</cfif>>+6 </option>
										<option value="5" <cfif QFixtureDate.AwayPointsAdjust IS 5>selected</cfif>>+5 </option>
										<option value="4" <cfif QFixtureDate.AwayPointsAdjust IS 4>selected</cfif>>+4 </option>
										<option value="3" <cfif QFixtureDate.AwayPointsAdjust IS 3>selected</cfif>>+3 </option>
										<option value="2" <cfif QFixtureDate.AwayPointsAdjust IS 2>selected</cfif>>+2 </option>
										<option value="1" <cfif QFixtureDate.AwayPointsAdjust IS 1>selected</cfif>>+1 </option>
										<option value="0" <cfif QFixtureDate.AwayPointsAdjust IS 0 OR QFixtureDate.AwayPointsAdjust IS "">selected</cfif>>0</option>
										<option value="-1" <cfif QFixtureDate.AwayPointsAdjust IS -1>selected</cfif>>-1 </option>
										<option value="-2" <cfif QFixtureDate.AwayPointsAdjust IS -2>selected</cfif>>-2 </option>
										<option value="-3" <cfif QFixtureDate.AwayPointsAdjust IS -3>selected</cfif>>-3 </option>
										<option value="-4" <cfif QFixtureDate.AwayPointsAdjust IS -4>selected</cfif>>-4 </option>
										<option value="-5" <cfif QFixtureDate.AwayPointsAdjust IS -5>selected</cfif>>-5 </option>
										<option value="-6" <cfif QFixtureDate.AwayPointsAdjust IS -6>selected</cfif>>-6 </option>
									</select>
									</td>
								</tr>
							</table>
						</td>
					</cfif>
				</tr>
			</table>
		</td>
	 </tr>
</table>
