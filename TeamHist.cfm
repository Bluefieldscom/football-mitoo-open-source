<cfinclude template="queries/qry_QTeam_v1.cfm">
<cfinclude template="InclBegin.cfm">
<cfinclude template="queries/qry_QFixtures_v3.cfm">
<cfif QFixtures.RecordCount IS "0">
	<span class="pix13boldrealblack">No matches have been played</span>
<cfelse>
	<cfif DefaultGoalScorers IS "Yes">
		<cfinclude template="InclGoalscorerInfo.cfm">
		<cfinclude template="InclStarPlayerInfo.cfm">
	</cfif>
	<cfif Left(QKnockOut.Notes,2) IS "KO" ><cfset KOComp = "Yes"><cfelse><cfset KOComp = "No"></cfif>
	<cfif Left(QKnockOut.Notes,2) IS "P1" ><cfset PlayOne = "Yes"><cfelse><cfset PlayOne = "No"></cfif>
	<cfif Left(QKnockOut.Notes,2) IS "P3" ><cfset PlayThree = "Yes"><cfelse><cfset PlayThree = "No"></cfif>
	<cfif Left(QKnockOut.Notes,2) IS "P4" ><cfset PlayFour = "Yes"><cfelse><cfset PlayFour = "No"></cfif>
	<!--- show games yet to be scheduled at the bottom of the screen only if standard P2 situation i.e. plays Home & Away --->
	<cfif PlayOne IS "No" AND PlayThree IS "No" AND PlayFour IS "No">
		<cfset ThisTeamID = CI >
		<cfinclude template="queries/qry_QUnschedHomeMatches.cfm">
		<cfinclude template="queries/qry_QUnschedAwayMatches.cfm">
	</cfif>

<!--- display the query result set as a table with the appropriate headings ---> 

<table width="100%" border="0" cellspacing="2" cellpadding="2" >
<tr>
	<td align="left" colspan="100"><span class="pix13boldrealblack"><cfoutput>#QFixtures.RecordCount#</cfoutput> in list</span></td>
