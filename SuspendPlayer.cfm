<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>


<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfif NOT StructKeyExists(url, "SI") AND NOT StructKeyExists(form, "StateVector")>
<!---					********************
						* Add a suspension *
						********************
--->
	<cfif NOT StructKeyExists(url, "PI")>
	Player's ID is missing.......
		<CFABORT>
	</cfif>

	<cfif StructKeyExists(url, "FID") AND StructKeyExists(url, "SDate")>
		<!--- get rid of any unused suspensions --->
		<cfinclude template = "queries/del_QDeleteAllEmptySuspension.cfm">
		<cfinclude template = "queries/ins_QAddSuspension.cfm"> <!--- added with FirstDay NULL and LastDay NULL so it can be recognised by QGetNewSuspension --->
		<cfinclude template = "queries/qry_QGetNewSuspension.cfm">
		<cfinclude template = "queries/upd_QSuspension.cfm">
		<cflocation URL="SuspendPlayer.cfm?LeagueCode=#LeagueCode#&SI=#QGetNewSuspension.ID#&FID=#FID#" addtoken="no">			
		<CFABORT>
	<cfelseif StructKeyExists(url, "SI") >
		<!--- get rid of any unused suspensions --->
		<cfinclude template = "queries/del_QDeleteAllEmptySuspension.cfm">
		<cflocation URL="SuspendPlayer.cfm?LeagueCode=#LeagueCode#&SI=#url.SID#" addtoken="no">			
		<CFABORT>
	<cfelse>
		<!--- get rid of any unused suspensions --->
		<cfinclude template = "queries/del_QDeleteAllEmptySuspension.cfm">
		<cfinclude template = "queries/ins_QAddSuspension.cfm"> <!--- added with FirstDay NULL and LastDay NULL so it can be recognised by QGetNewSuspension --->
		<cfinclude template = "queries/qry_QGetNewSuspension.cfm">
		<cflocation URL="SuspendPlayer.cfm?LeagueCode=#LeagueCode#&SI=#QGetNewSuspension.ID#" addtoken="no">			
		<CFABORT>
	</cfif>
	<cfinclude template = "queries/del_QDeleteAllEmptySuspension.cfm">
	<CFABORT>
<!---					*********************************
						* Update or remove a suspension *
						*********************************
