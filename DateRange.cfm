<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">

<cfform action="DateRange.cfm?LeagueCode=#LeagueCode#" method="post" name="DateRangeForm">
	<cfif  StructKeyExists(form, "StateVector")>
		<cfset request.Date001 = DateFormat(GetToken(form.FirstDay,2,","), 'YYYY-MM-DD')>
		<cfset request.Date002 = DateFormat(GetToken(form.LastDay,2,","),  'YYYY-MM-DD')>
		<cfif Evaluate(DateDiff("D", GetToken(form.FirstDay,2,","), GetToken(form.LastDay,2,","))+1) LE 0>
			<!--- check to see if the first date is greater than the last date! --->
			<cfoutput>
				<span class="pix18boldred">DATE RANGE ERROR - from #form.FirstDay# to #form.LastDay#<br /><br /></span>
				<span class="pix10boldred">Please click on the Back button of your browser....</b><br /><br /><br /></span>
			</cfoutput>
			<cfabort>
		</cfif>
<!---			
											************************
											* Registered (by date) *	
											************************
--->
		<cfif Form.Action IS "Registered (by date)">
			<cfinclude template = "queries/qry_RegisteredPlayersByDate.cfm">
			<table width="100%" border="0" cellpadding="2" cellspacing="0">
				<tr align="center">
					<cfoutput>
					<td align="left" height="40" colspan="9"><span class="pix18bold">#RegisteredPlayersByDate.RecordCount# players registered between #DateFormat(request.Date001, 'DD MMM YYYY')# and #DateFormat(request.Date002, 'DD MMM YYYY')#</span></td>
					</cfoutput>
				</tr>
				<tr>
					<td align="left"><span class="pix10bold">Date</span></td>
					<td align="left"><span class="pix10bold">Club</span></td>
					<td align="left"><span class="pix10bold">Forenames</span></td>
					<td align="left"><span class="pix10bold">Surname</span></td>
					<td align="left"><span class="pix10bold">Reg No</span></td>
					<!--- applies to season 2012 onwards only --->
					<cfif RIGHT(request.dsn,4) GE 2012>
						<td align="left"><span class="pix10bold">Address / <em>Notes</em></span></td>
					<cfelse>
						<td align="left"><span class="pix10bold">Notes</span></td>
					</cfif>
					<td align="center"><span class="pix10bold">Age</span></td>
					<td align="center"><span class="pix10bold">Date of Birth</span></td>
					<td align="left"><span class="pix10bold">Reg Type</span></td>
					<td align="left"><span class="pix10bold">Last Day</span></td>
				</tr>
				<cfoutput query="RegisteredPlayersByDate" group="FirstDay">
					<tr>
						<td align="left" height="20"><span class="pix10bold">#DateFormat(FirstDay, 'DDD, DD MMM YYYY')#</span></td>
					</tr>
					<cfoutput>
						<tr>
							<td align="left" valign="top"><span class="pix10">&nbsp;</span></td>
							<td align="left" valign="top"><span class="pix10">#ClubName#</span></td>
							<td align="left" valign="top"><span class="pix10">#Forename#</span></td>
							<td align="left" valign="top"><span class="pix10">#Surname#</span></td>
							<td align="left" valign="top"><span class="pix10">#RegNo#</span></td>
							<cfif RIGHT(request.dsn,4) GE 2012>
								<cfif len(trim("#AddressLine1##AddressLine2##AddressLine3##Postcode##PNotes#")) IS 0>         <!--- no address and no notes --->
									<td width="120" align="left" valign="top"><span class="pix10">&nbsp;</span></td>
								<cfelseif len(trim("#AddressLine1##AddressLine2##AddressLine3##Postcode#")) IS 0>         <!--- notes only --->
									<td width="120" align="left" valign="top"><span class="pix10"><em>#PNotes#</em></span></td>
								<cfelseif len(trim("#PNotes#")) IS 0>                                               <!--- address only --->
									<td width="120" align="left" valign="top"><span class="pix10">#AddressLine1#&nbsp;&##8226;&nbsp;#AddressLine2#&nbsp;&##8226;&nbsp;#AddressLine3#&nbsp;&##8226;&nbsp;#Postcode#</span></td>
								<cfelse>                                                                       <!--- address and notes --->
									<td width="120" align="left" valign="top"><span class="pix10">#AddressLine1#&nbsp;&##8226;&nbsp;#AddressLine2#&nbsp;&##8226;&nbsp;#AddressLine3#&nbsp;&##8226;&nbsp;#Postcode#<br><em>#PNotes#</em></span></td>
								</cfif>
							<!--- BEFORE season 2012 --->
							<cfelse>	
								<cfif len(trim("#PNotes#")) IS 0> <!---  no notes --->
									<td width="120" align="left" valign="top"><span class="pix10">&nbsp;</span></td>     
								<cfelse> <!--- notes --->
									<td width="120" align="left" valign="top"><span class="pix10">#PNotes#</span></td>
								</cfif>
							</cfif>
							<cfif IsDate(DOB)>
								<td align="center" valign="top"><span class="pix10">#DateDiff( "YYYY", DOB, Now() )#</span></td>
								<td align="center" valign="top"><span class="pix10">#DateFormat(DOB,'dd/mm/yyyy')#</span></td>								
							<cfelse>
								<td align="center" valign="top"><span class="pix10">-</span></td>
								<td align="center" valign="top"><span class="pix10">-</span></td>
							</cfif>
							<cfif RegType IS "A">
								<td align="left" valign="top"><span class="pix10">Non-Contract</span></td>
							<cfelseif RegType IS "B">
								<td align="left" valign="top"><span class="pix10">Contract</span></td>
							<cfelseif RegType IS "C">
								<td align="left" valign="top"><span class="pix10">Short Loan</span></td>
							<cfelseif RegType IS "D">
								<td align="left" valign="top"><span class="pix10">Long Loan</span></td>
							<cfelseif RegType IS "E">
								<td align="left" valign="top"><span class="pix10">Work Experience</span></td>
							<cfelseif RegType IS "G">
								<td align="left" valign="top"><span class="pix10">Lapsed</span></td>
							<cfelseif RegType IS "F">
								<td align="left" valign="top"><span class="pix10">Temporary</span></td>
							<cfelseif RegType IS "X">
								<td align="left" valign="top"><span class="pix10">X=Unknown</span></td>
							</cfif>
							<cfif LastDay IS "">
								<td align="left" valign="top"><span class="pix10">&nbsp;</span></td>
							<cfelse>
								<td align="left" valign="top"><span class="pix10">#DateFormat(LastDay, 'DDD, DD MMM YYYY')#</span></td>
							</cfif>
						</tr>
					</cfoutput>
				</cfoutput>
				<tr align="center">
					<td align="left" height="50" colspan="8"><span class="pix10">&nbsp;</span></td>
				</tr>
			</table>
