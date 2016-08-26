<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfset BlueColor1 = "##D8FEF5">
<cfset BlueColor2 = "##B8FEF5">

<cfset BatchInput = "No">
<!--- include toolbar.cfm--->
<cfinclude template="InclBegin.cfm">

<!--- This query is used to populate the upper half of the screen --->
<cfinclude template="queries/qry_QThisClubsRegisteredPlayers.cfm">
<cfinclude template="queries/qry_LongestPlayerName.cfm">
<cfset LengthOfLongestPlayerName = QLongestPlayerName.LengthOfLongestPlayerName + 2 >
<cfset RegistrationCount = QThisClubsRegisteredPlayers.RecordCount>
<cfset Denominator = 0>
<cfset Numerator = 0>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="CENTER" class="loggedinScreen">
	<tr>
		<td height="50">
			<table border="1" cellspacing="0" cellpadding="5" align="CENTER">
				<tr>
					<td height="20" align="center" valign="middle">
						<cfoutput>
							<a href="RegisteredPlayers.cfm?LeagueCode=#LeagueCode#"><span class="pix10">Registered Players Analysis</span></a>
						</cfoutput>
					</td>
					<td height="20" align="center" valign="middle">
						<cfoutput>
							<a href="LUList.cfm?Transfer=Y&TblName=Player&LeagueCode=#LeagueCode#"><span class="pix10">See Transfers</span></a>
						</cfoutput>
					</td>
					<td height="20" align="center" valign="middle">
						<cfoutput>
							<a href="LUList.cfm?Suspended=Y&TblName=Player&LeagueCode=#LeagueCode#"><span class="pix10">See Suspensions</span></a>
						</cfoutput>
					</td>
					<td height="20" align="center" valign="middle">
						<cfoutput>
							<a href="LUList.cfm?Unregistered=Y&TblName=Player&LeagueCode=#LeagueCode#"><span class="pix10">See Unregistered</span></a>
						</cfoutput>
					</td>
					<td height="20" align="center" valign="middle">
						<cfoutput>
							<a href="PlayedWhileUnregistered.cfm?LeagueCode=#LeagueCode#"><span class="pix10">Played while unregistered</span></a>
						</cfoutput>
					</td>
				</tr>
			</table>
		</td>
	</tr>

	<cfif ListFind("Silver",request.SecurityLevel) >
		<tr>
			<cfoutput>
				<td height="30" bgcolor="silver">
					<span class="pix10">
						<strong>JAB Only</strong> <a href="JABDeleteRegistrations.cfm?LeagueCode=#LeagueCode#&TeamID=#TeamID#">Delete Registrations</a> 
					</span>
				</td>
			</cfoutput>
		</tr>
	</cfif>
	<tr>
		<td height="30" align="center" bgcolor="beige">
			<cfoutput>
				<span class="pix10">Please <a href="RegisteredList2.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#TeamID#&SortSeq=Name">click here</a> to see Expired Registrations</span>
			</cfoutput>			
		</td>
	</tr>
	<cfif RegistrationCount GT 0>
		<cfset HdrText = "#CJustify(SeasonName, 100)##CHR(10)##CJustify(LeagueName, 100)##CHR(10)##CHR(10)#">
		<cfset SubjectString ="Players with Current and Future Registrations for #QGetTeam.ClubName#  - #LeagueName#  [#SeasonName#]">
		<cfset WorkString = "Players with Current and Future Registrations for #QGetTeam.ClubName##CHR(10)##CHR(10)#">
		<cfset HdrText = "#HdrText##CJustify(WorkString, 100)##CHR(10)#">
		<cfset BodyText = "">
	
		<tr>
			<td>
<!---
							*********************************************************
							* Produce list of players who REGISTERED for this club  *
							* with Current and Future Registrations                 *
							*********************************************************
