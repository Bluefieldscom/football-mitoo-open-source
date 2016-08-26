<html>
<head>
<LINK REL="stylesheet" type="text/css" href="fmstyle.css">
<title>football.mitoo - Referee Availability</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

</head>
<body>

<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>


<cflock scope="session" timeout="10" type="readonly">
	<cfset request.SeasonStartDate = session.SeasonStartDate >
	<cfset request.SeasonEndDate = session.SeasonEndDate >
</cflock>

<cfif NOT StructKeyExists(form, "UpdateButton") >
	<!--- first time in --->
	<cfset ThisLeagueCode = url.LeagueCode>
	<cfset ThisSecurityLevel = request.SecurityLevel>
	<cfset ThisMonth = URL.month_to_view >
	<cfset ThisYear  = URL.year_to_view  >
	<cfset ThisRefereeID  = URL.RefereeID  >
	<cfset ThisLeagueCodePrefix = request.filter>
<cfelse>
	<!--- second time in --->
	<cfset ThisLeagueCode = form.LeagueCode>
	<cfset ThisSecurityLevel = form.SecurityLevel>
	<cfset ThisMonth = form.month_to_view >
	<cfset ThisYear  = form.year_to_view  >
	<cfset ThisRefereeID  = form.RefereeID  >
	<cfset ThisLeagueCodePrefix = request.filter>
	
	
	<cfloop from="1" index="DayNumber" to="#form.ThisDaysInMonth#">
		<cfset ThisOne = "form.Day#NumberFormat(DayNumber,'00')#" >
		<cfset ThisOne = Evaluate(ThisOne)>
		<cfset ThisNotesText = "form.Notes#NumberFormat(DayNumber,'00')#" >
		<cfset ThisNotesText = Trim(Evaluate(ThisNotesText))>
		<cfset ThisDate = dateformat(createdate(ThisYear, ThisMonth, DayNumber), 'YYYY-MM-DD')>
		<cfif ThisOne IS 1> <!---  referee is definitely available --->
			<cfset ThisAvailability = "Yes">
			<!--- Is there a record for this day, if yes, then update it, if no, then insert it --->
			<cfinclude template = "queries/qry_GetRefAvailable1.cfm">
			<cfif GetRefAvailable1.RecordCount IS 0>
				<cfinclude template = "queries/ins_RefAvailable1.cfm">
			<cfelse>
				<cfset ThisID = GetRefAvailable1.ID >
				<cfinclude template = "queries/upd_RefAvailable1.cfm">
			</cfif>		
		<cfelseif ThisOne IS 2> <!--- referee is definitely unavailable  --->
			<cfset ThisAvailability = "No">
			<!--- Is there a record for this day, if yes, then update it, if no, then insert it --->
			<cfinclude template = "queries/qry_GetRefAvailable1.cfm">
			<cfif GetRefAvailable1.RecordCount IS 0>
				<cfinclude template = "queries/ins_RefAvailable1.cfm">
			<cfelse>
				<cfset ThisID = GetRefAvailable1.ID >
				<cfinclude template = "queries/upd_RefAvailable1.cfm">
			</cfif>		
		<cfelseif ThisOne IS 3> <!--- silver - unknown status --->
			<!--- Is there a record for this day, if yes, then delete it --->
			<cfinclude template = "queries/qry_GetRefAvailable1.cfm">
			<cfif GetRefAvailable1.RecordCount IS 0>
			<cfelse>
				<cfset ThisID = GetRefAvailable1.ID >
				<cfinclude template = "queries/del_RefAvailable1.cfm">
			</cfif>		
		<cfelse>
			ERROR in Calendar.cfm - aborting
			<cfabort>
		</cfif>
	</cfloop>	
</cfif>
<!--- EXAMPLE: calendar.cfm?LeagueCode=#LeagueCode#&month_to_view=#int_Mnth#&year_to_view=#int_Yr#&RefereeID=#RefereeID# --->