<!---			
											************************
											* Registered (by club) *	
											************************
--->
		<cfelseif Form.Action IS "Registered (by club)">
			<cfinclude template = "queries/qry_RegisteredPlayersByClub.cfm">
			<table width="100%" border="0" cellpadding="2" cellspacing="0">
				<tr align="center">
					<cfoutput>
					<td align="left" height="40" colspan="9"><span class="pix18bold">#RegisteredPlayersByClub.RecordCount# players registered between #DateFormat(request.Date001, 'DD MMM YYYY')# and #DateFormat(request.Date002, 'DD MMM YYYY')#</span></td>
					</cfoutput>
				</tr>
				<tr>
					<td align="left"><span class="pix10bold">Club</span></td>
					<td align="left"><span class="pix10bold">Forenames</span></td>
					<td align="left"><span class="pix10bold">Surname</span></td>
					<td align="left"><span class="pix10bold">Reg No</span></td>
					<!--- applies to season 2012 onwards only --->
					<cfif RIGHT(request.dsn,4) GE 2012>
						<td align="left"><span class="pix10bold">Address / <em>Notes</em></span></td>
					<cfelse>
						<td align="left"><span class="pix10bold">Notes</span></td>
					</cfif>
					<td align="center"><span class="pix10bold">Age</span></td>
					<td align="center"><span class="pix10bold">Date of Birth</span></td>
					<td align="left"><span class="pix10bold">Reg Type</span></td>
					<td align="left"><span class="pix10bold">First Day</span></td>
					<td align="left"><span class="pix10bold">Last Day</span></td>
				</tr>
				<cfoutput query="RegisteredPlayersByClub" group="ClubName">
					<tr>
						<td align="left" valign="top" height="20"><span class="pix10bold">#ClubName#</span></td>
					</tr>
					<cfoutput>
						<tr>
							<td align="left" valign="top"><span class="pix10">&nbsp;</span></td>
							<td align="left" valign="top"><span class="pix10">#Forename#</span></td>
							<td align="left" valign="top"><span class="pix10">#Surname#</span></td>
							<td align="left" valign="top"><span class="pix10">#RegNo#</span></td>
							<cfif RIGHT(request.dsn,4) GE 2012>
								<cfif len(trim("#AddressLine1##AddressLine2##AddressLine3##Postcode##PNotes#")) IS 0>         <!--- no address and no notes --->
									<td width="120" align="left" valign="top"><span class="pix10">&nbsp;</span></td>
								<cfelseif len(trim("#AddressLine1##AddressLine2##AddressLine3##Postcode#")) IS 0>         <!--- notes only --->
									<td width="120" align="left" valign="top"><span class="pix10"><em>#PNotes#</em></span></td>
								<cfelseif len(trim("#PNotes#")) IS 0>                                               <!--- address only --->
									<td width="120" align="left" valign="top"><span class="pix10">#AddressLine1#&nbsp;&##8226;&nbsp;#AddressLine2#&nbsp;&##8226;&nbsp;#AddressLine3#&nbsp;&##8226;&nbsp;#Postcode#</span></td>
								<cfelse>                                                                       <!--- address and notes --->
									<td width="120" align="left" valign="top"><span class="pix10">#AddressLine1#&nbsp;&##8226;&nbsp;#AddressLine2#&nbsp;&##8226;&nbsp;#AddressLine3#&nbsp;&##8226;&nbsp;#Postcode#<br><em>#PNotes#</em></span></td>
								</cfif>
							<!--- BEFORE season 2012 --->
							<cfelse>	
								<cfif len(trim("#PNotes#")) IS 0> <!---  no notes --->
									<td width="120" align="left" valign="top"><span class="pix10">&nbsp;</span></td>     
								<cfelse> <!--- notes --->
									<td width="120" align="left" valign="top"><span class="pix10">#PNotes#</span></td>
								</cfif>
							</cfif>
							<cfif IsDate(DOB)>
								<td align="center" valign="top"><span class="pix10">#DateDiff( "YYYY", DOB, Now() )#</span></td>
								<td align="center" valign="top"><span class="pix10">#DateFormat(DOB,'dd/mm/yyyy')#</span></td>								
							<cfelse>
								<td align="center" valign="top"><span class="pix10">-</span></td>
								<td align="center" valign="top"><span class="pix10">-</span></td>
							</cfif>
							<cfif RegType IS "A">
								<td align="left" valign="top"><span class="pix10">Non-Contract</span></td>
							<cfelseif RegType IS "B">
								<td align="left" valign="top"><span class="pix10">Contract</span></td>
							<cfelseif RegType IS "C">
								<td align="left" valign="top"><span class="pix10">Short Loan</span></td>
							<cfelseif RegType IS "D">
								<td align="left" valign="top"><span class="pix10">Long Loan</span></td>
							<cfelseif RegType IS "E">
								<td align="left" valign="top"><span class="pix10">Work Experience</span></td>
							<cfelseif RegType IS "G">
								<td align="left" valign="top"><span class="pix10">Lapsed</span></td>
							<cfelseif RegType IS "F">
								<td align="left" valign="top"><span class="pix10">Temporary</span></td>
							<cfelseif RegType IS "X">
								<td align="left" valign="top"><span class="pix10">X=Unknown</span></td>
							</cfif>
							<cfif FirstDay IS "">
								<td align="left" valign="top"><span class="pix10">&nbsp;</span></td>
							<cfelse>
								<td align="left" valign="top"><span class="pix10">#DateFormat(FirstDay, 'DDD, DD MMM YYYY')#</span></td>
							</cfif>
							<cfif LastDay IS "">
								<td align="left" valign="top"><span class="pix10">&nbsp;</span></td>
							<cfelse>
								<td align="left" valign="top"><span class="pix10">#DateFormat(LastDay, 'DDD, DD MMM YYYY')#</span></td>
							</cfif>
						</tr>
					</cfoutput>
				</cfoutput>
				<tr align="center">
					<td height="50" colspan="8"><span class="pix10">&nbsp;</span></td>
				</tr>
			</table>
