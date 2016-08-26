<cfinclude template="InclBegin.cfm">
<!--- HideDivision will suppress everything for this Division --->
<cfif Find( "HideDivision", QKnockOut.Notes )>
	<cfset HideDivision = "Yes">
<cfelse>
	<cfset HideDivision = "No">
</cfif>
<cfif HideDivision IS "Yes"  >
	<table border="0" cellspacing="2" cellpadding="2" align="CENTER">
		<tr>
			<td align="center" ><span class="pix10bold">Leading Goalscorers Table<br>has been suppressed by the league</span></td>
		</tr>
	</table>
	<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cfelse>
		<CFABORT>
	</cfif>
</cfif>

<table width="100%" border="0" cellspacing="2" cellpadding="0" >
	<tr>
		<td align="center" valign="top">
			<cfif DefaultGoalScorers IS "Yes">
			
				<cfif SuppressLeadingGoalscorers IS 1>
					<table border="0" cellspacing="2" cellpadding="2" align="CENTER">
						<tr>
							<td align="center" ><span class="pix10bold">Leading Goalscorers Table<br>has been suppressed by the league</span></td>
						</tr>
					</table>
				<cfelse>			
					<cfinclude template="queries/qry_QGoalsScored1.cfm">
					<!--- <cfdump var="#QGoalsScored#"><cfabort> --->
					<table border="0" cellspacing="2" cellpadding="2" align="CENTER">
						<cfoutput>
						<tr>
							<td><span class="pix10bold"> </span></td>
							<td><span class="pix10bold">Last Appeared For</span></td>
							<td><span class="pix10bold">Player</span></td>
							<td align="CENTER"><span class="pix10bold">Games<BR>Played</span></td>
							<td align="CENTER"><span class="pix10bold">Goals</span></td>
						</tr>
						</cfoutput>
						<cfset LineCount = 0 >
						<cfset CurrentGoals = 1000 >
						<cfoutput query="QGoalsScored">
							<cfif LineCount GE 15>
								<cfif QGoalsScored.Goals IS CurrentGoals >
									<tr class="bg_highlight0" onmouseover="this.className='bg_highlight2';" onmouseout="this.className='bg_highlight0';" >
										<td><span class="pix10"><a href="PlayersHistory2.cfm?PI=#PlayerID#&LeagueCode=#LeagueCode#">See Appearances</a></span></td>
										<cfif LastAppearedFor IS NOT CurrentlyRegisteredTo>
											<td align="left" ><span class="pix10">#LastAppearedFor# <cfif CurrentlyRegisteredTo IS ''>(currently unregistered)<cfelse>(currently with #CurrentlyRegisteredTo#)</cfif></span></td>						
										<cfelse>
											<td align="LEFT"><span class="pix10">#LastAppearedFor#</span></td>						
										</cfif>
										<td><span class="pix10"><strong>#Surname#</strong> #Left(Forename,1)#</span></td>
										<td align="CENTER"><span class="pix10">#GamesPlayed#</span></td>
										<td align="CENTER"><span class="pix10">#Goals#</span></td>
										<cfset LineCount = LineCount + 1 >
									</tr>
								</cfif>
							<cfelse>
								<cfset CurrentGoals = MIN(QGoalsScored.Goals, CurrentGoals) >
								<tr class="bg_highlight0" onmouseover="this.className='bg_highlight2';" onmouseout="this.className='bg_highlight0';" >
									<td><span class="pix10"><a href="PlayersHistory2.cfm?PI=#PlayerID#&LeagueCode=#LeagueCode#">See Appearances</a></span></td>
									<cfif LastAppearedFor IS NOT CurrentlyRegisteredTo>
										<td align="left" ><span class="pix10">#LastAppearedFor# <cfif CurrentlyRegisteredTo IS ''>(currently unregistered)<cfelse>(currently with #CurrentlyRegisteredTo#)</cfif></span></td>						
									<cfelse>
										<td align="LEFT"><span class="pix10">#LastAppearedFor#</span></td>						
									</cfif>
									<td><span class="pix10"><strong>#Surname#</strong> #Left(Forename,1)#</span></td>
									<td align="CENTER"><span class="pix10">#GamesPlayed#</span></td>
									<td align="CENTER"><span class="pix10">#Goals#</span></td>
									<cfset LineCount = LineCount + 1 >
								</tr>
							</cfif>
						</cfoutput>
						<tr>
							<td colspan="4" align="center"><span class="pix10"><br>Note: If <strong>Games Played</strong> always less than <strong>Goals</strong>
								then appearances have only been recorded for games in which the player has scored.</span></td>
						</tr>
					</table>
				</cfif>
			<cfelse>
					<tr>
						<td height="50" align="center"><span class="pix13bold">A leading goalscorer table cannot be generated because<br />
						this league doesn't enter its goalscorer information.</span></td>
					</tr>
			</cfif>
		</td>
	</tr>
</table>
<!--- next, underneath the grid display various buttons....... 
Leading Goalscorers
Attendance Statistics
Expanded League Table
.... etc
--->
<table width="100%" border="0" cellpadding="0" cellspacing="5" >
	<tr>
		<td valign="top">
			<table>
				<cfset DivisionName = Getlong.CompetitionDescription>
				<cfinclude template="InclLeagueTabButtons.cfm">
			</table>
		</td>
		<td align="center">
			<cfinclude template="InclLeagueTabAdvertsTbl.cfm">
		</td>
	</tr>
</table>

