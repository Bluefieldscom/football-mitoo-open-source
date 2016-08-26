<!--- Need to be logged in to see this report --->
<cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>
<cfif ListFind("Yellow",request.SecurityLevel) >
	<cfif request.YellowKey IS NOT "#request.CurrentLeagueCode##request.DropDownTeamID#" >
		<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
		<cfabort>
	</cfif>
</cfif>
<cfinclude template="InclLeagueInfo.cfm">
<link href="fmstyle.css" rel="stylesheet" type="text/css">
<cfset TeamID = request.DropDownTeamID>
<cfinclude template = "queries/qry_QRegistD.cfm">
<cfif QRegistD.RecordCount IS "0">
	<cfoutput>
	<title>#request.DropDownTeamName# Registered Players</title>
	<center><span class="pix13bold"><br /><hr /><br />No players have been registered for #request.DropDownTeamName#<br /><br /><hr /><br /></span></center>
	</cfoutput>
<cfelse>
	<!--- display the query result set as a table with the appropriate headings ---> 
	<cfoutput>
	<table width="100%" border="0" cellspacing="2" cellpadding="0" class="loggedinScreen">
		<tr> 
		  <td height="50" colspan="6" align="CENTER">
		  <span class="pix18bold">#QRegistD.ClubName#<br /><br /></span>
		  <span class="pix13bold">#QRegistD.RecordCount# Players<br /><br />
			 #SeasonName#<BR>#LeagueName#<br /><br />#DateFormat(Now(), 'DDDD, DD MMMM YYYY')#</span></td>
		</tr>
		<cfif HideSuspensions IS "1" AND ListFind("Yellow",request.SecurityLevel) >
			<tr> 
			  <td height="20" colspan="6" align="CENTER">
			  <span class="pix13boldred">Please note that information regarding suspensions has been suppressed at the request of the league</span></td>
			</tr>
		</cfif>
		<title>#QRegistD.ClubName# Registered Players</title>
	</cfoutput> 
	

	
	<cfset Denominator = 0> 
	<cfset Numerator = 0> 
	  <!---
			************
			* Headings *
			************
			--->
	<cfoutput>
	  
	<tr> 
	  <td height="30"><span class="pix13bold">RegNo</span></td>
	  <td height="30"><span class="pix13bold">Name</span></td>
	  <td height="30"><span class="pix13bold">FAN</span></td>
	  <td height="30"><span class="pix13bold">Date of Birth</span></td>
	  <td height="30"><span class="pix13bold">Age</span></td>
	  <td height="30"><span class="pix13bold">Appearances</span></td>
	</tr>
	<tr> 
	  <td height="10" colspan="5"><span class="pix13bold"></span></td>
	  <td>
		  <table border="1" cellpadding="2" cellspacing="0">
			  <tr>
			  	  <td rowspan="2" align="center" valign="top" ><span class="pix10bold">Started</span></td>
			  	  <td colspan="2" align="center" valign="top"><span class="pix10bold">Sub Used?</span></td>
				  
			  </tr>
			  <tr>
			  	  <td align="center" bgcolor="silver"><span class="pix10bold">Yes</span></td>
			  	  <td align="center" bgcolor="white"><span class="pix10bold">No</span></td>
			  </tr>

		  </table>
		  
	  </td>
	</tr>
	</cfoutput>
	
	<cfoutput query="QRegistD" group="ExpiredReg">
		<cfset PlayerCount = 0 >
		<cfif ExpiredReg IS "A">
	  		<tr><td colspan="6" align="center"><span class="pix18bold">Current Registrations</span></td></tr>
		<cfelseif ExpiredReg IS "B">
	  		<tr><td colspan="6" align="center"><span class="pix18bold">Expired Registrations</span></td></tr>
		<cfelse>
	  		<tr><td colspan="6" align="center"><span class="pix18bold">ERROR</span></td></tr>
		</cfif>
	<cfoutput   group="RPID">
	  <tr><td colspan="5"><span class="pix13">#RepeatString(".&nbsp;", 100)#</span></td></tr>
	  <tr  <cfif ExpiredReg IS "B">bgcolor="silver"</cfif> >	
		<!---
			*******************
			* Player's Reg No *
			*******************
			--->
		<td height="50" valign="top"><span class="pix13">#PlayerRegNo#</span></td>
		<!---
			******************
			* Player's name  *
			******************
			--->
		<td height="50" valign="top"><span class="pix13"><strong>#Surname#</strong> #Forename#</span></td>
		<!---
			******************
			* FAN            *
			******************
			--->
		<td  height="50" valign="top"><span class="pix13">#FAN#</span></td>

		<!---
			******************
			* Date of Birth  *
			******************
			--->
		<cfif PlayerDOB IS "">
			<td height="50" valign="top"><span class="pix13">&nbsp</span></td>
		<cfelse>
			<td height="50" valign="top"><span class="pix13">#DateFormat( PlayerDOB , 'DD/MM/YY')#</span></td>
		</cfif>
		<!---
			********
			* Age  *
			********
			--->
		<cfif PlayerDOB IS "">
			<td height="50" valign="top"><span class="pix13">&nbsp;</span></td>
		<cfelse>
			<td height="50" valign="top"><span class="pix13">#DateDiff( "YYYY",  PlayerDOB, Now() )#</span></td>
			<cfset Numerator = Numerator + DateDiff( "YYYY",  PlayerDOB, Now() )>
			<cfset Denominator = Denominator + 1>
		</cfif>
		
		