<!---			
											**************************
											* Deregistered (by date) *	
											**************************
--->
		<cfelseif Form.Action IS "Deregistered (by date)">
			<cfinclude template = "queries/qry_DeregisteredPlayersByDate.cfm">
			<table width="100%" border="0" cellpadding="2" cellspacing="0">
				<tr align="center">
					<cfoutput>
					<td align="left" height="40" colspan="9"><span class="pix18bold">#DeregisteredPlayersByDate.RecordCount# players deregistered between #DateFormat(request.Date001, 'DD MMM YYYY')# and #DateFormat(request.Date002, 'DD MMM YYYY')#</span></td>
					</cfoutput>
				</tr>
				<tr>
					<td align="left"><span class="pix10bold">Date</span></td>
					<td align="left"><span class="pix10bold">Club</span></td>
					<td align="left"><span class="pix10bold">Forenames</span></td>
					<td align="left"><span class="pix10bold">Surname</span></td>
					<td align="left"><span class="pix10bold">Reg No</span></td>
					<!--- applies to season 2012 onwards only --->
					<cfif RIGHT(request.dsn,4) GE 2012>
						<td align="left"><span class="pix10bold">Address / <em>Notes</em></span></td>
					<cfelse>
						<td align="left"><span class="pix10bold">Notes</span></td>
					</cfif>
					<td align="center"><span class="pix10bold">Age</span></td>
					<td align="center"><span class="pix10bold">Date of Birth</span></td>
					<td align="left"><span class="pix10bold">Reg Type</span></td>
					<td align="left"><span class="pix10bold">First Day</span></td>
				</tr>
				<cfoutput query="DeregisteredPlayersByDate" group="LastDay">
					<tr>
						<td height="20"><span class="pix10bold">#DateFormat(LastDay, 'DDD, DD MMM YYYY')#</span></td>
					</tr>
					<cfoutput>
						<tr>
							<td align="left" valign="top"><span class="pix10">&nbsp;</span></td>
							<td align="left" valign="top"><span class="pix10">#ClubName#</span></td>
							<td align="left" valign="top"><span class="pix10">#Forename#</span></td>
							<td align="left" valign="top"><span class="pix10">#Surname#</span></td>
							<td align="left" valign="top"><span class="pix10">#RegNo#</span></td>
							<!--- applies to season 2012 onwards only --->
							<cfif RIGHT(request.dsn,4) GE 2012>
								<cfif len(trim("#AddressLine1##AddressLine2##AddressLine3##Postcode##PNotes#")) IS 0>         <!--- no address and no notes --->
									<td width="120" align="left" valign="top"><span class="pix10">&nbsp;</span></td>
								<cfelseif len(trim("#AddressLine1##AddressLine2##AddressLine3##Postcode#")) IS 0>         <!--- notes only --->
									<td width="120" align="left" valign="top"><span class="pix10"><em>#PNotes#</em></span></td>
								<cfelseif len(trim("#PNotes#")) IS 0>                                               <!--- address only --->
									<td width="120" align="left" valign="top"><span class="pix10">#AddressLine1#&nbsp;&##8226;&nbsp;#AddressLine2#&nbsp;&##8226;&nbsp;#AddressLine3#&nbsp;&##8226;&nbsp;#Postcode#</span></td>
								<cfelse>                                                                       <!--- address and notes --->
									<td width="120" align="left" valign="top"><span class="pix10">#AddressLine1#&nbsp;&##8226;&nbsp;#AddressLine2#&nbsp;&##8226;&nbsp;#AddressLine3#&nbsp;&##8226;&nbsp;#Postcode#<br><em>#PNotes#</em></span></td>
								</cfif>
							<!--- BEFORE season 2012 --->
							<cfelse>	
								<cfif len(trim("#PNotes#")) IS 0> <!---  no notes --->
									<td width="120" align="left" valign="top"><span class="pix10">&nbsp;</span></td>     
								<cfelse> <!--- notes --->
									<td width="120" align="left" valign="top"><span class="pix10">#PNotes#</span></td>
								</cfif>
							</cfif>
							<cfif IsDate(DOB)>
								<td align="center" valign="top"><span class="pix10">#DateDiff( "YYYY", DOB, Now() )#</span></td>
								<td align="center" valign="top"><span class="pix10">#DateFormat(DOB,'dd/mm/yyyy')#</span></td>								
							<cfelse>
								<td align="center" valign="top"><span class="pix10">-</span></td>
								<td align="center" valign="top"><span class="pix10">-</span></td>
							</cfif>
							<cfif RegType IS "A">
								<td align="left" valign="top"><span class="pix10">Non-Contract</span></td>
							<cfelseif RegType IS "B">
								<td align="left" valign="top"><span class="pix10">Contract</span></td>
							<cfelseif RegType IS "C">
								<td align="left" valign="top"><span class="pix10">Short Loan</span></td>
							<cfelseif RegType IS "D">
								<td align="left" valign="top"><span class="pix10">Long Loan</span></td>
							<cfelseif RegType IS "E">
								<td align="left" valign="top"><span class="pix10">Work Experience</span></td>
							<cfelseif RegType IS "G">
								<td align="left" valign="top"><span class="pix10">Lapsed</span></td>
							<cfelseif RegType IS "F">
								<td align="left" valign="top"><span class="pix10">Temporary</span></td>
							<cfelseif RegType IS "X">
								<td align="left" valign="top"><span class="pix10">X=Unknown</span></td>
							</cfif>
							<cfif LastDay IS "">
								<td align="left" valign="top"><span class="pix10">&nbsp;</span></td>
							<cfelse>
								<td align="left" valign="top"><span class="pix10">#DateFormat(FirstDay, 'DDD, DD MMM YYYY')#</span></td>
							</cfif>
						</tr>
					</cfoutput>
				</cfoutput>
				<tr align="center">
					<td height="50" colspan="8"><span class="pix10">&nbsp;</span></td>
				</tr>
			</table>
