<!--- Need to be logged in to see this report --->
<!--- applies to season 2012 onwards only --->
<cfif NOT RIGHT(request.dsn,4) GE 2012>
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfif StructKeyExists(url, "RI") OR StructKeyExists(form, "RI")>
<cfelse>
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<cfif ListFind("Yellow",request.SecurityLevel) >
	<cfif StructKeyExists(url, "RI") AND StructKeyExists(url, "LeagueCode") >
	<!---  for yellow security level check that the url.ID (referee's id) parameter and leaguecode parametere have not been tampered with.  --->
		<cflock scope="session" timeout="10" type="readonly">
			<cfset request.YellowKey = session.YellowKey  >
		</cflock>
		<cfif url.RI IS "#Reverse(GetToken(Reverse(request.YellowKey),1,'|'))#" AND url.LeagueCode IS "#GetToken(request.YellowKey,1,'|')#">
			<!--- all OK --->
		<cfelse>
			<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
			<cfabort>
		</cfif>
	<cfelseif StructKeyExists(form, "RI") AND StructKeyExists(form, "LeagueCode") >
	<!---  for yellow security level check that the url.ID (referee's id) parameter and leaguecode parametere have not been tampered with.  --->
		<cflock scope="session" timeout="10" type="readonly">
			<cfset request.YellowKey = session.YellowKey  >
		</cflock>
		<cfif form.RI IS "#Reverse(GetToken(Reverse(request.YellowKey),1,'|'))#" AND form.LeagueCode IS "#GetToken(request.YellowKey,1,'|')#">
			<!--- all OK --->
		<cfelse>
			<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
			<cfabort>
		</cfif>
	</cfif>
</cfif>


<cflock scope="session" timeout="10" type="readonly">
	<cfset request.SportsmanshipMarksOutOfHundred = session.SportsmanshipMarksOutOfHundred>
	<cfset request.LeagueType = session.LeagueType>
	<cfset request.RefMarksOutOfHundred = session.RefMarksOutOfHundred>	
</cflock> 
				
<cfinclude template="queries/qry_QFixtureDate.cfm">


<cfinclude template="queries/qry_QRefereeCardsH.cfm">
<cfinclude template="queries/qry_QRefereeCardsA.cfm">




<!--- double check - is this fixture's referee ID same as URL.RI ? --->
<cfif StructKeyExists(url, "RI") >
	<cfif url.RI IS NOT QFixtureDate.RefereeID>
		<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
		<cfabort>
	</cfif>
</cfif>	
<cfif StructKeyExists(form, "RI") >
	<cfif form.RI IS NOT QFixtureDate.RefereeID>
		<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
		<cfabort>
	</cfif>
</cfif>	

<!--- include toolbar.cfm--->
<cfinclude template="InclBegin.cfm">

<cfif StructKeyExists(form, "OKButton")>
	<cfif form.OKButton IS "I have reported some problems." >
		<cfset ThisRefMatchCardProblems = 1 >
	<cfelseif form.OKButton IS "Everything was perfect! No problems to report." >
		<cfset ThisRefMatchCardProblems = 0 >
	<cfelseif form.OKButton IS "OK" >
		<cfset ThisRefMatchCardProblems = 0 >
	<cfelse>
		<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
		<cfabort>
	</cfif>
	<cfinclude template="queries/upd_Fixture1.cfm">
	<cfinclude template="queries/qry_QFixtureDate.cfm">
</cfif>

<cfform name="MatchCardForm" action="MatchCard.cfm"   METHOD="POST" >
	<cfoutput>
	<input name="RI" type="hidden" value="#RI#">
	<input name="LeagueCode" type="hidden" value="#LeagueCode#">
	<input name="FID" type="hidden" value="#FID#">
	<input name="HA" type="hidden" value="#HA#">
	<input name="RefMatchCardAnswers" type="hidden" value="">
	</cfoutput>


	<cfoutput query="QFixtureDate">

	<table width="100%" border="1" align="center" cellpadding="5" cellspacing="0" bgcolor="white">
	
		<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
			<cfif RefereeReportReceived IS 1 >
				<tr>
					<td colspan="2"><img src="gif/tick.gif"><span class="pix13boldred"> This Match Card has been received. No further updating allowed.</span></td>
				</tr>
			</cfif>
		<cfelse> <!--- Yellow SecurityLevel --->
			<cfif RefereeReportReceived IS 1 >
				<tr>
					<td colspan="2"><img src="gif/tick.gif"><span class="pix13boldred"> This Match Card has been received. No further updating allowed.</span></td>
				</tr>
			</cfif>
		</cfif>
		
		<tr>
			<td width="30%" height="30" align="center"><span class="pix18bold">#RefName#</span></td>
			<td><span class="pix13bold">#DateFormat(FixtureDate, 'DDDD, DD MMMM YYYY')#&nbsp;&nbsp;&nbsp;#CompetitionName# <cfif TRIM(RoundName) IS ""><cfelse> - #RoundName#</cfif></span></td>		
		</tr>
		
		
		<tr>
			<!--- Asst. Referee Marks  --->	
			<cfif request.LeagueType IS "Normal"   >
				<td align="center">
					<table align="center" border="0" cellpadding="5" cellspacing="0" bgcolor="white">
						<tr>
							<td align="left"><span class="pix10">Asst1: </span><span class="pix10bold">#AsstRef1Name#</span></td>
							<td align="left"><span class="pix10">Asst2: </span><span class="pix10bold">#AsstRef2Name#</span></td>
						</tr>
						<tr>
							<!--- Asst. Referee 1 --->
							<td align="left"><span class="pix10">Marks<br><cfif request.RefMarksOutOfHundred IS "Yes">out of 100<cfelse>out of 10</cfif></span>
								<!---
								Asst. Referee 1 Marks
								--->
								<cfif request.RefMarksOutOfHundred IS "Yes">
									<cfinput name="AsstRef1Marks" type="text" value="#AsstRef1Marks#"  size="1" maxlength="3" range="0,100" required="no" message="Asst Ref 1 Marks must be between 0 and 100" validate="integer" >
								<cfelse>
									<cfinput name="AsstRef1Marks" type="text" value="#AsstRef1Marks#"  size="1" maxlength="2" range="0,10" required="no" message="Asst Ref 1 Marks must be between 0 and 10" validate="integer" >
								</cfif>
							</td>
							<!--- Asst. Referee 2 --->
							<td align="left"><span class="pix10">Marks<br><cfif request.RefMarksOutOfHundred IS "Yes">out of 100<cfelse>out of 10</cfif></span>
								<!---
								Asst. Referee 2 Marks
								--->
								<cfif request.RefMarksOutOfHundred IS "Yes">
									<cfinput name="AsstRef2Marks" type="text" value="#AsstRef2Marks#"  size="1" maxlength="3" range="0,100" required="no" message="Asst Ref 2 Marks must be between 0 and 100" validate="integer" >
								<cfelse>
									<cfinput name="AsstRef2Marks" type="text" value="#AsstRef2Marks#"  size="1" maxlength="2" range="0,10" required="no" message="Asst Ref 2 Marks must be between 0 and 10" validate="integer" >
								</cfif>
							</td>
						</tr>
						<cfif FourthOfficialName IS NOT "">
							<tr>
								<td align="left"><span class="pix10">4th: </span></td>
								<td align="left"><span class="pix10bold">#FourthOfficialName#</span></td>
							</tr>
						</cfif>
					</table>
				</td>
			</cfif>
			<!--- Teams and Goals --->
			<td align="center">
				<table border="0" cellpadding="5" cellspacing="0" bgcolor="##F5F5F5">
					<tr>
						<td>
							<table border="0" cellpadding="5" cellspacing="0" bgcolor="##F5F5F5">
								<tr>
									<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
										<td align="right"><a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#CurrentDivisionID#&HomeID=#HomeID#&AwayID=#AwayID#&LeagueCode=#LeagueCode#&Whence=MD"><span class="pix13bold">#HomeTeam# #HomeOrdinal#</span></a></td>
									<cfelse>
										<td align="right"><span class="pix13bold">#HomeTeam# #HomeOrdinal#</span></td>
									</cfif>
									
									<cfif NOT SuppressScorelineEntry >
										<td><cfinput name="HomeGoals" type="text" value="#HomeGoals#" size="1" maxlength="2" range="0,99" required="no" message="Home Goals must be less than 100" validate="integer"></td>
										<td align="center"><span class="pix13bold">v</span></td>
										<td><cfinput name="AwayGoals" type="text" value="#AwayGoals#" size="1" maxlength="2" range="0,99" required="no" message="Away Goals must be less than 100" validate="integer"></td>
									<cfelse>
										<td><input name="HomeGoals" type="hidden" value="#HomeGoals#"><span class="pix13bold">#HomeGoals#</span></td>
										<td align="center"><span class="pix13bold">v</span></td>
										<td><input name="AwayGoals" type="hidden" value="#AwayGoals#"><span class="pix13bold">#AwayGoals#</span></td>
									</cfif>	
									<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
										<td align="left"><a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#CurrentDivisionID#&HomeID=#HomeID#&AwayID=#AwayID#&LeagueCode=#LeagueCode#&Whence=MD"><span class="pix13bold">#AwayTeam# #AwayOrdinal#</span></a></td>
									<cfelse>
										<td align="left"><span class="pix13bold">#AwayTeam# #AwayOrdinal#</span></td>
									</cfif>
								</tr>
								<!---
								************************
								* Yellow and Red Cards *
								************************
								--->
								<cfif QRefereeCardsH.RecordCount + QRefereeCardsA.RecordCount GT 0>
								<tr>
									<td colspan="2" align="right" valign="top">
										<cfif QRefereeCardsH.RecordCount GT 0>
											<table border="1" cellpadding="2" cellspacing="0">
												<cfloop query="QRefereeCardsH">
													<cfif Card Is 1>
													<tr><td bgcolor="Yellow" align="left"><span class="pix9">#PlayerFullName#</span></td></tr>
													<cfelseif Card IS 3>
													<tr><td bgcolor="Red" align="left"><span class="pix9white">#PlayerFullName#</span></td></tr>							
													<cfelseif Card IS 4>
													<tr><td bgcolor="Orange" align="left"><span class="pix9">#PlayerFullName#</span></td></tr>							
													<cfelse>
														MatchCard.cfm ERROR 2xxx
														<cfabort>
													</cfif>
												</cfloop>
											</table>
										</cfif>
									</td>
									<td></td>
									<td colspan="2" align="left" valign="top">
										<cfif QRefereeCardsA.RecordCount GT 0>
											<table border="1" cellpadding="2" cellspacing="0">
												<cfloop query="QRefereeCardsA">
													<cfif Card Is 1>
													<tr><td bgcolor="Yellow" align="left"><span class="pix9">#PlayerFullName#</span></td></tr>
													<cfelseif Card IS 3>
													<tr><td bgcolor="Red" align="left"><span class="pix9white">#PlayerFullName#</span></td></tr>							
													<cfelseif Card IS 4>
													<tr><td bgcolor="Orange" align="left"><span class="pix9">#PlayerFullName#</span></td></tr>							
													<cfelse>
														MatchCard.cfm ERROR 2xxx
														<cfabort>
													</cfif>
												</cfloop>
											</table>
										</cfif>
									</td>
								</tr>
								</cfif>
								<cfif Result IS "">
								<cfelse>
									<tr>
										<td colspan="5" align="center">
											<cfif Result IS 'H' >
												<span class="pix18boldred">Home Win</span>
											<cfelseif Result IS 'A' >
												<span class="pix18boldred">Away Win</span>
											<cfelseif Result IS 'U' >
												<span class="pix18boldred">Home Win on Penalties</span>
											<cfelseif Result IS 'V' >
												<span class="pix18boldred">Away Win on Penalties</span>
											<cfelseif Result IS 'D' >
												<span class="pix18boldred">Drawn</span>
											<cfelseif Result IS 'P' >
												<span class="pix18boldred">Postponed</span>
											<cfelseif Result IS 'Q' >
												<span class="pix18boldred">Abandoned</span>
											<cfelseif Result IS 'W' >
												<span class="pix18boldred">Void</span>
											<cfelseif Result IS 'T' >
												<span class="pix18boldred">TEMP</span>
											</cfif>
										</td>
									</tr>
								</cfif>
							</table>
						</td>
						<td>
							<table border="0" cellpadding="5" cellspacing="0" bgcolor="##F5F5F5">
								<tr>
								<cfif ClubsCanInputSportsmanshipMarks IS 0> 
									<cfif request.SportsmanshipMarksOutOfHundred IS "1" >
										<td align="center" bgcolor="gray"><span class="pix9boldwhite">Marks out of 100</span>
										<br />
										<cfinput name="HomeSportsmanshipMarks" type="text" value="#HomeSportsmanshipMarks#"  size="1" maxlength="3" range="0,100" required="no" message="Home Sportsmanship Marks must be between 0 and 100" validate="integer" >
									<cfelse>
										<td align="center" bgcolor="gray"><span class="pix9boldwhite">Marks out of 10</span>
										<br />
										<cfinput name="HomeSportsmanshipMarks" type="text" value="#HomeSportsmanshipMarks#"  size="1" maxlength="2" range="0,10" required="no" message="Home Sportsmanship Marks must be between 0 and 10" validate="integer" >
									</cfif>
									<br />
									<span class="pix9boldwhite">Home team's Sportsmanship</span></td>
									<cfif request.SportsmanshipMarksOutOfHundred IS "1" >
										<td align="center" bgcolor="gray"><span class="pix9boldwhite">Marks out of 100</span>
										<br />
										<cfinput name="AwaySportsmanshipMarks" type="text" value="#AwaySportsmanshipMarks#"  size="1" maxlength="3" range="0,100" required="no" message="Away Sportsmanship Marks must be between 0 and 100" validate="integer" >
									<cfelse>
										<td align="center" bgcolor="gray"><span class="pix9boldwhite">Marks out of 10</span>
										<br />
										<cfinput name="AwaySportsmanshipMarks" type="text" value="#AwaySportsmanshipMarks#"  size="1" maxlength="2" range="0,10" required="no" message="Away Sportsmanship Marks must be between 0 and 10" validate="integer" >
									</cfif>	
									<br />
									<span class="pix9boldwhite">Away team's Sportsmanship</span></td>
								</cfif>
								</tr>
							</table>
						</td>
					</tr>
			
					
				</table>
			</td>
		</tr>
	<!--- Get Prompts from newsitem table for this league where longcol is 'MatchCardPrompts' --->
	<cfinclude template="queries/qry_QMatchCardPrompts.cfm">
	<cfif QMatchCardPrompts.RecordCount IS 1>
		<cfset ThisText = Trim(QMatchCardPrompts.Notes) >
	<cfelse>
		<cfset ThisText = 'Please contact your league and ask them to email INSERT_EMAIL_HERE to set up the Match Card questions for this league' >
	</cfif>
	<cfset ThisNumbering = "">
	<cfloop index="i" from="1" to="30" step="1">
		<cfset ThisNumbering = "#ThisNumbering# #i#. #chr(13)##chr(10)#"  >
	</cfloop>
	<!---
	<tr>
		<td colspan="2">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<cfloop index="i" from="1" to="10" step="1">
						<td width="10%" align="left" valign="top"><span class="pix9">#i#. #GetToken(ThisText, i ,CHR(10))#</span><span class="pix9">#GetToken(RefMatchCardAnswers, i ,CHR(10))#</span></td>
					</cfloop>
				</tr>
				<tr>
					<cfloop index="i" from="11" to="20" step="1">
						<td width="10%" align="left" valign="top"><span class="pix9">#i#. #GetToken(ThisText, i ,CHR(10))#</span><span class="pix9">#GetToken(RefMatchCardAnswers, i ,CHR(10))#</span></td>
					</cfloop>
				</tr>
				
			</table>
		</td>
	</tr>
	--->
	
	
	
	

	<!---
								*****************
								* OK Buttons    *
								*****************
	--->


	<cfif QMatchCardPrompts.RecordCount IS 0>
		<tr>
			<td height="40" colspan="2" align="center" >
				<input name="OKButton" type="submit"  class="pix18bold" value="OK" >
			</td>
		</tr>
	<cfelse>
		<tr bgcolor="silver">
			<td rowspan="2" align="left"><span class="pix13boldrealblack">Please answer all questions then click the appropriate button on the right. Players cautioned or sent off must be reported as problems. If answer is not applicable put N/A. Highlight problems with asterisks *** .  </span></td>
			<td height="40" colspan="2" align="center" >
				<cfif RefMatchCardProblems IS 1 AND Len(Trim(RefMatchCardAnswers)) GT 0>
					<img src="gif/PointingFinger.gif" width="103" height="53" border="0" align="absmiddle">
					<input   name="OKButton" type="submit"  class="pix24boldred" value="I have reported some problems." <cfif RefereeReportReceived IS 1 >disabled="true"</cfif>>
				<cfelse>
					<input   name="OKButton" type="submit"  class="pix10bold" value="I have reported some problems." <cfif RefereeReportReceived IS 1 >disabled="true"</cfif>>
				</cfif>
			</td>
		</tr>
		<tr bgcolor="silver">
			<td height="40" colspan="2" align="center" >
				<cfif RefMatchCardProblems IS 0 AND Len(Trim(RefMatchCardAnswers)) GT 0>
					<img src="gif/PointingFinger.gif" width="103" height="53" border="0" align="absmiddle">
					<input   name="OKButton" type="submit" class="pix24boldnavy" value="Everything was perfect! No problems to report." <cfif RefereeReportReceived IS 1 >disabled="true"</cfif>>
				<cfelse>
					<input   name="OKButton" type="submit" class="pix10bold" value="Everything was perfect! No problems to report." <cfif RefereeReportReceived IS 1 >disabled="true"</cfif>>
				</cfif>
			</td>
		</tr>
	</cfif>
	<tr>
		<td>
			<table border="0" cellpadding="0" cellspacing="0" bgcolor="white">
				<tr>
					<td width="5%" align="left" valign="top"><textarea name="RefMatchCard" style="overflow: hidden; resize: none;"  cols="3"  rows="32" disabled="disabled" readonly="readonly" wrap="physical" class="pix13bold">#ThisNumbering#</textarea></td>		
					<td width="95%"align="left" valign="top"><textarea name="RefMatchCard" style="overflow: hidden; resize: none;"  cols="58"  rows="32" disabled="disabled" readonly="readonly" wrap="physical" class="pix13bold">#ThisText#</textarea></td>
				</tr>
			</table>
		</td>
		
		<td>
			<table border="0" cellpadding="0" cellspacing="0" bgcolor="white">
				<tr>
					<td width="5%" align="left" valign="top"><textarea name="RefMatchCard" style="overflow: hidden; resize: none;"cols="3"  rows="32" disabled="disabled" readonly="readonly" wrap="physical" class="pix13bold">#ThisNumbering#</textarea></td>		
					<cfif RefereeReportReceived IS 1 OR QMatchCardPrompts.RecordCount IS 0 > <!--- only allow match card updating while not received yet and while there are prompts --->
						<td width="95%" align="left" valign="top"><textarea name="RefMatchCardAnswers" style="overflow: hidden; resize: none;" cols="84"  rows="32" disabled="disabled" readonly="readonly" wrap="physical" class="pix13">#RefMatchCardAnswers#</textarea></td>
					<cfelse>
						<td width="95%" align="left" valign="top"><textarea name="RefMatchCardAnswers" style="overflow: hidden; resize: none;"  cols="84"  rows="32" wrap="PHYSICAL" class="pix13">#RefMatchCardAnswers#</textarea></td>
					</cfif>
				</tr>
			</table>
		</td>
	</tr>

</table>
</cfoutput>
</cfform>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