--->
<cfelseif NOT StructKeyExists(form, "StateVector")>
	<!--- First time in --->
	<cfinclude template = "queries/qry_GetSuspension.cfm">
	<cfif GetSuspension.RecordCount IS NOT 1>
		Suspension is missing.......
		<CFABORT>
	</cfif>
	<cfset ThisPlayerID = GetSuspension.PlayerID >
	<!--- get all the TeamOrdinal combinations for Teams with which he has registered, if player is unregistered then he can't be given a 
	number of matches ban, only a number of days ban --->
	<cfset MultipleTeams = "No">
	<cfinclude template = "queries/qry_QTeamOrdinal2.cfm"> 
	<cfif QTeamOrdinal2.RecordCount IS 0>
		<cfset MatchBanAllowed = "No">
	<cfelse>
		<cfset MatchBanAllowed = "Yes">
		<cfif QTeamOrdinal2.RecordCount GT 1><!--- if there is a choice from the drop down then add a prompt for the user ---> 
			<cfset MultipleTeams = "Yes">
		</cfif>
	</cfif>
	
	<CFFORM ACTION="SuspendPlayer.cfm?LeagueCode=#LeagueCode#" METHOD="post" name="SuspendPlayerForm">
	
		<SCRIPT type="text/javascript" src="CalendarPopup.js"></SCRIPT>	
		<!--- season dates - less one for start, plus one for end - this info used in calendar to block non-season dates! --->
		<cfset LOdate = MIN(DateAdd('D', -1, Now()),DateAdd('D', -1, SeasonStartDate)) >
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
		<cfoutput>
		<input type="Hidden" name="SID" value="#GetSuspension.SID#">
		<input type="Hidden" name="RegNo" value="#GetSuspension.RegNo#">
		<input type="Hidden" name="PlayerID" value="#GetSuspension.PlayerID#">
		</cfoutput>
		<table width="100%">
			<tr>
				<td align="CENTER">
					<table border="0" cellspacing="0" cellpadding="2" class="bg_suspend">
						<tr>
							<cfoutput>
							<td><span class="pix18"><strong>#GetSuspension.Surname#</strong> #GetSuspension.Forename#</span></td>
							<td align="right"><span class="pix13bold">Reg. No. #GetSuspension.RegNo#</span></td>
							</cfoutput>
						</tr>
						
											<tr>
											<td colspan="2" align="center"><span class="pix10bold">Suspension Notes</span><span class="pix9"></span></td>
											</tr>
										<cfif Len(Trim(GetSuspension.SuspensionNotes)) IS 0 AND IsDefined("FID") >
											<!--- get all the match details to put in the notes, there's only one QGetFixtureInfo row for the fixture id supplied --->
											<cfinclude template = "queries/qry_GetFixtureInfo.cfm">
											<cfoutput query="QGetFixtureInfo">
												<cfset FInfoText = "This suspension relates to #DateFormat(FixtureDate,'DD/MM/YY')#, #DivisionName#, #HomeTeamName# #Homegoals# v #Awaygoals# #AwayTeamName#.">
											</cfoutput>
											<tr>
												<td colspan="2" align="center"><textarea name="SuspensionNotes" cols="80" rows="3" wrap="virtual"><cfoutput>#FInfoText#</cfoutput></textarea></td>
											</tr>
										<cfelse>
											<tr>
												<td colspan="2" align="center"><textarea name="SuspensionNotes" cols="80" rows="3" wrap="virtual"><cfoutput>#GetSuspension.SuspensionNotes#</cfoutput></textarea></td>
											</tr>
										</cfif>



						
						<tr>
							<td colspan="2" align="center">
								<cfif GetSuspension.FirstDay IS "">
									<cfset Date01 = Now()>
								<cfelse>
									<cfset Date01 = GetSuspension.FirstDay >
								</cfif>
								<cfoutput>
									<span class="pix10">
									Please <a href="" onClick="cal1.select(SuspendPlayerForm.FirstDay,'anchor1','EE, dd MMM yyyy'); return false;"  NAME="anchor1" ID="anchor1">
									<u>choose</u></a> </span><span class="pix10bold">First day</span>
									<input name="FirstDay" type="text" size="30" readonly="true" value="#DateFormat(Date01, "DDDD, DD MMMM YYYY")#" >
								</cfoutput>
								<hr>
							</td>					
						</tr>
						<tr>
							<td colspan="2" align="center">
								<cfif GetSuspension.LastDay IS "">
									<cfset Date02 = Now()>
								<cfelse>
									<cfset Date02 = GetSuspension.LastDay >
								</cfif>
								<table border="0" align="center" cellpadding="4" cellspacing="0" class="bg_suspend">
									<cfif GetSuspension.NumberOfMatches IS 0>
										<cfif Date01 IS Date02 > 
										<!--- 
										****************************************************************************
										* first time in, choose between number of matches banned or number of days *
										****************************************************************************
										--->
											<cfset MatchesBanned = 0>
											<cfset MBText = "match(es)">
											<cfif MatchBanAllowed IS "Yes">
												<tr>
													<td align="center"><span class="pix13bold">MATCH BASED</span></td>
													<td rowspan="5" align="center" bgcolor="#666666"><span class="pix18boldwhite">&nbsp;&nbsp;OR&nbsp;&nbsp;</span></td>
													<td align="center" bgcolor="white"><span class="pix13bold">TIME BASED</span></td>
												</tr>
											<cfelse>
												<tr>
													<td align="center"><span class="pix10bold">&nbsp;</span></td>
													<td align="center"><span class="pix18bold">&nbsp;</span></td>
													<td align="center" bgcolor="white"><span class="pix13bold">TIME BASED</span></td>
												</tr>
											</cfif>
											
											<cfif MatchBanAllowed IS "Yes">
												<tr>
													<td align="center"><span class="pix10bold">Banned for</span></td>
													<td align="center" bgcolor="white"><span class="pix10bold">Last Day</span></td>
												</tr>
											<cfelse>
												<tr>
													<td align="center"><span class="pix10bold">&nbsp;</span></td>
													<td rowspan="4" align="center"><span class="pix18bold">&nbsp;</span></td>
													<td align="center" bgcolor="white"><span class="pix10bold">Last Day</span></td>
												</tr>
											</cfif>
											<cfif MatchBanAllowed IS "Yes">											
												<tr>
													<cfoutput>
														<td align="center">
															<cfinput type="text" name="NumberOfMatches"  size="1" maxlength="2"  validate="regex" pattern="^[0-9]*$" required="yes" value="#MatchesBanned#" message="Number of matches must be numeric in range 1 to 99" validateAt="onSubmit"> 					
															<span class="pix10"> #MBText#</span>
														</td>
														<td bgcolor="white">
															<span class="pix10">
															<a href="" onClick="cal1.select(SuspendPlayerForm.LastDay,'anchor1','EE, dd MMM yyyy'); return false;"  NAME="anchor1" ID="anchor1">
															<u>choose</u></a> <input name="LastDay" type="text" size="30" readonly="true" value="#DateFormat(Date02, "DDDD, DD MMMM YYYY")#" >
															</span>
														</td>
													</cfoutput>
												</tr>
												<tr>
													<cfif MultipleTeams IS "Yes">
														<td align="center" bgcolor="red"><span class="pix13boldwhite">Important: Please choose the team</span></td>
													<cfelse>
														<td align="center"><span class="pix10bold">involving</span></td>
													</cfif>
													<td align="center" bgcolor="white"><span class="pix10bold">&nbsp;</span></td>
												</tr>
												
											<cfelse>
												<tr>
													<cfoutput>
														<td align="center"></td>
														<td bgcolor="white">
															<span class="pix10">
															<a href="" onClick="cal1.select(SuspendPlayerForm.LastDay,'anchor1','EE, dd MMM yyyy'); return false;"  NAME="anchor1" ID="anchor1">
															<u>choose</u></a> <input name="LastDay" type="text" size="30" readonly="true" value="#DateFormat(Date02, "DDDD, DD MMMM YYYY")#" >
															</span>
														</td>
													</cfoutput>
												</tr>
												<tr>
													<td align="center"><span class="pix10bold">&nbsp;</span></td>
													<td align="center" bgcolor="white"><span class="pix10bold">&nbsp;</span></td>
												</tr>




											</cfif>
											<cfif MatchBanAllowed IS "Yes">
												<tr>
													<td align="CENTER">
														<select name="TeamIDOrdinalID" size="1" >
															<cfoutput query="QTeamOrdinal2" >
																<option value="#TeamID#^#OrdinalID#" >#TeamOrdinalDescription#</option>
															</cfoutput>
														</select>
													</td>
													<td colspan="2" align="center"><span class="pix10bold">&nbsp;</span></td>
												</tr>
											</cfif>
										<cfelse>
										<!--- 
										************************************************
										* days based suspension, not number of matches *
										************************************************
										--->
											<cfset MatchesBanned = 0>
											<cfset MBText = "match(es)">
											<tr>
												<td align="center" bgcolor="white"><span class="pix13bold">TIME BASED</span></td>
											</tr>
											<tr>
												<td align="center"><span class="pix10bold">Last Day</span></td>
											</tr>
											<tr>
												<cfoutput>
													<input name="NumberOfMatches" type="hidden" value="#MatchesBanned#" >
													<td>
														<span class="pix10">
														<a href="" onClick="cal1.select(SuspendPlayerForm.LastDay,'anchor1','EE, dd MMM yyyy'); return false;"  NAME="anchor1" ID="anchor1">
														<u>choose</u></a> <input name="LastDay" type="text" size="30" readonly="true" value="#DateFormat(Date02, "DDDD, DD MMMM YYYY")#" >
														</span>
													</td>
												</cfoutput>
											</tr>
											
										</cfif>
										
									<cfelse>
										<!--- 
										*******************************************************
										* one or more match bans, not days based suspension   *
										*******************************************************
										--->
										<cfset MatchesBanned = GetSuspension.NumberOfMatches >
										<cfif MatchesBanned IS 1> 
											<cfset MBText = "match">
										<cfelse>
											<cfset MBText = "matches">
										</cfif>
										<cfoutput>
										<tr>
											<td align="center" bgcolor="white"><span class="pix13bold">MATCH BASED</span></td>
										</tr>
										<tr>
											<td align="center"><span class="pix10bold">Banned for</span></td>
										</tr>
										<tr>
												<td align="center">
													<cfinput name="NumberOfMatches" type="text"  size="1" maxlength="2" range="1,99" required="yes" message="Number of matches must be numeric in range 1 to 99" validate="integer"  value="#MatchesBanned#" >
													<span class="pix10"> #MBText#</span>
												</td>
										</tr>
										<tr>
											<cfif MultipleTeams IS "Yes">
												<td align="center" bgcolor="red"><span class="pix13boldwhite">Important: Please choose the team</span></td>
											<cfelse>
												<td align="center"><span class="pix10bold">involving</span></td>
											</cfif>
										</tr>
										</cfoutput>
										<cfset ThisSuspensionID = GetSuspension.SID >
										<cfinclude template = "queries/qry_QMatchbanHeader.cfm">
										<tr>
											<td align="CENTER">
												<select name="TeamIDOrdinalID" size="1" >
													<cfoutput query="QTeamOrdinal2" >
														<option value="#TeamID#^#OrdinalID#" <cfif "#TeamID#^#OrdinalID#" IS "#QMatchbanHeader.TeamID#^#QMatchbanHeader.OrdinalID#">selected</cfif>>#TeamOrdinalDescription#</option>
													</cfoutput>
												</select>
											</td>
										</tr>
										<input name="LastDay" type="hidden" value="#DateFormat(Date02, 'DDDD, DD MMMM YYYY')#" >
									</cfif>
								
								
								</table>
							</td>
						</tr>
						<tr>
							<cfoutput>
								<td><span class="pix13"><input type="Submit" name="Action" value="Update"></span></td>				
								<td align="right"><span class="pix13"><input type="Submit" name="Action" value="Delete"></span></td>				
							</cfoutput>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</cfform>