<!---
					****************************************************
					* appearances made including those for other teams *
					****************************************************
--->
<cfset ThisPlayerID = QRegistD.RPID >
<cfset CurrentTeamID = TeamID >
<cfinclude template="queries/qry_QGetAllTeams.cfm">
<cfif QGetAllTeams.RecordCount GT 0>
	<td height="50" valign="top">
		<table width="50%" border="0" cellpadding="1" cellspacing="1">
			<cfloop query="QGetAllTeams">
				<cfset SpecifiedTeamID = QGetAllTeams.TeamID >
				<cfinclude template="queries/qry_QGetOtherAppearances2.cfm">
				<cfif QGetOtherAppearances2.TimesAppeared GT 0 >
					<tr>
						<cfif CurrentTeamID IS SpecifiedTeamID>
							<td><span class="pix10">for #QGetAllTeams.LongCol#:</span></td>
						<cfelse>
							<td><span class="pix10">for <u>#QGetAllTeams.LongCol#</u>:</span></td>
						</cfif>
					</tr>
					<cfloop query="QGetOtherAppearances2">
						<tr>
							<td><span class="pix10">#CompetitionName#</span></td>
							<td>
								<table border="1" cellpadding="2" cellspacing="0">
									<tr>
										<td><span class="pix10">#apps1#</span></td>
										<td bgcolor="silver"><span class="pix10">#apps2#</span></td>
										<td bgcolor="white"><span class="pix10">#apps3#</span></td>
									</tr>
								</table>
							</td>
						</tr>
					</cfloop>
				<cfelse>
					<tr>
						<td><span class="pix10">NONE for #QGetAllTeams.LongCol#</span></td>
					</tr>
				</cfif>
			</cfloop>
		</table>
	</td>
</cfif>
</tr>


		<cfif LEN(TRIM(PlayerNotes)) GT 0 >
			<tr>
			<!---
				*********
				* Notes *
				*********
				--->
				<td></td>
				<td><span class="pix10">#PlayerNotes#</span></td>
			</tr>
		</cfif>
<!---
					***************
					* Appearances *
					***************

				  <cfset PI = RPID >
				  <cfinclude template = "queries/qry_QPlayerHistory2.cfm">
				  <cfset ListOfCompetitionNames=ValueList(QPlayerHistory2.CompetitionName)>
				  <cfset ListOfCompCounts=ValueList(QPlayerHistory2.CompCount)>
				<tr>
				<td></td>
				<td colspan="7">
					<span class="pix10">
						<cfif ListLen(ListOfCompCounts) IS 0>
							No Appearances
						<cfelse>
							<cfloop index="I" from="1" to="#ListLen(ListOfCompetitionNames)#" step="1" ><cfif I GT 1>, </cfif>#ListGetAt(ListOfCompCounts, I)# in #ListGetAt(ListOfCompetitionNames, I)#</cfloop>
						</cfif>
					</span>
				</td>
				</tr>
--->				
				
<!---
					***************
					* Suspensions *
					***************
