<!--- this program is no longer in use --->
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>







<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
</cfif>

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
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="CENTER" class="bg_color">
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

	<cfif RegistrationCount GT 0>
		<cfset HdrText = "#CJustify(SeasonName, 100)##CHR(10)##CJustify(LeagueName, 100)##CHR(10)##CHR(10)#">
		<cfset SubjectString ="Registered Players for #QGetTeam.ClubName#  - #LeagueName#  [#SeasonName#]">
		<cfset WorkString = "Registered Players for #QGetTeam.ClubName##CHR(10)##CHR(10)#">
		<cfset HdrText = "#HdrText##CJustify(WorkString, 100)##CHR(10)#">
		<cfset BodyText = "">
	
		<tr>
			<td>
<!---
							*********************************************************
							* Produce list of players who REGISTERED for this club  *
							* Including previously registered players               *
							* Including players whose registration starts in future *
							*********************************************************
--->
				<table border="1" cellspacing="0" cellpadding="3" align="CENTER">
					<cfoutput>
					<cfset ColHeadingsText = "#LJustify('Player Name', LengthOfLongestPlayerName)##RJustify('Reg No', 6)# #CJustify('DoB', 8)# #CJustify('Age', 3)##CJustify('Reg Type', 12)# First Day Last Day#CHR(10)##CHR(10)#">
					<cfset BodyText = "#BodyText##ColHeadingsText#">
					
					<tr>
						<!--- Headings --->
						<td <cfif SortSeq IS "Name">class="bg_highlight"<cfelse>class="bg_color"</cfif>>
							<span class="pix10">
							<a href="RegisteredList.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#TeamID#&SortSeq=Name">Player Name</a>
							</span>
						</td>
						<td <cfif SortSeq IS "RegNo">class="bg_highlight"<cfelse>class="bg_color"</cfif>>
							<span class="pix10">
							<a href="RegisteredList.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#TeamID#&SortSeq=RegNo">Reg No</a>
							</span>
						</td>
						<td <cfif SortSeq IS "DoB">class="bg_highlight"<cfelse>class="bg_color"</cfif>>
							<span class="pix10">
							<a href="RegisteredList.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#TeamID#&SortSeq=DoB">DoB</a>
							</span>
						</td>
						<td <cfif SortSeq IS "Age">class="bg_highlight"<cfelse>class="bg_color"</cfif>>
							<span class="pix10">
							<a href="RegisteredList.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#TeamID#&SortSeq=Age">Age</a>
							</span>
						</td>
						<td <cfif SortSeq IS "RegType">class="bg_highlight"<cfelse>class="bg_color"</cfif>>
							<span class="pix10">
							<a href="RegisteredList.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#TeamID#&SortSeq=RegType">Reg Type</a>
							</span>
						</td>
						<td <cfif SortSeq IS "FirstDay">class="bg_highlight"<cfelse>class="bg_color"</cfif>>
							<span class="pix10">
							<a href="RegisteredList.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#TeamID#&SortSeq=FirstDay">First Day</a>
							</span>
						</td>
						<td align="center"><span class="pix10">Last Day</span></td>
						<td align="center"><span class="pix10">Notes</span></td>
						<td align="center"><span class="pix10">Suspensions</span></td>
					</tr>
					</cfoutput>
					
					<cfset CurrentlyRegisterdCount = 0 >
					<cfset CurrentlyUnregisterdCount = 0 >
					
					<cfoutput query="QThisClubsRegisteredPlayers" group="RegistrationID">
					
					
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


						<cfif DateCompare(Now(),Day001) GE 0 AND DateCompare(Day002, DateAdd('D', -1, Now())) GT 0  >
							<cfset InRange = "Yes">
							<cfset CurrentlyRegisterdCount = CurrentlyRegisterdCount + 1>
						<cfelse>
							<cfset InRange = "No">
							<cfset CurrentlyUnregisterdCount = CurrentlyUnregisterdCount + 1>
							
						</cfif>
						
						<tr <cfif NOT InRange> bgcolor="Silver"</cfif>>
							<!--- Player's name --->
							<td >
							<span class="pix13"><a href="LUList.cfm?LeagueCode=#LeagueCode#&TblName=Player&FirstNumber=#PlayerRegNo#&LastNumber=#PlayerRegNo#">
							<b>#Surname#</b> #Forename#</a></span></td>
							<cfset LineText = "#LJustify('#Surname#, #Forename#', LengthOfLongestPlayerName)#" >
							
							<!--- Player's RegNo --->
							<td>
							<span class="pix10bold">#PlayerRegNo#</span>
							</td>
							<cfset LineText = "#LineText##RJustify(PlayerRegNo, 6)#">
							<!--- Player's DOB --->
							<td align="center">
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
							<td align="center">
								<cfif PlayerDOB IS "">
									<cfset AgeTxt = "--">
								<cfelse>
									<cfset AgeTxt = "#DateDiff( "YYYY",  PlayerDOB, Now() )#" >
									<cfset Age = DateDiff( "YYYY",  PlayerDOB, Now() ) >
									<cfif InRange> <!--- only players who are currently registered and have a DoB will contribute to the average --->
										<cfset Numerator = Numerator + Age>
										<cfset Denominator = Denominator + 1>
									</cfif>
								</cfif>
								<span class="pix10">#AgeTxt#</span>
							</td>
							<cfset LineText = "#LineText#  #CJustify(AgeTxt,2)#">
							
							
								<!--- Registration Type  --->
								
								<cfif     RegType Is 'A'>
									<cfset RegTypeTxt = "Non-Contract    "><td><span class="pix10">#RegTypeTxt#</span></td>
								<cfelseif RegType Is 'B'>
									<cfset RegTypeTxt = "Contract        "><td class="bg_highlight"><span class="pix10">#RegTypeTxt#</span></td>
								<cfelseif RegType Is 'C'>
									<cfset RegTypeTxt = "Short Loan      "><td class="bg_white"><span class="pix10">#RegTypeTxt#</span></td>
								<cfelseif RegType Is 'D'>
									<cfset RegTypeTxt = "Long Loan       "><td class="bg_highlight2"><span class="pix10">#RegTypeTxt#</span></td>
								<cfelseif RegType Is 'E'>
									<cfset RegTypeTxt = "Work Experience "><td class="bg_lightgreen"><span class="pix10">#RegTypeTxt#</span></td>
								<cfelseif RegType Is 'G'>
									<cfset RegTypeTxt = "Lapsed         "><td class="bg_silver"><span class="pix10">#RegTypeTxt#</span></td>
								<cfelseif RegType Is 'F'>
									<cfset RegTypeTxt = "Temporary       "><td class="bg_yellow"><span class="pix10">#RegTypeTxt#</span></td>
								<cfelse>	
									<cfset RegTypeTxt = "ERROR           "><td class="bg_pink"><span class="pix10">#RegTypeTxt#</span></td>
								</cfif>
							
							<cfset LineText = "#LineText# #RegTypeTxt#">
							 
							<td align="center">
								<!--- First Day of Registration --->
								<cfif FirstDayOfRegistration IS "">
									<cfset FirstDayOfRegistrationTxt = "   --   ">
								<cfelse>
									<cfset FirstDayOfRegistrationTxt = "#DateFormat(FirstDayOfRegistration, 'DD/MM/YY')#">
								</cfif>
								<span class="pix10">#FirstDayOfRegistrationTxt#</span>
							</td>
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
							<td width="200"><span class="pix10">#PlayerNotesTxt#</span></td>

							<cfif TRIM(PlayerNotes) IS "">
							<cfelse>
								<cfset LineText = "#LineText#   #PlayerNotes##CHR(10)#">
							</cfif>

								<td>
									<table>
									<cfoutput>
										<tr>
											<cfif FirstDayOfSuspension IS NOT "">
												<cfset SuspensionTxt = "<b>#ROUND(Evaluate((DateDiff("h", FirstDayOfSuspension, LastDayOfSuspension) +25)/ 24))# days</b>
												 from <b>#DateFormat( FirstDayOfSuspension , 'DD MMM YY')#</b>
												  to  <b>#DateFormat( LastDayOfSuspension , 'DD MMM YY')#</b> ">							
												<cfset SuspensionEmailTxt = "SUSPENDED #ROUND(Evaluate((DateDiff("h", FirstDayOfSuspension, LastDayOfSuspension) +25)/ 24))# days from #DateFormat( FirstDayOfSuspension , 'DD MMM YY')# to #DateFormat( LastDayOfSuspension , 'DD MMM YY')#">
												<cfset LineText = "#LineText#   #SuspensionEmailTxt##CHR(10)#">
												<td class="bg_suspend" align="center"><span class="pix10">#SuspensionTxt#</span></td>
											<cfelse>
												<cfset SuspensionTxt = " - ">
												<cfset SuspensionEmailTxt = "">
												<td align="center"><span class="pix10">#SuspensionTxt#</span></td>
											</cfif>
										</tr>
									</cfoutput>
									</table>	
								</td>
							<cfset BodyText = "#BodyText##LineText#">
						</tr>
					</cfoutput>
				</table>
			</td>
		</tr>
		<tr>
			<td height="40" align="center">
				<cfoutput>
					<span class="pix13bold">As at #DateFormat(Now(), 'DDDD, DD MMMM YYYY')#, registered players = #CurrentlyRegisterdCount#<BR>
				</cfoutput>
			</td>
		</tr>
		<cfif CurrentlyUnregisterdCount GT 0 >
		<tr>
			<td height="40" align="center" bgcolor="silver">
				<cfoutput>
						<span class="pix13bold">Transfers = #CurrentlyUnregisterdCount#</span><BR>
				</cfoutput>
			</td>
		</tr>
		</cfif>
		<tr>
			<td height="40" align="center" >
				<cfif Numerator GT 0 AND Denominator GT 0>
					<span class="pix13bold">Average age of currently registered players = <cfoutput>#Round(Numerator/Denominator)#</cfoutput></span>
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
<table width="100%" border="0" cellspacing="2" cellpadding="0" >
	<tr>
		<td height="30" align="center" bgcolor="Aqua">
			<cfoutput>
				<cfif Len(Trim(request.EmailAddr)) IS 0>
					<span class="pix10">Please click <a href="EmailSetUpForm.cfm?LeagueCode=#LeagueCode#"><b>here</b></a> to receive an email of the Registered Players for #QGetTeam.ClubName#</span>
				<cfelse>
					<span class="pix10">An email of the Registered Players for #QGetTeam.ClubName# has been sent to <b>#request.EmailAddr#</b><BR>Please click <a href="EmailSetUpForm.cfm?LeagueCode=#LeagueCode#"><b>here</b></a> to change the email address or to turn off automatic emails.</span>
					<cfinclude template="inclInsrtEmailAddr.cfm">
					<cfmail to="#request.EmailAddr#" from="#request.EmailAddr#" type="text"	subject="#SubjectString#">#HdrText##BodyText#</cfmail>
				</cfif>
			</cfoutput>
		</td>
	</tr>
</table>