<cfelseif StructKeyExists(form, "StateVector")>
<!---
select s.playerid as PlayerID, left(mbh.notes,8) as notes , s.FirstDay, s.id as SuspID,
s.numberofmatches as Mtchs,ItemNumber as INo,
TeamID,OrdinalID as OrdnlID,AppearanceID as AppID,
FixtureID as FixtrID,LastUpdated as LastUpdtd
from 
suspension s, matchbanheader mbh, matchban mb
where s.leaguecode='MDX' 
AND s.NumberOfMatches > 0
AND s.ID = mbh.SuspensionID
AND mbh.ID = mb.MatchbanHeaderID
ORDER BY PlayerID,FirstDay,SuspensionID,ItemNumber;
--->
	<cfif Form.StateVector IS 1>
	
		<cfif StructKeyExists(Form,"NumberOfMatches")>
		<cfelse>
			<cfset form.NumberOfMatches = 0>
		</cfif>
	
	
		<cfif Form.Action IS "Update">
			<!--- abort here if the combinations of dates and/or number of matches is incorrect --->
			<cfif Form.NumberOfMatches IS 0 AND (Evaluate(DateDiff("D", GetToken(form.FirstDay,2,","), GetToken(form.LastDay,2,","))+1) LE 1) >
				<!--- check to see if the first date is greater than the last date! --->
				<cfoutput>
					<span class="pix18boldred">
					DATE RANGE ERROR - Suspension from #form.FirstDay# to #form.LastDay#
					<BR><BR></span>
					<span class="pix13boldred">
					Please click on the Back button of your browser and try again....</b>
					<BR><BR><BR></span>
				</cfoutput>

				<!--- get rid of any unused suspensions (already used higher on page) --->
				<cfinclude template = "queries/del_QDeleteAllEmptySuspension.cfm">
				<CFABORT>
			<cfelse>
			
				<!--- Number of Matches (ignore the LastDay but make it 31st December 2999 anyway so it is obvious when looking at the column in the table rows)--->
				<cfif Form.NumberOfMatches GT 0>
					<cfset Form.LastDay = DateFormat('2999-12-31', 'DDDD, DD MMMM YYYY')>
					<!--- insert a row into matchban table for each match --->
					<cfset ThisSuspensionID = Form.SID >
					<cfset TotalMatches = Form.NumberOfMatches>
					<cfset ThisTeamID = GetToken(form.TeamIDOrdinalID, 1, '^' ) >     
					<cfset ThisOrdinalID = GetToken(form.TeamIDOrdinalID, 2, '^' ) >
					<cfset ThisNotes = Trim(form.SuspensionNotes) >
					<cfinclude template = "queries/del_QDelMatchBanHeader.cfm">	                  
					<cfinclude template = "queries/ins_QAddMatchBanheader.cfm">
					<cfinclude template = "queries/qry_QMatchbanHeader2.cfm">
					<cfif QMatchbanHeader2.RecordCount IS 1>
						<cfset ThisMatchbanHeaderID = QMatchbanHeader2.ID >
						<cfloop index="ThisMatch" from="1" to="#TotalMatches#" step="1" >
							<cfinclude template = "queries/ins_QAddMatchBan.cfm">
						</cfloop>
					</cfif>
				<cfelse>
					<cfset Form.NumberOfMatches = 0 > <!--- just in case it ever becomes negative! --->
				</cfif>
				<cfset ThisNotes = Trim(form.SuspensionNotes) >
				<cfinclude template = "queries/upd_QUpdateSuspension.cfm">

			<cflocation url="LUList.cfm?TblName=Player&LeagueCode=#LeagueCode#&FirstNumber=#Form.RegNo#&LastNumber=#Form.RegNo#" ADDTOKEN="NO">					
			</cfif>
		<cfelseif Form.Action IS "Delete">
				<cfif Form.NumberOfMatches GT 0>
					<cfset ThisSuspensionID = Form.SID >
					<cfinclude template = "queries/del_QDelMatchBanHeader.cfm">
				</cfif>
			<cfinclude template = "queries/del_QDeleteSuspension.cfm">
			<cflocation url="LUList.cfm?TblName=Player&LeagueCode=#LeagueCode#&FirstNumber=#Form.RegNo#&LastNumber=#Form.RegNo#" ADDTOKEN="NO">					
		</cfif>

	</cfif>
	
</cfif>