</tr>
<cfoutput query="QFixtures">
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
			<td colspan="9" align="RIGHT">&nbsp;</td>
			<td colspan="2" align="center"><span class="pix10bold">hidden</span></td>
			<td colspan="8">&nbsp;</td>
			<td align="left" colspan="8"><span class="pix13realblack">#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#</span></td>
		</tr>
	<cfelseif Result IS "T" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel)>
		<!--- suppress this match if TEMP and not logged in --->
	<cfelse>
		<cfif HideFixtures IS "Yes">
			<tr bgcolor="##EEEEEE">
		<cfelse>
			<tr>
		</cfif>
		<cfif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel)>
			<td align="CENTER"><span class="pix13realblack">&nbsp;</span></td>
		<cfelse>
			<td colspan="1" align="CENTER">
			<span class="pix13realblack">
			<cfif HomeID IS #CI#>
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
			<cfif AwayID IS #CI#>
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
	
			<cfif HomeID IS #CI#>
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
			<cfif AwayID IS #CI#>
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
				
				<td colspan="8" align="RIGHT">
				<span class="pix13realblack">#HomeTeam# #HomeOrdinal#</span>
					<cfif HomePointsAdjust IS NOT "" AND HomePointsAdjust IS NOT 0><span class="pix10realblack"><br>#NumberFormat(HomePointsAdjust,"+9")# <cfif HomePointsAdjust IS 1 OR HomePointsAdjust IS -1>point<cfelse>points</cfif></span></cfif>						
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
				<td align="left" colspan="8">
				<span class="pix13realblack">
				#AwayTeam# #AwayOrdinal#
					<cfif TRIM(#RoundName#)IS NOT "" >
						 [ #RoundName# ]
					</cfif>
					
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
					<cfif AwayPointsAdjust IS NOT "" AND AwayPointsAdjust IS NOT 0><span class="pix10realblack"><br>#NumberFormat(AwayPointsAdjust,"+9")# <cfif AwayPointsAdjust IS 1 OR AwayPointsAdjust IS -1>point<cfelse>points</cfif></span></cfif>
		
				</span>
		
				</td>
		
				<td align="left" colspan="8">
				<span class="pix13realblack">
					#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#
				</span>
				<cfif #Attendance# IS "" >
				<cfelse>
					<span class="pix10navy"><br>Attendance #NumberFormat(Attendance, '99,999')#</span>
				</cfif>
		
				</td>			
		
					
				</tr>
				
				
				
				<cfif DefaultGoalScorers IS "Yes">
					<cfif HideFixtures IS "Yes">
						<tr bgcolor="##EEEEEE" >
					<cfelse>
						<tr>
					</cfif>
						<td></td>
						<cfif HomeAway IS "H">
							<td colspan="8" align="RIGHT">
								<table border="0" cellspacing="0" cellpadding="0">
									<cfinclude template="InclTeamGoalscorers.cfm">	 <!--- <tr></tr> Goalscorers --->
								</table>
							</td>
							<td colspan="10"></td>
						<cfelse>
							<td colspan="10"></td>
							<td colspan="8" align="LEFT">
								<table border="0" cellspacing="0" cellpadding="0">
									<cfinclude template="InclTeamGoalscorers.cfm">	 <!--- <tr></tr> Goalscorers --->
								</table>
							</td>
						
						</cfif>
						</tr>
				</cfif>
		
		</cfif> <!--- hide fixtures ? --->
	</cfoutput>
	<cfif PlayOne IS "No" AND PlayThree IS "No" AND PlayFour IS "No" AND KOComp IS "No" >
		<tr><td height="10"></td></tr>
		
		<cfset UnschedHomeMatchesCount = QUnschedHomeMatches.RecordCount >
		<cfset UnschedAwayMatchesCount = QUnschedAwayMatches.RecordCount >
		<cfif UnschedHomeMatchesCount GT 0  OR UnschedAwayMatchesCount GT 0 >
		<table border="1" align="center" cellpadding="2" cellspacing="0" >
			<tr>
				<td  align="left" valign="top">
				<table border="0" align="center" cellpadding="2" cellspacing="2" >
					<cfoutput>
						<tr>
							<td  align="left" height="30"><span class="pix13boldnavy">To be scheduled: Home games = #UnschedHomeMatchesCount#</span></td>
						</tr>
					</cfoutput>
					<cfoutput query="QUnschedHomeMatches">
						<tr>
							<td align="left"><span class="pix13realblack">#HomeTeam# v #AwayTeam#</span></td>
						</tr>
					</cfoutput>
				</table>
				</td>
				<td  align="left" valign="top">
				<table border="0" align="center" cellpadding="2" cellspacing="2" >
					<cfoutput>
						<tr>
							<td  align="left" height="30"><span class="pix13boldnavy">To be scheduled: Away games = #UnschedAwayMatchesCount#</span></td>
						</tr>
					</cfoutput>
					<cfoutput query="QUnschedAwayMatches">
						<tr>
							<td align="left"><span class="pix13realblack">#HomeTeam# v #AwayTeam#</span></td>
						</tr>
					</cfoutput>
				</table>
				</td>
			</tr>
		</table>
		</cfif>
	</cfif>
	
	<cfoutput>
		<table  border="1" align="center" cellpadding="5" cellspacing="0"  >
		<tr align="CENTER">
		<td height="30" align="left" >
		<span class="pix13realblack">Please click 
			<a href="TeamHistAll.cfm?CI=#CI#&TblName=Matches&LeagueCode=#LeagueCode#&DivisionID=#DivisionID#"><strong>here</strong></a>
			 to see Fixtures, Results, Goalscorers and Appearances in All Competitions.
		</span>
		</td>
		</tr>
		</table>
	</cfoutput>

</table>
</cfif>
<table align="center" bgcolor="white">
	<tr>
		<td align="center" valign="top">
			<cfif DefaultGoalScorers IS "Yes">
				<cfinclude template="TeamAllGoalscorers.cfm">
			</cfif>
		</td>
	</tr>
</table>
<cfif ListFind("Silver",request.SecurityLevel) >
	<span class="pix13boldrealblack"><BR><BR><BR><BR><BR><BR><BR><BR><cfoutput>#QTeam.TeamID# #QTeam.OrdinalID#</cfoutput></span>
</cfif>