<cfif NOT ListFind("Silver,Skyblue,Yellow",ThisSecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<cfif ListFind("Yellow",request.SecurityLevel) >
	<cfif StructKeyExists(url, "RefereeID") AND StructKeyExists(url, "LeagueCode") >
	<!---  for yellow security level check that the url.ID (referee's id) parameter and leaguecode parametere have not been tampered with.  --->
		<cflock scope="session" timeout="10" type="readonly">
			<cfset request.YellowKey = session.YellowKey  >
		</cflock>
		<cfif url.RefereeID IS "#Reverse(GetToken(Reverse(request.YellowKey),1,'|'))#" AND url.LeagueCode IS "#GetToken(request.YellowKey,1,'|')#">
			<!--- all OK --->
		<cfelse>
			<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
			<cfabort>
		</cfif>
	<cfelseif StructKeyExists(form, "RefereeID") AND StructKeyExists(form, "LeagueCode") >
	<!---  for yellow security level check that the url.ID (referee's id) parameter and leaguecode parametere have not been tampered with.  --->
		<cflock scope="session" timeout="10" type="readonly">
			<cfset request.YellowKey = session.YellowKey  >
		</cflock>
		<cfif form.RefereeID IS "#Reverse(GetToken(Reverse(request.YellowKey),1,'|'))#" AND form.LeagueCode IS "#GetToken(request.YellowKey,1,'|')#">
			<!--- all OK --->
		<cfelse>
			<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
			<cfabort>
		</cfif>
	</cfif>
</cfif>

<cfinclude template = "queries/qry_RefsName.cfm">
<cfinclude template = "queries/qry_RefYesAvailable.cfm">
<cfset RefYesAvailableList = ValueList(RefYesAvailable.s_day)>
<cfinclude template = "queries/qry_RefNotAvailable.cfm">
<cfset RefNotAvailableList = ValueList(RefNotAvailable.s_day)>
<cfinclude template = "queries/qry_RefAvailableNotes.cfm">
<cfset RefAvailableNotesList = ValueList(RefAvailableNotes.s_day)>
<cfset RefAvailableNotesTextList = ValueList(RefAvailableNotes.Notes)>
<cfset CurrentDay = DatePart('d', Now()) >
<cfset CurrentMonth = DatePart('m', Now()) >
<cfset CurrentYear = DatePart('yyyy', Now()) >
<!--- Set the requested (or current) month/year date and determine the number of days in the month. --->
<cfset ThisMonthYear = CreateDate(ThisYear, ThisMonth, '1')>
<cfset ThisDaysInMonth = DaysInMonth(ThisMonthYear)>
<!--- Set the values for the previous and next months for the back/next links. --->
<cfset LastMonthYear = DateAdd('m', -1, ThisMonthYear)>
<cfset LastMonth = DatePart('m', LastMonthYear)>
<cfset LastYear = DatePart('yyyy', LastMonthYear)>
<cfset NextMonthYear = DateAdd('m', 1, ThisMonthYear)>
<cfset NextMonth = DatePart('m', NextMonthYear)>
<cfset NextYear = DatePart('yyyy', NextMonthYear)>

<form name="UpdateRefAvailable" action="calendar.cfm" METHOD="POST" >
	<cfoutput>
		<input type="Hidden" NAME="LeagueCode" VALUE="#ThisLeagueCode#">
		<input type="Hidden" NAME="SecurityLevel" VALUE="#ThisSecurityLevel#">
		<input type="Hidden" NAME="month_to_view" VALUE="#ThisMonth#">
		<input type="Hidden" NAME="year_to_view" VALUE="#ThisYear#">
		<input type="Hidden" NAME="RefereeID" VALUE="#ThisRefereeID#">
		<input type="Hidden" NAME="ThisDaysInMonth" VALUE="#ThisDaysInMonth#">
	</cfoutput>
	<table width="100%" border = "0" align="center" bgcolor="beige">
		<tr>
			<td colspan="2" align="center" valign="middle">
			 <!--- Display the current month/year as well as the back/next links. --->
				 <cfoutput>
					 <cfset NextMonthToolTipText = "click here for #MonthAsString(NextMonth)# #NextYear#<br /><br />Warning: Any changes you make for #MonthAsString(ThisMonth)# will be lost unless you click on the Update button.">		
					 <cfset LastMonthToolTipText = "click here for #MonthAsString(LastMonth)# #LastYear#<br /><br />Warning: Any changes you make for #MonthAsString(ThisMonth)# will be lost unless you click on the Update button.">		 
					 <span class="pix24bold">#RefInfo.RefsName#</span>
				 </cfoutput>
			 </td>
		</tr>
		<tr>
			<td colspan="2" align="center">
			<cfif month_to_view LE MONTH(request.SeasonStartDate)  AND year_to_view LE YEAR(request.SeasonStartDate)>
				<cfoutput>
					<img src="click_left_off.png" border="0" >
					<span class="pix18bold">Availability #MonthAsString(ThisMonth)# #ThisYear#</span>
					<a href="calendar.cfm?month_to_view=#NextMonth#&year_to_view=#NextYear#&LeagueCode=#LeagueCode#&RefereeID=#ThisRefereeID#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=300;return escape('#NextMonthTooltipText#');"><img src="click_right_on.png" border="0" onMouseOver="this.src='click_right_hover.png'" onMouseOut="this.src='click_right_on.png';"></a>
				</cfoutput>
			<cfelseif month_to_view GE MONTH(request.SeasonEndDate)  AND year_to_view GE YEAR(request.SeasonEndDate)>
				<cfoutput>
					<a href="calendar.cfm?month_to_view=#LastMonth#&year_to_view=#LastYear#&LeagueCode=#LeagueCode#&RefereeID=#ThisRefereeID#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=300;return escape('#LastMonthTooltipText#');"><img src="click_left_on.png" border="0" onMouseOver="this.src='click_left_hover.png'" onMouseOut="this.src='click_left_on.png';"></a>
					<span class="pix18bold">Availability #MonthAsString(ThisMonth)# #ThisYear#</span>
					<img src="click_right_off.png" border="0" >
				</cfoutput>
			<cfelse>
				<cfoutput>
					<a href="calendar.cfm?month_to_view=#LastMonth#&year_to_view=#LastYear#&LeagueCode=#LeagueCode#&RefereeID=#ThisRefereeID#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=300;return escape('#LastMonthTooltipText#');"><img src="click_left_on.png" border="0" onMouseOver="this.src='click_left_hover.png'" onMouseOut="this.src='click_left_on.png';"></a>
					<span class="pix18bold">Availability #MonthAsString(ThisMonth)# #ThisYear#</span>
					<a href="calendar.cfm?month_to_view=#NextMonth#&year_to_view=#NextYear#&LeagueCode=#LeagueCode#&RefereeID=#ThisRefereeID#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=300;return escape('#NextMonthTooltipText#');"><img src="click_right_on.png" border="0" onMouseOver="this.src='click_right_hover.png'" onMouseOut="this.src='click_right_on.png';"></a>
				</cfoutput>
			</cfif>
			<!--- #month_to_view# #year_to_view# #YEAR(request.SeasonStartDate)# #MONTH(request.SeasonStartDate)# #YEAR(request.SeasonEndDate)# #MONTH(request.SeasonEndDate)# --->
			</td>			
		</tr>
		<tr>
			<cfoutput>
				<cfif ListFind("Silver,Skyblue",ThisSecurityLevel) >
					<td width="50%" align="center"><span class="pix13">#RefInfo.RefsName#: <a href="RefsHist.cfm?RI=#ThisRefereeID#&LeagueCode=#LeagueCode#">Referee's History</span></a> </td>
				<cfelseif ListFind("Yellow",ThisSecurityLevel) >
					<td width="50%" align="center"><span class="pix13">#RefInfo.RefsName#: <a href="RefsHistPublic.cfm?RI=#ThisRefereeID#&LeagueCode=#LeagueCode#">Referee's History</span></a> </td>
				</cfif>
				<td width="50%" align="center"><span class="pix13">#RefInfo.RefsName#: <a href="UpdateForm.cfm?TblName=Referee&ID=#ThisRefereeID#&LeagueCode=#LeagueCode#">Update Details</span></a></td>
			</cfoutput>
		</tr>
		<tr>
			  <td colspan="2" align="center"><input type="submit" value="Update" name="UpdateButton" ></td>
		</tr>
		<tr>
			<td colspan="2" >
				<table width="100%" border="1" cellpadding="0" cellspacing="0">
					 <tr>
						<cfloop FROM = "1" TO = "7" index = "LoopDay">
						   <cfoutput>
							 <td width="14%" align="center" bgcolor="beige"><span class="pix18bold">#DayOfWeekAsString(LoopDay)#</span></td>
						   </cfoutput>
						 </cfloop>
					 </tr>
				 	<cfset ThisDay = 0>
				 	<!--- Loop through until the number of days in the month is reached.  --->
					<cfloop CONDITION = "ThisDay LTE ThisDaysInMonth">
						<tr>
			  				<!--- Loop through each day of the week. --->
								<cfloop FROM = "1" TO = "7" index = "LoopDay">
									<cfif ThisDay IS 0>
										<cfif DayOfWeek(ThisMonthYear) IS LoopDay>
											<cfset ThisDay = 1>
										</cfif>
									</cfif>
									<cfif (ThisDay IS NOT 0) AND (ThisDay LTE ThisDaysInMonth)>
										<cfif ListFind(RefYesAvailableList, #ThisDay#) >
											<cfset ThisColor = "LightGreen">
										<cfelseif ListFind(RefNotAvailableList, #ThisDay#) >
											<cfset ThisColor = "Pink">
										<cfelse>
											<cfset ThisColor = "Silver">
										</cfif>
										<cfoutput>
										<td align="center" bgcolor="#ThisColor#">
										<cfset dayview = dateformat(createdate(ThisYear, ThisMonth, ThisDay), 'mm/dd/yyyy')>
											<table width="95%" border="0" cellpadding="1" cellspacing="0">
												<tr>
													<td align="center" ><span class="pix18bold">&nbsp;</span></td>
													<cfif (#ThisDay# EQ #CurrentDay#) AND (#ThisMonth# EQ #CurrentMonth#) AND (#ThisYear# EQ #CurrentYear#)>
														<cfset ThisBGColor = "aqua">
													<cfelse>
														<cfset ThisBGColor = "white">
													</cfif>								
													<td align="center" bgcolor="#ThisBGColor#" ><span class="pix18bold">#ThisDay#</span></td>
													<td align="center" ><span class="pix18bold">&nbsp;</span></td>
												</tr>
												<cfset ThisFixtureDate = dateformat(createdate(ThisYear, ThisMonth, ThisDay), 'YYYY-MM-DD')>
												<!--- Get match details of this referee's fixture for this day  --->
												<cfinclude template="queries/qry_OfficialsFixtureDetails.cfm">
												<cfif QOfficialsFixtureDetails.RecordCount IS 0>
												<cfelseif QOfficialsFixtureDetails.RecordCount IS 1 >
													<tr>
														<td colspan="3">
															<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="white">
																<cfif QOfficialsFixtureDetails.RefereeID IS #ThisRefereeID#>
																	<tr><td align="center"><img src="images/icon_referee.png" border="0" align="middle"></td></tr>
																</cfif>
																<cfif QOfficialsFixtureDetails.AsstRef1ID IS #ThisRefereeID#>
																	<tr><td align="center"><img src="images/icon_line1.png" border="0" align="middle"></td></tr>
																</cfif>
																<cfif QOfficialsFixtureDetails.AsstRef2ID IS #ThisRefereeID#>
																	<tr><td align="center"><img src="images/icon_line2.png" border="0" align="middle"></td></tr>
																</cfif>
																<cfif QOfficialsFixtureDetails.FourthOfficialID IS #ThisRefereeID#>
																	<tr><td align="center"><img src="images/icon_4th.png" border="0" align="middle"></td></tr>
																</cfif>
																<cfif QOfficialsFixtureDetails.AssessorID IS #ThisRefereeID#>
																	<tr><td align="center"><img src="images/icon_assesment.png" border="0" align="middle"></td></tr>
																</cfif>
																<tr><td align="center"><span class="pix10boldnavy">#QOfficialsFixtureDetails.DivisionCode#</span></td></tr>
																<cfset message01 = "" >
																<!--- HideScore irrelevant here because always logged in as Silver or SkyBlue --->
																<cfif QOfficialsFixtureDetails.Result IS "H" >
																	<cfset message01 = "Home Win was awarded">
																<cfelseif QOfficialsFixtureDetails.Result IS "A" >
																	<cfset message01 = "Away Win was awarded">
																<cfelseif QOfficialsFixtureDetails.Result IS "U" >
																	<cfset message01 = "Home Win on penalties">
																<cfelseif QOfficialsFixtureDetails.Result IS "V" >
																	<cfset message01 = "Away Win on penalties">
																<cfelseif QOfficialsFixtureDetails.Result IS "D" >
																	<cfset message01 = "Draw was awarded">
																<cfelseif QOfficialsFixtureDetails.Result IS "P" >
																	<cfset message01 = "Postponed">
																<cfelseif QOfficialsFixtureDetails.Result IS "Q" >
																	<cfset message01 = "Abandoned">
																<cfelseif QOfficialsFixtureDetails.Result IS "W" >
																	<cfset message01 = "Void">
																<cfelseif QOfficialsFixtureDetails.Result IS "T" >
																	<cfset message01 = "TEMP">
																</cfif>
																<cfif Len(Trim(message01)) GT 0>
																	<tr>
																		<td align="center"><span class="pix10">#message01#</span></td>
																	</tr>
																</cfif>		   
																<tr><td align="center"><span class="pix10">#QOfficialsFixtureDetails.HomeTeamName#</span></td></tr>
																<tr><td align="center"><span class="pix10">#QOfficialsFixtureDetails.HomeGoals# v #QOfficialsFixtureDetails.AwayGoals#</span></td></tr>
																<tr><td align="center"><span class="pix10">#QOfficialsFixtureDetails.AwayTeamName#</span></td></tr>
															</table>
														</td>
													</tr>
												<cfelse>
													<tr>
													   <td colspan="3">
														   <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="red">
															   <tr>
																	<td><span class="pix10boldwhite">More than one apptmnt!</span></td>
															   </tr>
														   </table>
													   </td>
													</tr>
												</cfif>
												<cfif ListFind(RefAvailableNotesList, #ThisDay#) >
													<cfset L = ListFind(RefAvailableNotesList, #ThisDay#) >
													<cfset ThisNotes = ListGetAt(RefAvailableNotesTextList, #L#)>
													<tr>
													   <td colspan="3">
														   <table width="100%" border="0" cellpadding="0" cellspacing="1" >
															   <tr>
																	<td align="center"><textarea name="Notes#NumberFormat(ThisDay,'00')#" rows="1" cols="20">#ThisNotes#</textarea></td>
															   </tr>
														   </table>
													   </td>
													</tr>
												<cfelse>
													<cfif ThisColor IS "Silver">
														<input type="Hidden" name="Notes#NumberFormat(ThisDay,'00')#" VALUE="">
													<cfelse>
														<tr>
														   <td colspan="3">
															   <table width="100%" border="0" cellpadding="0" cellspacing="1" >
																	<tr>
																		<td align="center"><textarea name="Notes#NumberFormat(ThisDay,'00')#" rows="1" cols="20"></textarea></td>
																	</tr>
															   </table>
														   </td>
														</tr>
													</cfif>
												</cfif>
											<tr>
											   <cfif ThisColor IS "LightGreen">
												   <td align="center"><INPUT NAME="Day#NumberFormat(ThisDay,'00')#" TYPE="radio" VALUE="1" checked></td>
												   <td align="center"><INPUT NAME="Day#NumberFormat(ThisDay,'00')#" TYPE="radio" VALUE="2" ></td>
												   <td align="center"><INPUT NAME="Day#NumberFormat(ThisDay,'00')#" TYPE="radio" VALUE="3" ></td>
											   <cfelseif ThisColor IS "Pink">
												   <td align="center"><INPUT NAME="Day#NumberFormat(ThisDay,'00')#" TYPE="radio" VALUE="1" ></td>
												   <td align="center"><INPUT NAME="Day#NumberFormat(ThisDay,'00')#" TYPE="radio" VALUE="2" checked></td>
												   <td align="center"><INPUT NAME="Day#NumberFormat(ThisDay,'00')#" TYPE="radio" VALUE="3" ></td>
											   <cfelse>
												   <td align="center"><INPUT NAME="Day#NumberFormat(ThisDay,'00')#" TYPE="radio" VALUE="1" ></td>
												   <td align="center"><INPUT NAME="Day#NumberFormat(ThisDay,'00')#" TYPE="radio" VALUE="2" ></td>
												   <td align="center"><INPUT NAME="Day#NumberFormat(ThisDay,'00')#" TYPE="radio" VALUE="3" checked></td>
											   </cfif>
											</tr>
											<tr>
											   <td align="center" bgcolor="LightGreen"><span class="pix10">Yes</span></td>
											   <td align="center" bgcolor="Pink"><span class="pix10">No</span></td>
											   <td align="center" bgcolor="Silver"><span class="pix10">&nbsp;</span></td>
											</tr>
										</table>
									</td>
										</cfoutput>
									<cfset ThisDay = ThisDay + 1>
								<cfelse>
								 <td><span class="pix10">&nbsp;</span></td>
								</cfif>
							</cfloop>
						</tr>
					</cfloop>
				</table>
			</td>
		</tr>
	</table>
</form>

<script language="JavaScript" type="text/javascript" src="wz_tooltip.js"></script>
</body>
</html>
