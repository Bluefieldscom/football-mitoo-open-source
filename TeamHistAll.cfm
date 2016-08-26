<cfinclude template="queries/qry_QTeam_v2.cfm">
<cfset TeamHistAll = "Yes">

<!--- include toolbar.cfm--->
<cfinclude template="InclBegin.cfm">

<cfinclude template="queries/qry_QChosenID.cfm">
<cfinclude template="queries/qry_QConstits.cfm">

<!--- Create a list of these chosen constitutions (i.e. chosen competitions) --->
<cfset ChosenConstits = ValueList(QConstits.ID)>

<!---
ChosenConstits = <cfoutput>#ChosenConstits#</cfoutput>
<cfabort>
--->
<cfinclude template="queries/qry_QFixtures_v4.cfm">

<cfif QFixtures.RecordCount IS "0">
	<span class="pix13boldrealblack">No matches have been played</span>
<cfelse>
	<cfif DefaultGoalScorers IS "Yes">
		<cfinclude template="InclGoalscorerInfo.cfm">
		<cfinclude template="InclStarPlayerInfo.cfm">
	</cfif>
	<cfinclude template="InclEmailFixturesAndResults.cfm">
	<!--- display the query result set as a table with the appropriate headings ---> 
	<TABLE WIDTH="100%"  border="0" cellspacing="2" cellpadding="2" >
		<tr>
			<td align="left" colspan="100">
			<span class="pix13boldrealblack"><cfoutput>#QFixtures.RecordCount#</cfoutput> in list</span>
			</td>
		</tr>
		<cfoutput query="QFixtures" >
			<cfset ThisDate = DateFormat(FixtureDate, 'YYYY-MM-DD') >
			<cfset HideFixtures = "No">
			<!--- Hide the fixtures from the public if the Event Text says so --->
			<cfinclude template="queries/qry_QEventText.cfm">
			<cfif QEventText.RecordCount IS 1>
				<cfif FindNoCase("Hide_Fixtures",QEventText.EventText)>
					<cfset HideFixtures = "Yes">
				</cfif>
			</cfif>
			<cfif HideFixtures IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel)>
				<tr>
					<td colspan="2"></td>
					<cfif ListFind("Silver,Skyblue",request.SecurityLevel) ><td></td></cfif>
					<td></td>
					<td colspan="2" align="center"><span class="pix10boldrealblack">hidden</span></td>
					<td></td>
					<cfif ListFind("Silver,Skyblue",request.SecurityLevel) ><td></td></cfif>
					<td align="left"><span class="pix13realblack">#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#</span></td>
				</tr>
			<cfelseif Result IS "T" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel)>
				<!--- suppress this match if TEMP and not logged in --->
			<cfelse>
				<tr>
				<cfif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel)>
					<td align="CENTER"><span class="pix13realblack">&nbsp;</span></td>
				<cfelse>
					<td align="CENTER">
						<span class="pix13realblack">
							<cfif ListFind( #ChosenConstits#, HomeID ) GT "0" >
								<cfif IsNumeric(#HomeGoals#) >
									<cfif IsNumeric(#AwayGoals#) >
										<cfif HomeGoals GT AwayGoals >
											W
										<cfelseif AwayGoals GT HomeGoals >
											L
										<cfelse>
											<CFSWITCH expression="#Result#">
												<CFCASE VALUE="U"> <!--- Home Win on penalties --->
													W
												</CFCASE>
												<CFCASE VALUE="V"> <!--- Away Win on penalties --->
													L
												</CFCASE>
												<CFDEFAULTCASE>
													D
												</CFDEFAULTCASE>
											</CFSWITCH>
										</cfif>
									</cfif>
								</cfif>
							</cfif>
							<cfif ListFind( #ChosenConstits#, AwayID ) GT "0" >
								<cfif IsNumeric(#HomeGoals#) >
									<cfif IsNumeric(#AwayGoals#) >
										<cfif HomeGoals GT AwayGoals >
											L
										<cfelseif AwayGoals GT HomeGoals >
											W
										<cfelse>
											<CFSWITCH expression="#Result#">
												<CFCASE VALUE="U"> <!--- Home Win on penalties --->
													L
												</CFCASE>
												<CFCASE VALUE="V"> <!--- Away Win on penalties --->
													W
												</CFCASE>
												<CFDEFAULTCASE>
													D
												</CFDEFAULTCASE>
											</CFSWITCH>
										</cfif>
									</cfif>
								</cfif>
							</cfif>
					
							<cfif ListFind( #ChosenConstits#, HomeID ) GT "0" >
								<cfif NOT IsNumeric(#HomeGoals#) >
									<cfif NOT IsNumeric(#AwayGoals#) >
										<CFSWITCH expression="#Result#">
											<CFCASE VALUE="H">
											W
											</CFCASE>
											<CFCASE VALUE="A">
											L
											</CFCASE>
											<CFCASE VALUE="D">
											D
											</CFCASE>
											<CFDEFAULTCASE>
											&nbsp;
											</CFDEFAULTCASE>
										</CFSWITCH>
									</cfif>
								</cfif>
							</cfif>
							<cfif ListFind( #ChosenConstits#, AwayID ) GT "0" >
								<cfif NOT IsNumeric(#HomeGoals#) >
									<cfif NOT IsNumeric(#AwayGoals#) >
										<CFSWITCH expression="#Result#">
											<CFCASE VALUE="H">
											L
											</CFCASE>
											<CFCASE VALUE="A">
											W
											</CFCASE>
											<CFCASE VALUE="D">
											D
											</CFCASE>
											<CFDEFAULTCASE>
											&nbsp;
											</CFDEFAULTCASE>
										</CFSWITCH>
									</cfif>
								</cfif>
							</cfif>
						</span>
					</td>
				</cfif>
				<cfif HideFixtures IS "Yes">
					<td align="left" bgcolor="##EEEEEE">
				<cfelse>
					<td align="left">
				</cfif>
						<span class="pix13realblack">
							#CompetitionName#
							<cfif TRIM(#RoundName#)IS NOT "" >
								 <BR> #RoundName#
							</cfif>
						</span>
					</td>
					<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
						<td align="center">
							<span class="pix10red">
							<cfif ListFind( #ChosenConstits#, HomeID ) GT "0" >
							<strong>#HomeSportsmanshipMarks#</strong>
							<cfelse>
							#HomeSportsmanshipMarks#
							</cfif>
							</span>
						</td>
					</cfif>
				<cfif HideFixtures IS "Yes">
					<td align="RIGHT" bgcolor="##EEEEEE">
				<cfelse>
					<td align="RIGHT">
				</cfif>
						<span class="pix13realblack">#HomeTeam# #HomeOrdinal#</span> 
						<cfif HomePointsAdjust IS NOT "" AND HomePointsAdjust IS NOT 0>
						<span class="pix10realblack">
						<br>#NumberFormat(HomePointsAdjust,"+9")# <cfif HomePointsAdjust IS 1 OR HomePointsAdjust IS -1>point<cfelse>points</cfif></span>
						</cfif>						
					</td>
					<!--- merge cells if Postponed or Abandoned or HideDivision --->
					<cfif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (HomeGoals IS "" AND AwayGoals IS "" AND Result IS "") >
								<td width="70" colspan="2" align="center"><span class="pix10grey">&nbsp;</span></td>
					<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "H" OR (HomeGoals GT AwayGoals)) >
								<td width="70" colspan="2" align="center"><span class="pix10grey">Played</span></td>
					<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "A" OR (HomeGoals LT AwayGoals)) >
								<td width="70" colspan="2" align="center"><span class="pix10grey">Played</span></td>
					<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "D" OR (HomeGoals IS AwayGoals AND IsNumeric(HomeGoals) AND IsNumeric(AwayGoals) )) >
								<td width="70" colspan="2" align="center"><span class="pix10grey">Played</span></td>
					<cfelseif Result IS "P" >
						<td colspan="2" align="center"><span class="pix18boldgray">P</span></td>
					<cfelseif Result IS "Q" >
						<td colspan="2" align="center"><span class="pix18boldgray">A</span></td>
					<cfelseif Result IS "W" >
						<td colspan="2" align="center"><span class="pix18boldgray">V</span></td>
					<cfelseif Result IS "T" >  
						<td colspan="2" align="center" bgcolor="aqua"><span class="pix18boldgray">TEMP</span></td>
					<cfelse>
						<td align="CENTER">
							<span class="pix13realblack">
							<cfif Result IS "H" >
								H
							<cfelseif Result IS "A" >
								-
							<cfelseif Result IS "D" >
								D 
							<cfelse>
								&nbsp;#HomeGoals#&nbsp;
							</cfif>
							</span>
						</td>
						<td align="CENTER">
							<span class="pix13realblack">
							<cfif Result IS "H" >
								-
							<cfelseif Result IS "A" >
								A
							<cfelseif Result IS "D" >
								D 
							<cfelse>
								&nbsp;#AwayGoals#&nbsp;
							</cfif> 
							</span>		
						</td>
					</cfif>
				<cfif HideFixtures IS "Yes">
					<td align="left" bgcolor="##EEEEEE">
				<cfelse>
					<td align="left">
				</cfif>
						<span class="pix13realblack">
						#AwayTeam# #AwayOrdinal# 
						<cfif Result IS "H" AND HideScore IS "No">[ Home Win was awarded ]
						<cfelseif Result IS "A" AND HideScore IS "No">[ Away Win was awarded ]
						<cfelseif Result IS "U" AND HideScore IS "No">[ Home Win on penalties ]
						<cfelseif Result IS "V" AND HideScore IS "No">[ Away Win on penalties ]
						<cfelseif Result IS "D" AND HideScore IS "No">[ Draw was awarded ]
						<cfelseif Result IS "P" >[ Postponed ]
						<cfelseif Result IS "Q" >[ Abandoned ]
						<cfelseif Result IS "W" >[ Void ]
						<cfelseif Result IS "T" ></span><span class="pix10italic">fixture hidden from the public</span><span class="pix13realblack"> 
						<cfelse>
						</cfif> 
						</span>
						<cfif AwayPointsAdjust IS NOT "" AND AwayPointsAdjust IS NOT 0>
						<span class="pix10realblack">
						<br>#NumberFormat(AwayPointsAdjust,"+9")# <cfif AwayPointsAdjust IS 1 OR AwayPointsAdjust IS -1>point<cfelse>points</cfif>
						</span>
						</cfif>
					</td>
					<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
						<td align="center">
							<span class="pix10red">
							<cfif ListFind( #ChosenConstits#, AwayID ) GT "0" >
							<strong>#AwaySportsmanshipMarks#</strong>
							<cfelse>
							#AwaySportsmanshipMarks#
							</cfif>
							</span>
						</td>
					</cfif>
				<cfif HideFixtures IS "Yes">
					<td align="left" bgcolor="##EEEEEE">
				<cfelse>
					<td align="left">
				</cfif>
						<span class="pix13realblack">#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#</span>
						<cfif #Attendance# IS "" >
						<cfelse>
							<span class="pix10navy"><br>Attendance #NumberFormat(Attendance, '99,999')#</span>
						</cfif>
					</td>			
				</tr>
						<cfif DefaultGoalScorers IS "Yes">
							<tr>
							<cfif HomeAway IS "H">
								<td <cfif ListFind("Silver,Skyblue",request.SecurityLevel) >colspan="3"<cfelse>colspan="2"</cfif>></td>		
								<td colspan="1" align="RIGHT">
									<table border="0" cellspacing="0" cellpadding="0">
										<cfinclude template="InclTeamGoalscorers.cfm">	 <!--- <tr></tr> Goalscorers --->
									</table>
								</td>
							<cfelse>
								<td <cfif ListFind("Silver,Skyblue",request.SecurityLevel) >colspan="6"<cfelse>colspan="5"</cfif>></td>
								<td colspan="1" align="LEFT">
									<table border="0" cellspacing="0" cellpadding="0">
										<cfinclude template="InclTeamGoalscorers.cfm">	 <!--- <tr></tr> Goalscorers --->
									</table>
								</td>
							
							</cfif>
							</tr>
						</cfif>


				</cfif>
				
				
				
				
				
			</cfoutput>
	</TABLE>
</cfif>
<table align="center" bgcolor="white">
	<tr>
		<td align="center" valign="top">
			<cfif DefaultGoalScorers IS "Yes">
				<cfinclude template="TeamAllCompGoalscorers.cfm">
			</cfif>
		</td>
	</tr>
</table>