<!---			
											**************************
											* Deregistered (by club) *	
											**************************
--->
		<cfelseif Form.Action IS "Deregistered (by club)">
			<cfinclude template = "queries/qry_DeregisteredPlayersByClub.cfm">
			<table width="100%" border="0" cellpadding="2" cellspacing="0">
				<tr align="center">
					<cfoutput>
					<td align="left" height="40" colspan="9"><span class="pix18bold">#DeregisteredPlayersByClub.RecordCount# players deregistered between #DateFormat(request.Date001, 'DD MMM YYYY')# and #DateFormat(request.Date002, 'DD MMM YYYY')#</span></td>
					</cfoutput>
				</tr>
				<tr>
					<td align="left"><span class="pix10bold">Club</span></td>
					<td align="left"><span class="pix10bold">Forenames</span></td>
					<td align="left"><span class="pix10bold">Surname</span></td>
					<td align="left"><span class="pix10bold">Reg No</span></td>
					<!--- applies to season 2012 onwards only --->
					<cfif RIGHT(request.dsn,4) GE 2012>
						<td align="left"><span class="pix10bold">Address / <em>Notes</em></span></td>
					<cfelse>
						<td align="left"><span class="pix10bold">Notes</span></td>
					</cfif>
					<td align="center"><span class="pix10bold">Age</span></td>
					<td align="center"><span class="pix10bold">Date of Birth</span></td>
					<td align="left"><span class="pix10bold">Reg Type</span></td>
					<td align="left"><span class="pix10bold">First Day</span></td>
					<td align="left"><span class="pix10bold">Last Day</span></td>
				</tr>
				<cfoutput query="DeregisteredPlayersByClub" group="ClubName">
					<tr>
						<td align="left" height="20"><span class="pix10bold">#ClubName#</span></td>
					</tr>
					<cfoutput>
						<tr>
							<td align="left" valign="top"><span class="pix10">&nbsp;</span></td>
							<td align="left" valign="top"><span class="pix10">#Forename#</span></td>
							<td align="left" valign="top"><span class="pix10">#Surname#</span></td>
							<td align="left" valign="top"><span class="pix10">#RegNo#</span></td>
							<!--- applies to season 2012 onwards only --->
							<cfif RIGHT(request.dsn,4) GE 2012>
								<cfif len(trim("#AddressLine1##AddressLine2##AddressLine3##Postcode##PNotes#")) IS 0>         <!--- no address and no notes --->
									<td width="120" align="left" valign="top"><span class="pix10">&nbsp;</span></td>
								<cfelseif len(trim("#AddressLine1##AddressLine2##AddressLine3##Postcode#")) IS 0>         <!--- notes only --->
									<td width="120" align="left" valign="top"><span class="pix10"><em>#PNotes#</em></span></td>
								<cfelseif len(trim("#PNotes#")) IS 0>                                               <!--- address only --->
									<td width="120" align="left" valign="top"><span class="pix10">#AddressLine1#&nbsp;&##8226;&nbsp;#AddressLine2#&nbsp;&##8226;&nbsp;#AddressLine3#&nbsp;&##8226;&nbsp;#Postcode#</span></td>
								<cfelse>                                                                       <!--- address and notes --->
									<td width="120" align="left" valign="top"><span class="pix10">#AddressLine1#&nbsp;&##8226;&nbsp;#AddressLine2#&nbsp;&##8226;&nbsp;#AddressLine3#&nbsp;&##8226;&nbsp;#Postcode#<br><em>#PNotes#</em></span></td>
								</cfif>
							<!--- BEFORE season 2012 --->
							<cfelse>	
								<cfif len(trim("#PNotes#")) IS 0> <!---  no notes --->
									<td width="120" align="left" valign="top"><span class="pix10">&nbsp;</span></td>     
								<cfelse> <!--- notes --->
									<td width="120" align="left" valign="top"><span class="pix10">#PNotes#</span></td>
								</cfif>
							</cfif>
							<cfif IsDate(DOB)>
								<td align="center" valign="top"><span class="pix10">#DateDiff( "YYYY", DOB, Now() )#</span></td>
								<td align="center" valign="top"><span class="pix10">#DateFormat(DOB,'dd/mm/yyyy')#</span></td>								
							<cfelse>
								<td align="center" valign="top"><span class="pix10">-</span></td>
								<td align="center" valign="top"><span class="pix10">-</span></td>
							</cfif>
							<cfif RegType IS "A">
								<td align="left" valign="top"><span class="pix10">Non-Contract</span></td>
							<cfelseif RegType IS "B">
								<td align="left" valign="top"><span class="pix10">Contract</span></td>
							<cfelseif RegType IS "C">
								<td align="left" valign="top"><span class="pix10">Short Loan</span></td>
							<cfelseif RegType IS "D">
								<td align="left" valign="top"><span class="pix10">Long Loan</span></td>
							<cfelseif RegType IS "E">
								<td align="left" valign="top"><span class="pix10">Work Experience</span></td>
							<cfelseif RegType IS "G">
								<td align="left" valign="top"><span class="pix10">Lapsed</span></td>
							<cfelseif RegType IS "F">
								<td align="left" valign="top"><span class="pix10">Temporary</span></td>
							<cfelseif RegType IS "X">
								<td align="left" valign="top"><span class="pix10">X=Unknown</span></td>
							</cfif>
							<cfif FirstDay IS "">
								<td align="left" valign="top"><span class="pix10">&nbsp;</span></td>
							<cfelse>
								<td align="left" valign="top"><span class="pix10">#DateFormat(FirstDay, 'DDD, DD MMM YYYY')#</span></td>
							</cfif>
							
							<cfif LastDay IS "">
								<td align="left" valign="top"><span class="pix10">&nbsp;</span></td>
							<cfelse>
								<td align="left" valign="top"><span class="pix10">#DateFormat(LastDay, 'DDD, DD MMM YYYY')#</span></td>
							</cfif>
						</tr>
					</cfoutput>
				</cfoutput>
				<tr align="center">
					<td height="50" colspan="8"><span class="pix10">&nbsp;</span></td>
				</tr>
			</table>
			
			