--->

				<table border="1" cellspacing="0" cellpadding="3" align="CENTER">
					<cfoutput>
					<cfset ColHeadingsText = "#LJustify('Player Name', LengthOfLongestPlayerName)##RJustify('Reg No', 6)# #CJustify('DoB', 8)# #CJustify('Age', 3)##CJustify('Reg Type', 12)# First Day Last Day#CHR(10)##CHR(10)#">
					<cfset BodyText = "#BodyText##ColHeadingsText#">
					
					<tr>
						<!--- Headings --->
						<td align="left" <cfif SortSeq IS "Name">class="bg_highlight"<cfelse>class="bg_highlight2"</cfif>>
							<span class="pix10">
							<a href="RegisteredList1.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#TeamID#&SortSeq=Name">Player Name</a>
							</span>
						</td>
						<td align="right" <cfif SortSeq IS "RegNo">class="bg_highlight"<cfelse>class="bg_highlight2"</cfif>>
							<span class="pix10">
							<a href="RegisteredList1.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#TeamID#&SortSeq=RegNo">Reg No</a>
							</span>
						</td>
						<td align="center" <cfif SortSeq IS "DoB">class="bg_highlight"<cfelse>class="bg_highlight2"</cfif>>
							<span class="pix10">
							<a href="RegisteredList1.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#TeamID#&SortSeq=DoB">DoB</a>
							</span>
						</td>
						<td  align="center" <cfif SortSeq IS "Age">class="bg_highlight"<cfelse>class="bg_highlight2"</cfif>>
							<span class="pix10">
							<a href="RegisteredList1.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#TeamID#&SortSeq=Age">Age</a>
							</span>
						</td>
						<td  align="left" <cfif SortSeq IS "RegType">class="bg_highlight"<cfelse>class="bg_highlight2"</cfif>>
							<span class="pix10">
							<a href="RegisteredList1.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#TeamID#&SortSeq=RegType">Reg Type</a>
							</span>
						</td>
						<td align="center" <cfif SortSeq IS "FirstDay">class="bg_highlight"<cfelse>class="bg_highlight2"</cfif>>
							<span class="pix10">
							<a href="RegisteredList1.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#TeamID#&SortSeq=FirstDay">First Day</a>
							</span>
						</td>
						<td align="center"><span class="pix10">Last Day</span></td>
						<td align="center"><span class="pix10">Notes</span></td>
						<td align="center"><span class="pix10">Suspensions</span></td>
					</tr>
					</cfoutput>
					
					<cfset CurrentlyRegisterdCount = 0 >
					<cfset FutureRegisterdCount = 0 >
					<cfset colorcount = 0>	
					<cfoutput query="QThisClubsRegisteredPlayers" group="RegistrationID">
						<cfif CurrentRegistration OR NOT ExpiredRegistration >
							<cfset colorcount = colorcount + 1>
						</cfif>
						<cfif colorcount Mod 2 IS 0>
							<cfset rowcolor = "#BlueColor1#" >
						<cfelse>
							<cfset rowcolor = "#BlueColor2#" >
						</cfif>
				
						<cfif FirstDayOfRegistration IS "">
							<cfset Day001 = '1900-01-01'>
						<cfelse>
							<cfset Day001 = FirstDayOfRegistration>
						</cfif>
						<cfif LastDayOfRegistration IS "">
							<cfset Day002 = '2999-12-31'>
						<cfelse>
							<cfset Day002 = LastDayOfRegistration>
						</cfif>

						<!---
						<cfif DateCompare(Now(),Day001) GE 0 AND DateCompare(Day002, DateAdd('D', -1, Now())) GT 0  >
							<cfset InRange = "Yes">
							<cfset CurrentlyRegisterdCount = CurrentlyRegisterdCount + 1>
						<cfelse>
							<cfset InRange = "No">
							<cfset CurrentlyUnregisterdCount = CurrentlyUnregisterdCount + 1>
							
						</cfif>
						--->
						<cfif NOT ExpiredRegistration>
							<cfif StructKeyExists( url, "PID")>
								<cfif url.PID IS PlayerID>
									<cfset rowcolor = "ivory">
								</cfif>
							</cfif>
							
							<tr bgcolor="#rowcolor#">
								<!--- applies to season 2012 onwards only --->
								<cfif RIGHT(request.dsn,4) GE 2012>
									<cfif Trim("#AddressLine1##AddressLine2##AddressLine3##Postcode#") IS "">
										<cfset ToolTipText="address lines are missing">
									<cfelse>
										<cfset ToolTipText="<div style='text-align:left;'>#AddressLine1#<br>#AddressLine2#<br>#AddressLine3#<br>#Postcode#</div>">
									</cfif>
								<cfelse>
									<cfset ToolTipText="<div style='text-align:left;'>Address lines show here from season 2012 onwards only....</div>">
								</cfif>
								<cfset tooltiptext = Replace(tooltiptext, "'", "\'", "ALL")>
								<!--- Player's name --->
								<td rowspan="2" align="left">
								<span class="pix13"><a href="LUList.cfm?LeagueCode=#LeagueCode#&TblName=Player&FirstNumber=#PlayerRegNo#&LastNumber=#PlayerRegNo#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='##FFFFF0';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=300;return escape('#TooltipText#');">
								<b>#Surname#</b> #Forename#</a></span></td>
								<cfset LineText = "#LJustify('#Surname#, #Forename#', LengthOfLongestPlayerName)#" >
								
								<!--- Player's RegNo --->
								<td rowspan="2"  align="right">
								<span class="pix10bold">#PlayerRegNo#</span>
								</td>
								<cfset LineText = "#LineText##RJustify(PlayerRegNo, 6)#">
								<!--- Player's DOB --->
								<td rowspan="2" align="center">
									<cfif PlayerDOB IS "">
									<!--- Date of Birth is missing --->
										<cfset DoBTxt = "   --   ">
									<cfelse>
										<cfset DoBTxt = "#DateFormat(PlayerDOB, 'DD/MM/YY')#">
									</cfif>
									<span class="pix10">#DoBTxt#</span>
								</td>
								<cfset LineText = "#LineText# #CJustify(DoBTxt,8)#">
									
								<!--- Player's Age --->
								<td rowspan="2" align="center">
									<cfif PlayerDOB IS "">
										<cfset AgeTxt = "--">
									<cfelse>
										<cfset AgeTxt = "#DateDiff( "YYYY",  PlayerDOB, Now() )#" >
										<cfset Age = DateDiff( "YYYY",  PlayerDOB, Now() ) >
										<!--- only players who are currently registered and have a DoB will contribute to the average --->
											<cfset Numerator = Numerator + Age>
											<cfset Denominator = Denominator + 1>
										
									</cfif>
									<span class="pix10">#AgeTxt#</span>
								</td>
								<cfset LineText = "#LineText#  #CJustify(AgeTxt,2)#">
								
								
									<!--- Registration Type  --->
									
									<cfif     RegType Is 'A'>
										<cfset RegTypeTxt = "Non-Contract    "><td align="left"><span class="pix10">#RegTypeTxt#</span></td>
									<cfelseif RegType Is 'B'>
										<cfset RegTypeTxt = "Contract        "><td align="left" class="bg_highlight"><span class="pix10">#RegTypeTxt#</span></td>
									<cfelseif RegType Is 'C'>
										<cfset RegTypeTxt = "Short Loan      "><td align="left" class="bg_white"><span class="pix10">#RegTypeTxt#</span></td>
									<cfelseif RegType Is 'D'>
										<cfset RegTypeTxt = "Long Loan       "><td align="left" class="bg_highlight2"><span class="pix10">#RegTypeTxt#</span></td>
									<cfelseif RegType Is 'E'>
										<cfset RegTypeTxt = "Work Experience "><td align="left" class="bg_lightgreen"><span class="pix10">#RegTypeTxt#</span></td>
									<cfelseif RegType Is 'G'>
										<cfset RegTypeTxt = "Lapsed          "><td align="left" class="bg_silver"><span class="pix10">#RegTypeTxt#</span></td>
									<cfelseif RegType Is 'F'>
										<cfset RegTypeTxt = "Temporary       "><td align="left" class="bg_yellow"><span class="pix10">#RegTypeTxt#</span></td>
									<cfelse>	
										<cfset RegTypeTxt = "ERROR           "><td align="left" class="bg_pink"><span class="pix10">#RegTypeTxt#</span></td>
									</cfif>
								
								<cfset LineText = "#LineText# #RegTypeTxt#">
								
								<!--- First Day of Registration --->
								<cfif FirstDayOfRegistration IS "">
									<cfset FirstDayOfRegistrationTxt = "   --   ">
								<cfelse>
									<cfset FirstDayOfRegistrationTxt = "#DateFormat(FirstDayOfRegistration, 'DD/MM/YY')#">
								</cfif>
								<cfif DateCompare(Now(),Day001) LE 0> 
									<cfset FutureRegisterdCount = FutureRegisterdCount + 1>
									<td align="center" bgcolor="##FF20A0">
									<span class="pix10">#FirstDayOfRegistrationTxt#</span>
									</td>
								<cfelse>
									<cfset CurrentlyRegisterdCount = CurrentlyRegisterdCount + 1>
									<td align="center">
									<span class="pix10">#FirstDayOfRegistrationTxt#</span>
									</td>
								</cfif>
								
								<cfset LineText = "#LineText# #FirstDayOfRegistrationTxt#">
									
								<td align="center">
									<!--- Last Day of Registration --->
									<cfif LastDayOfRegistration IS "">
										<cfset LastDayOfRegistrationTxt = "   --   ">
									<cfelse>
										<cfset LastDayOfRegistrationTxt = "#DateFormat(LastDayOfRegistration, 'DD/MM/YY')#">
									</cfif>
									<span class="pix10">#LastDayOfRegistrationTxt#</span>
								</td>
								<cfset LineText = "#LineText# #LastDayOfRegistrationTxt##CHR(10)#">
									<!--- Player Notes --->
									<cfif TRIM(PlayerNotes) IS "">
										<cfset PlayerNotesTxt = "-">
									<cfelse>
										<cfset PlayerNotesTxt = "#PlayerNotes#">
									</cfif>
								<td width="200" rowspan="2" align="left"><span class="pix10">#PlayerNotesTxt#</span></td>
	
								<cfif TRIM(PlayerNotes) IS "">
								<cfelse>
									<cfset LineText = "#LineText#   #PlayerNotes##CHR(10)#">
								</cfif>
	
									<td rowspan="2">
										<table>
										<cfoutput>
											<tr>
												<cfif FirstDayOfSuspension IS NOT "" AND NumberOfMatches IS 0>
													<cfset SuspensionTxt = "#ROUND(Evaluate((DateDiff("h", FirstDayOfSuspension, LastDayOfSuspension) +25)/ 24))# days from #DateFormat( FirstDayOfSuspension , 'DD MMM YY')# to  #DateFormat( LastDayOfSuspension , 'DD MMM YY')# ">							
													<cfset SuspensionEmailTxt = "SUSPENDED #ROUND(Evaluate((DateDiff("h", FirstDayOfSuspension, LastDayOfSuspension) +25)/ 24))# days from #DateFormat( FirstDayOfSuspension , 'DD MMM YY')# to #DateFormat( LastDayOfSuspension , 'DD MMM YY')#">
													<cfset LineText = "#LineText#   #SuspensionEmailTxt##CHR(10)#">
													<td class="bg_suspend" align="left"><span class="pix10">#SuspensionTxt#</span></td>
												<cfelseif NumberOfMatches GT 0><!---  match based suspension --->	
													<cfif LastDayOfSuspension IS '2999-12-31'><!---  ongoing match based suspension --->
														<td class="bg_suspend" align="left"><span class="pix10">Ongoing #NumberOfMatches# match suspension starting #DateFormat( FirstDayOfSuspension , 'DD MMMM YYYY')# </span></td>
													<cfelse>
														<td class="bg_suspend" align="left"><span class="pix10">Served #NumberOfMatches# match suspension from #DateFormat( FirstDayOfSuspension , 'DD MMMM YYYY')# to #DateFormat( LastDayOfSuspension , 'DD MMMM YYYY')#</span></td>
													</cfif>
												<cfelse>
													<cfset SuspensionTxt = " - ">
													<cfset SuspensionEmailTxt = "">
													<td align="left"><span class="pix10">#SuspensionTxt#</span></td>
												</cfif>
											</tr>
										</cfoutput>
										</table>	
									</td>
									
								<cfset BodyText = "#BodyText##LineText#">
							</tr>
							
							<tr bgcolor="#rowcolor#" >
								<td colspan="3" align="center" ><a href="RegisterPlayer.cfm?LeagueCode=#LeagueCode#&RI=#RegistrationID#&L=1"><span class="pix10">upd/del</span></a></td>
							</tr>
							
							
							
						</cfif>
					</cfoutput>
				</table>
			</td>
		</tr>
		<tr>
			<td height="40" align="center">
				<cfoutput>
					<span class="pix13bold">Registered as at #DateFormat(Now(), 'DDDD, DD MMMM YYYY')#,  Current = #CurrentlyRegisterdCount#, Future = #FutureRegisterdCount#
				</cfoutput>
			</td>
		</tr>
		<tr>
			<td height="40" align="center" >
				<cfif Numerator GT 0 AND Denominator GT 0>
					<span class="pix13bold">Average age of these players is <cfoutput>#Round(Numerator/Denominator)#</cfoutput></span>
				</cfif>
			</td>
		</tr>
	<cfelse>	<!--- RegistrationCount = 0 --->
		<tr>
			<td height="40" align="center">
				<span class="pix13bold">No registrations</span>
			</td>
		</tr>
	</cfif>
	
	
