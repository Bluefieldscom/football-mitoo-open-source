<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>

<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfsetting enablecfoutputonly="yes">
<CFCONTENT type="application/msexcel">
<cfheader name="Content-Disposition" value="filename=PlayerTeamDetails.xls">
<!--- applies to season 2012 onwards only --->
<cfif RIGHT(request.dsn,4) GE 2012>
	<cfset ThisColSpan = 16 >
<cfelse>
	<cfset ThisColSpan = 10 >
</cfif>
<cfoutput>
	<table border="1">
		<tr> <td width="100%" colspan="#ThisColSpan#" align="center" valign="top"><strong>#SeasonName#</strong></td></tr>
		<tr> <td width="100%"  colspan="#ThisColSpan#" align="center" valign="top" bgcolor="silver"><strong>#LeagueName#</strong></td></tr>
		<tr> <td width="100%"  colspan="#ThisColSpan#" align="center" valign="top"><strong>#QGetTeam.ClubName#: Players with Current and Future Registrations on #DateFormat(Now(),'DD MMMM YYYY')#</strong></td></tr>
	</table>
</cfoutput>
<cfset SortSeq = "Name">
<cfinclude template="queries/qry_QThisClubsRegisteredPlayers.cfm">
<cfoutput>
<table border="1">
	<tr bgcolor="silver">
		<td>Surname</td>
		<td>Forenames</td>
	<!--- applies to season 2012 onwards only --->
	<cfif RIGHT(request.dsn,4) GE 2012>
		
		<td>Address 1</td>
		<td>Address 2</td>
		<td>Address 3</td>
		<td>Post Code</td>
		<td>Email</td>
		<td>FAN</td>
	</cfif>
		<td>Reg No</td>
		<td>Date of Birth</td>
		<td>Age</td>
		<td>Reg Type</td>
		<td>First Day</td>
		<td>Last Day</td>
		<td>Notes</td>
		<td>Suspensions</td>
	</tr>