<!---			
											***************
											* Transferred *	
											***************
--->
		<cfelseif Form.Action IS "Transferred">
						
			<cfset ColSpan1 = 10>

			<cfinclude template = "queries/qry_TransferredPlayers.cfm">
			<table width="100%" border="0" cellpadding="2" cellspacing="0">
				<tr align="center">
					<cfoutput>
					<td align="center" height="40" colspan="#ColSpan1#"><span class="pix18bold">#MultipleRegistrations.RecordCount# players transferred between #DateFormat(request.Date001, 'DD MMM YYYY')# and #DateFormat(request.Date002, 'DD MMM YYYY')#</span></td>
					</cfoutput>
				</tr>
				<tr>
					<td align="left"><span class="pix10bold">Reg No</span></td>
					<!--- applies to season 2012 onwards only --->
					<cfif RIGHT(request.dsn,4) GE 2012>
						<td align="left"><span class="pix10bold">Address / <em>Notes</em></span></td>
					<cfelse>
						<td align="left"><span class="pix10bold">Notes</span></td>
					</cfif>
					<td align="left"><span class="pix10bold">Forenames</span></td>
					<td align="left"><span class="pix10bold">Surname</span></td>
					<td align="center"><span class="pix10bold">Age</span></td>
					<td align="center"><span class="pix10bold">Date of Birth</span></td>
					<td align="left"><span class="pix10bold">Team Name</span></td>
					<td align="left"><span class="pix10bold">First Day</span></td>
					<td align="left"><span class="pix10bold">Last Day</span></td>
					<td align="left"><span class="pix10bold">Reg Type</span></td>
				</tr>
				<cfoutput query="TransferredPlayers" group="PID">
					<tr bgcolor="white">
						<td align="left" valign="top"><span class="pix10">#RegNo#</span></td>
						<!--- applies to season 2012 onwards only --->
						<cfif RIGHT(request.dsn,4) GE 2012>
							<cfif len(trim("#AddressLine1##AddressLine2##AddressLine3##Postcode##PNotes#")) IS 0>         <!--- no address and no notes --->
								<td width="120" align="left" valign="top"><span class="pix10">&nbsp;</span></td>
							<cfelseif len(trim("#AddressLine1##AddressLine2##AddressLine3##Postcode#")) IS 0>         <!--- notes only --->
								<td width="120" align="left" valign="top"><span class="pix10"><em>#PNotes#</em></span></td>
							<cfelseif len(trim("#PNotes#")) IS 0>                                               <!--- address only --->
								<td width="120" align="left" valign="top"><span class="pix10">#AddressLine1#&nbsp;&##8226;&nbsp;#AddressLine2#&nbsp;&##8226;&nbsp;#AddressLine3#&nbsp;&##8226;&nbsp;#Postcode#</span></td>
							<cfelse>                                                                       <!--- address and notes --->
								<td width="120" align="left" valign="top"><span class="pix10">#AddressLine1#&nbsp;&##8226;&nbsp;#AddressLine2#&nbsp;&##8226;&nbsp;#AddressLine3#&nbsp;&##8226;&nbsp;#Postcode#<br><em>#PNotes#</em></span></td>
							</cfif>
						<!--- BEFORE season 2012 --->
						<cfelse>	
							<cfif len(trim("#PNotes#")) IS 0> <!---  no notes --->
								<td width="120" align="left" valign="top"><span class="pix10">&nbsp;</span></td>     
							<cfelse> <!--- notes --->
								<td width="120" align="left" valign="top"><span class="pix10">#PNotes#</span></td>
							</cfif>
						</cfif>
						<td align="left" valign="top"><span class="pix10">#Forename#</span></td>
						<td align="left" valign="top"><span class="pix10">#Surname#</span></td>
						<cfif IsDate(DOB)>
							<td align="center" valign="top"><span class="pix10">#DateDiff( "YYYY", DOB, Now() )#</span></td>
							<td align="center" valign="top"><span class="pix10">#DateFormat(DOB,'dd/mm/yyyy')#</span></td>								
						<cfelse>
							<td align="center" valign="top"><span class="pix10">-</span></td>
							<td align="center" valign="top"><span class="pix10">-</span></td>
						</cfif>
						<td align="left"><span class="pix10bold">&nbsp;</span></td>
						<td align="left"><span class="pix10bold">&nbsp;</span></td>
						<td align="left"><span class="pix10bold">&nbsp;</span></td>
						<td align="left"><span class="pix10bold">&nbsp;</span></td>
					</tr>
					<cfoutput>
						<tr>
							<td align="left"><span class="pix10bold">&nbsp;</span></td>
							<td align="left"><span class="pix10bold">&nbsp;</span></td>
							<td align="left"><span class="pix10bold">&nbsp;</span></td>
							<td align="left"><span class="pix10bold">&nbsp;</span></td>
							<td align="left"><span class="pix10bold">&nbsp;</span></td>
							<td align="left"><span class="pix10bold">&nbsp;</span></td>
							<td align="left" valign="top"><span class="pix10">#TeamName#</span></td>
							<td align="left"><span class="pix10">#DateFormat(FirstDayOfRegistration, 'DD MMM YYYY')#</span></td>
							<td align="left"><span class="pix10">#DateFormat(LastDayOfRegistration, 'DD MMM YYYY')#</span></td>
							
							<cfif RegType IS "A">
								<td align="left" valign="top"><span class="pix10">Non-Contract</span></td>
							<cfelseif RegType IS "B">
								<td align="left" valign="top"><span class="pix10">Contract</span></td>
							<cfelseif RegType IS "C">
								<td align="left" valign="top"><span class="pix10">Short Loan</span></td>
							<cfelseif RegType IS "D">
								<td align="left" valign="top"><span class="pix10">Long Loan</span></td>
							<cfelseif RegType IS "E">
								<td align="left" valign="top"><span class="pix10">Work Experience</span></td>
							<cfelseif RegType IS "G">
								<td align="left" valign="top"><span class="pix10">Lapsed</span></td>
							<cfelseif RegType IS "F">
								<td align="left" valign="top"><span class="pix10">Temporary</span></td>
							<cfelseif RegType IS "X">
								<td align="left" valign="top"><span class="pix10">X=Unknown</span></td>
							</cfif>
							
						</tr>
					</cfoutput>
				</cfoutput>
				<tr align="center">
					<td height="50" colspan="8"><span class="pix10">&nbsp;</span></td>
				</tr>
			</table>
			



			
		</cfif>
	</cfif>
	