</table>
<!---
<table width="100%" border="0" cellspacing="2" cellpadding="0" >
	<tr>
		<td height="30" align="center" bgcolor="Aqua">
			<cfoutput>
				<cfif Len(Trim(request.EmailAddr)) IS 0>
					<span class="pix10">Please click <a href="EmailSetUpForm.cfm?LeagueCode=#LeagueCode#"><b>here</b></a> to receive an email of the Players with Current and Future Registrations for #QGetTeam.ClubName#</span>
				<cfelse>
					<span class="pix10">An email of this screen has been sent to <b>#request.EmailAddr#</b><BR>Please click <a href="EmailSetUpForm.cfm?LeagueCode=#LeagueCode#"><b>here</b></a> to change the email address or to turn off automatic emails.</span>
					<cfinclude template="inclInsrtEmailAddr.cfm">
					<cfmail to="#request.EmailAddr#" from="#request.EmailAddr#" type="text"	subject="#SubjectString#">#HdrText##BodyText#</cfmail>
				</cfif>
			</cfoutput>
		</td>
	</tr>
</table>
--->
<table width="100%" border="0" cellpadding="0" cellspacing="2" >
	<tr align="center" bgcolor="white" >
		<td height="10"><span class="pix13bold">&nbsp;</span></td> 
	</tr>

	<tr align="center" bgcolor="white" >
		<cfoutput>
			<td height="40" bgcolor="aqua"><span class="pix13bold">Please <a href="PlayerTeamDetailsXLS.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#TeamID#"><u>click here</u></a> for Microsoft Excel Report</span></td> 
		</cfoutput>
	</tr>
	<tr align="center" bgcolor="white" >
		<td height="10"><span class="pix13bold">&nbsp;</span></td> 
	</tr>
	
	<tr align="center" >
		<td>
			<cfset fmTeamID = TeamID>
			<cfinclude template="inclTeamDetails.cfm">
		</td>
	</tr>
</table>	
<script language="JavaScript" type="text/javascript" src="wz_tooltip.js"></script>