</cfoutput>
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
					
						<cfif NOT ExpiredRegistration>
							<tr>
								<!--- Player's surname --->
								<td valign="top"><span class="pix13">#Surname#</span></td>
								<!--- Player's forenames --->
								<td valign="top"><span class="pix13">#Forename#</span></td>
								<!--- applies to season 2012 onwards only --->
								<cfif RIGHT(request.dsn,4) GE 2012>
								
									<!--- Player's 3 address lines and postcode --->
									<td valign="top"><span class="pix10">#AddressLine1#</span></td>
									<td valign="top"><span class="pix10">#AddressLine2#</span></td>
									<td valign="top"><span class="pix10">#AddressLine3#</span></td>
									<td valign="top"><span class="pix10">#Postcode#</span></td>
									<!--- Player's email --->
									<td valign="top"><span class="pix10">#Email1#</span></td>
									<!--- FAN --->
									<td valign="top"><span class="pix10">#FAN#</span></td>
								</cfif>
								<!--- Player's RegNo --->
								<td valign="top"><span class="pix10bold">#PlayerRegNo#</span></td>
								<!--- Player's DOB --->
								<td valign="top" align="center">
									<cfif PlayerDOB IS "">
									<!--- Date of Birth is missing --->
										<cfset DoBTxt = "   --   ">
									<cfelse>
										<cfset DoBTxt = "#DateFormat(PlayerDOB, 'DD/MM/YY')#">
									</cfif>
									<span class="pix10">#DoBTxt#</span>
								</td>
								<!--- Player's Age --->
								<td valign="top" align="center">
									<cfif PlayerDOB IS "">
										<cfset AgeTxt = "--">
									<cfelse>
										<cfset AgeTxt = "#DateDiff( "YYYY",  PlayerDOB, Now() )#" >
										<!--- only players who are currently registered and have a DoB will contribute to the average --->
									</cfif>
									<span class="pix10">#AgeTxt#</span>
								</td>
								
									<!--- Registration Type  --->
									
									<cfif     RegType Is 'A'>
										<cfset RegTypeTxt = "Non-Contract    "><td valign="top"><span class="pix10">#RegTypeTxt#</span></td>
									<cfelseif RegType Is 'B'>
										<cfset RegTypeTxt = "Contract        "><td valign="top"><span class="pix10">#RegTypeTxt#</span></td>
									<cfelseif RegType Is 'C'>
										<cfset RegTypeTxt = "Short Loan      "><td valign="top"><span class="pix10">#RegTypeTxt#</span></td>
									<cfelseif RegType Is 'D'>
										<cfset RegTypeTxt = "Long Loan       "><td valign="top"><span class="pix10">#RegTypeTxt#</span></td>
									<cfelseif RegType Is 'E'>
										<cfset RegTypeTxt = "Work Experience "><td valign="top"><span class="pix10">#RegTypeTxt#</span></td>
									<cfelseif RegType Is 'G'>
										<cfset RegTypeTxt = "Lapsed          "><td valign="top"><span class="pix10">#RegTypeTxt#</span></td>
									<cfelseif RegType Is 'F'>
										<cfset RegTypeTxt = "Temporary       "><td valign="top"><span class="pix10">#RegTypeTxt#</span></td>
									<cfelse>	
										<cfset RegTypeTxt = "ERROR           "><td valign="top"><span class="pix10">#RegTypeTxt#</span></td>
									</cfif>
									
								<!--- First Day of Registration --->
								<cfif FirstDayOfRegistration IS "">
									<cfset FirstDayOfRegistrationTxt = "   --   ">
								<cfelse>
									<cfset FirstDayOfRegistrationTxt = "#DateFormat(FirstDayOfRegistration, 'DD/MM/YY')#">
								</cfif>
								<td valign="top" align="center"><span class="pix10">#FirstDayOfRegistrationTxt#</span></td>
								<td valign="top" align="center">
									<!--- Last Day of Registration --->
									<cfif LastDayOfRegistration IS "">
										<cfset LastDayOfRegistrationTxt = "   --   ">
									<cfelse>
										<cfset LastDayOfRegistrationTxt = "#DateFormat(LastDayOfRegistration, 'DD/MM/YY')#">
									</cfif>
									<span class="pix10">#LastDayOfRegistrationTxt#</span>
								</td>
									<!--- Player Notes --->
								<cfset PlayerNotesTxt = "#PlayerNotes#">
								<td valign="top"><span class="pix10">#PlayerNotesTxt#</span></td>
								<td>
									<table border="1">
										<cfoutput>
											<tr>
												<cfif FirstDayOfSuspension IS NOT "" AND NumberOfMatches IS 0>
													<cfset SuspensionTxt = "#ROUND(Evaluate((DateDiff("h", FirstDayOfSuspension, LastDayOfSuspension) +25)/ 24))# days from #DateFormat( FirstDayOfSuspension , 'DD MMM YY')# to  #DateFormat( LastDayOfSuspension , 'DD MMM YY')# ">							
													<td valign="top"><span class="pix10">#SuspensionTxt#</span></td>
												<cfelseif NumberOfMatches GT 0><!---  match based suspension --->	
													<cfif LastDayOfSuspension IS '2999-12-31'><!---  ongoing match based suspension --->
														<td valign="top"><span class="pix10">Ongoing #NumberOfMatches# match suspension starting #DateFormat( FirstDayOfSuspension , 'DD MMMM YYYY')# </span></td>
													<cfelse>
														<td valign="top"><span class="pix10">Served #NumberOfMatches# match suspension from #DateFormat( FirstDayOfSuspension , 'DD MMMM YYYY')# to #DateFormat( LastDayOfSuspension , 'DD MMMM YYYY')#</span></td>
													</cfif>
												<cfelse>
													<cfset SuspensionTxt = "">
													<td valign="top"><span class="pix10">#SuspensionTxt#</span></td>
												</cfif>
											</tr>
										</cfoutput>
									</table>	
								</td>
							</tr>
						</cfif>
</cfoutput>
</table>