<!--- ================================================================================================================================================== --->	
		<cfif StructKeyExists(request, "Date001") AND StructKeyExists(request, "Date002")>
			<cfset Date01 = request.Date001 >
			<cfset Date02 = request.Date002 >
		<cfelse>
			<cfset Date01 = Now()>
			<cfset Date02 = Now()>
		</cfif>
		
		<SCRIPT type="text/javascript" src="CalendarPopup.js"></SCRIPT>	
		<!--- season dates - less one for start, plus one for end - this info used in calendar to block non-season dates! --->
		<cfset LOdate = DateAdd('D', -61, SeasonStartDate) >
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
		<input type="Hidden" name="StateVector" value="1">
		<table width="100%">
			<tr>
				<td align="CENTER">
					<table border="0" cellspacing="0" cellpadding="5" class="bg_suspend">
					<tr>
						<td colspan="2"><span class="pix10">Please specify the date range ... </span></td>
					</tr>
						<tr>
							<td colspan="2" align="right">
								<cfoutput>
									<span class="pix10">
									between <a href="DateRange.cfm?LeagueCode=#LeagueCode#"  NAME="anchor1" target="_blank" ID="anchor1" onClick="cal1.select(DateRangeForm.FirstDay,'anchor1','EE, dd MMM yyyy'); return false;">
									choose</a> <input name="FirstDay" type="text" size="30" readonly="true" value="#DateFormat(Date01, "DDDD, DD MMMM YYYY")#" ></span>
								</cfoutput>
							</td>					
						</tr>
						<tr>
							<td colspan="2" align="right">
								<cfoutput>
									<span class="pix10">
									and <a href="DateRange.cfm?LeagueCode=#LeagueCode#"  NAME="anchor1" target="_blank" ID="anchor1" onClick="cal1.select(DateRangeForm.LastDay,'anchor1','EE, dd MMM yyyy'); return false;">
									choose</a> <input name="LastDay" type="text" size="30" readonly="true" value="#DateFormat(Date02, "DDDD, DD MMMM YYYY")#" ></span>
								</cfoutput>
							</td>					
						</tr>
						<tr>
							<td height="20" colspan="2" align="center"><span class="pix10bold">Players</span></td>
						</tr>
						<tr>
							<td align="center"><span class="pix10"><input type="Submit" name="Action" value="Registered (by date)"></span></td>
							<td align="center"><span class="pix10"><input type="Submit" name="Action" value="Registered (by club)"></span></td>				
						</tr>
						<tr>
							<td align="center"><span class="pix10"><input type="Submit" name="Action" value="Deregistered (by date)"></span></td>
							<td align="center"><span class="pix10"><input type="Submit" name="Action" value="Deregistered (by club)"></span></td>				
						</tr>
						<tr>
							<td align="center" colspan="2" ><span class="pix10"><input type="Submit" name="Action" value="Transferred"></span></td>
						</tr>
						
						<tr>
						<cfoutput>
							<td height="40" colspan="2" align="center"><a href="RegisteredPlayers.cfm?LeagueCode=#LeagueCode#"><span class="pix10">Registered Players Analysis</span></a></td>
						</tr>
						</cfoutput>
					</table>
				</td>
			</tr>
		</table>
</cfform>