--->
				<cfif HideSuspensions IS "1" AND ListFind("Yellow",request.SecurityLevel) >
				<!--- don't display suspensions --->
				<cfelse>
					<cfinclude template = "queries/qry_GetRegListSuspension.cfm">
					<cfset ListOfFirstDays=ValueList(QSuspens.FirstDay)>
					<cfset ListOfLastDays=ValueList(QSuspens.LastDay)>
					<cfset ListOfNumberOfMatches=ValueList(QSuspens.NumberOfMatches)>
					<cfif QSuspens.RecordCount IS 0>
						<cfset ListOfFirstDays = ListAppend(ListOfFirstDays, 0)>
						<cfset ListOfLastDays = ListAppend(ListOfLastDays, 0)>
						<cfset ListOfNumberOfMatches = ListAppend(ListOfNumberOfMatches, 0)>
					<cfelse>
						<cfset FDay = ListGetAt(ListOfFirstDays, 1)>
						<cfset LDay = ListGetAt(ListOfLastDays, 1)>
						<cfset NoM  = ListGetAt(ListOfNumberOfMatches, 1)>
						<tr>
							<td colspan="1"  rowspan="#ListLen(ListOfFirstDays)#">
								<span class="pix10"><u>#ListLen(ListOfFirstDays)# <cfif ListLen(ListOfFirstDays) IS 1>Suspension<cfelse>Suspensions</cfif></u></span>
							</td>
							
							<cfloop index="I" from="1" to="#ListLen(ListOfFirstDays)#" step="1" >
								<cfset FDay = ListGetAt(ListOfFirstDays, I)>
								<cfset LDay = ListGetAt(ListOfLastDays, I)>
								<cfset NoM  = ListGetAt(ListOfNumberOfMatches, I)>
								<!--- last day LDay will be 2999-12-31 for match based suspension --->
								
								<cfif NoM GT 0><!---  match based suspension --->
									<cfif LDay IS '2999-12-31'><!---  ongoing match based suspension --->
										<td  colspan="4"><span class="pix10">Ongoing #NoM# match suspension starting #DateFormat( FDay , 'DD MMMM YYYY')# </span></td>
									<cfelse>
										<td  colspan="4"><span class="pix10">Served #NoM# match suspension from #DateFormat( FDay , 'DD MMMM YYYY')# to #DateFormat( LDay , 'DD MMMM YYYY')#</span></td>
									</cfif>
								<cfelse>
									<td  colspan="4"><span class="pix10">#ROUND(Evaluate((DateDiff("h", FDay, LDay) +25)/ 24))# days suspension from #DateFormat( FDay , 'DD MMMM YYYY')# to #DateFormat( LDay , 'DD MMMM YYYY')#</span></td>
								</cfif>
								</tr>
							</cfloop>
						</tr>
					</cfif>
				</cfif>

		<cfoutput>
		<tr>
			<td><span class="pix10"></span></td>
			<td colspan="4">
			
			<span class="pix10">
			<cfif LastDayOfRegistration IS NOT "" >
				<cfif DateCompare(LastDayOfRegistration,Now()) IS -1>
					Expired
				<cfelseif DateCompare(LastDayOfRegistration,Now()) IS 1>
					Expires in #DateDiff('D',Now(),LastDayOfRegistration)+1# days
				<cfelse>
				</cfif>
			</cfif>	
			<CFSWITCH expression="#RegType#">
				<CFCASE VALUE="A">
					<cfif FirstDayOfRegistration IS "" AND LastDayOfRegistration IS "">
						Non-Contract
					<cfelseif FirstDayOfRegistration IS NOT "" AND LastDayOfRegistration IS "">
						Non-Contract from #DateFormat(FirstDayOfRegistration, 'DD MMM YY')#
					<cfelseif FirstDayOfRegistration IS "" AND LastDayOfRegistration IS NOT "">
						Non-Contract to #DateFormat(LastDayOfRegistration, 'DD MMM YY')#
					<cfelse>
						Non-Contract from #DateFormat(FirstDayOfRegistration, 'DD MMM YY')# to #DateFormat(LastDayOfRegistration, 'DD MMM YY')#
					</cfif>
				</CFCASE>
				<CFCASE VALUE="B">
					<cfif FirstDayOfRegistration IS "" AND LastDayOfRegistration IS "">
						Contract
					<cfelseif FirstDayOfRegistration IS NOT "" AND LastDayOfRegistration IS "">
						Contract from #DateFormat(FirstDayOfRegistration, 'DD MMM YY')#
					<cfelseif FirstDayOfRegistration IS "" AND LastDayOfRegistration IS NOT "">
						Contract to #DateFormat(LastDayOfRegistration, 'DD MMM YY')#
					<cfelse>
						Contract from #DateFormat(FirstDayOfRegistration, 'DD MMM YY')# to #DateFormat(LastDayOfRegistration, 'DD MMM YY')#
					</cfif>
				</CFCASE>
				<CFCASE VALUE="C">
					<cfif FirstDayOfRegistration IS "" AND LastDayOfRegistration IS "">
						Short Loan
					<cfelseif FirstDayOfRegistration IS NOT "" AND LastDayOfRegistration IS "">
						Short Loan from #DateFormat(FirstDayOfRegistration, 'DD MMM YY')#
					<cfelseif FirstDayOfRegistration IS "" AND LastDayOfRegistration IS NOT "">
						Short Loan to #DateFormat(LastDayOfRegistration, 'DD MMM YY')#
					<cfelse>
						Short Loan from #DateFormat(FirstDayOfRegistration, 'DD MMM YY')# to #DateFormat(LastDayOfRegistration, 'DD MMM YY')#
					</cfif>
				</CFCASE>
				<CFCASE VALUE="D">
					<cfif FirstDayOfRegistration IS "" AND LastDayOfRegistration IS "">
						Long Loan
					<cfelseif FirstDayOfRegistration IS NOT "" AND LastDayOfRegistration IS "">
						Long Loan from #DateFormat(FirstDayOfRegistration, 'DD MMM YY')#
					<cfelseif FirstDayOfRegistration IS "" AND LastDayOfRegistration IS NOT "">
						Long Loan to #DateFormat(LastDayOfRegistration, 'DD MMM YY')#
					<cfelse>
						Long Loan from #DateFormat(FirstDayOfRegistration, 'DD MMM YY')# to #DateFormat(LastDayOfRegistration, 'DD MMM YY')#
					</cfif>
				</CFCASE>
				<CFCASE VALUE="E">
					<cfif FirstDayOfRegistration IS "" AND LastDayOfRegistration IS "">
						Work Experience
					<cfelseif FirstDayOfRegistration IS NOT "" AND LastDayOfRegistration IS "">
						Work Experience from #DateFormat(FirstDayOfRegistration, 'DD MMM YY')#
					<cfelseif FirstDayOfRegistration IS "" AND LastDayOfRegistration IS NOT "">
						Work Experience to #DateFormat(LastDayOfRegistration, 'DD MMM YY')#
					<cfelse>
						Work Experience from #DateFormat(FirstDayOfRegistration, 'DD MMM YY')# to #DateFormat(LastDayOfRegistration, 'DD MMM YY')#
					</cfif>
				</CFCASE>
				<CFCASE VALUE="G">
					<cfif FirstDayOfRegistration IS "" AND LastDayOfRegistration IS "">
						Lapsed
					<cfelseif FirstDayOfRegistration IS NOT "" AND LastDayOfRegistration IS "">
						Lapsed from #DateFormat(FirstDayOfRegistration, 'DD MMM YY')#
					<cfelseif FirstDayOfRegistration IS "" AND LastDayOfRegistration IS NOT "">
						Lapsed to #DateFormat(LastDayOfRegistration, 'DD MMM YY')#
					<cfelse>
						Lapsed from #DateFormat(FirstDayOfRegistration, 'DD MMM YY')# to #DateFormat(LastDayOfRegistration, 'DD MMM YY')#
					</cfif>
				</CFCASE>
				<CFCASE VALUE="F">
					<cfif FirstDayOfRegistration IS "" AND LastDayOfRegistration IS "">
						Temporary
					<cfelseif FirstDayOfRegistration IS NOT "" AND LastDayOfRegistration IS "">
						Temporary from #DateFormat(FirstDayOfRegistration, 'DD MMM YY')#
					<cfelseif FirstDayOfRegistration IS "" AND LastDayOfRegistration IS NOT "">
						Temporary to #DateFormat(LastDayOfRegistration, 'DD MMM YY')#
					<cfelse>
						Temporary from #DateFormat(FirstDayOfRegistration, 'DD MMM YY')# to #DateFormat(LastDayOfRegistration, 'DD MMM YY')#
					</cfif>
				</CFCASE>
				<CFDEFAULTCASE> <!--- Only A to F used at present - Should never get here! ABORT --->
					Error in LUList.cfm - RegType <cfoutput>#RegType#</cfoutput> ..... ABORTING
					<CFABORT> 
				</CFDEFAULTCASE>
			</CFSWITCH>

			</span>
			</td>
		</tr>
		</cfoutput>
		<cfset PlayerCount = PlayerCount + 1 >
	</cfoutput>
	<cfif Numerator GT 0 AND Denominator GT 0>
	  <tr> 
		<td height="50" colspan="5" align="CENTER" valign="MIDDLE"><span class="pix13bold">#PlayerCount# Players - Average Age is #Round(Numerator/Denominator)#</span></td>
	  </tr>
	</cfif>
	<cfset Denominator = 0> 
	<cfset Numerator = 0> 
	  <tr> 
		<td height="80" colspan="5" align="CENTER" valign="MIDDLE"><span class="pix10">#RepeatString(".&nbsp;", 120)#</span></td>
	  </tr>
	
	</cfoutput>
  </table>
</cfif>

