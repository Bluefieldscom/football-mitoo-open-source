<cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- check that the url.PI parameter has not been tampered with. There should be at least one row in the 'register' table for the current team --->
<cfif ListFind("Yellow",request.SecurityLevel) >
	<cfinclude template="queries/qry_QPIValid.cfm">
	<cfif QPIValid.RecordCount IS 0>
		<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
		<cfabort>
	</cfif>
</cfif>

<cfinclude template="queries/qry_QPlayer.cfm">
<cflock scope="session" timeout="10" type="exclusive">
	<cfset session.fmPlayerID = PI >
</cflock>
<cfset PlayersHist = "Yes">  <!--- a switch to tell the Heading in Toolbar2 that it's a Player's History --->
<cfinclude template="InclBegin.cfm">
<cfinclude template="queries/qry_QPlayerHistory.cfm">
<cfif QPlayerHistory.RecordCount IS "0">
		<span class="pix18bold">No history</span>
<cfelse>
	<cfinclude template="queries/qry_QPlayerYellows.cfm">
	<cfinclude template="queries/qry_QPlayerReds.cfm">
	<cfinclude template="queries/qry_QPlayerOranges.cfm">
	
	<cfinclude template="queries/qry_QPlayerActivity1.cfm">
	<cfinclude template="queries/qry_QPlayerActivity2.cfm">
	<cfinclude template="queries/qry_QPlayerActivity3.cfm">
	
	<cfinclude template="queries/qry_QPlayerGoals.cfm">
		<cfinclude template="queries/qry_QPlayerSuspensions.cfm">

	<cfoutput>
	<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
		<cfinclude template="inclCautionThresholdsPI.cfm">
			<cfif QPlayer.Notes IS NOT "">
				<table WIDTH="100%" border="1" cellspacing="0" cellpadding="5" class="loggedinScreen">
					<tr>
						<td align="center">
							<span class="pix10">#QPlayer.Notes#</span>
						</td>
					</tr>
								<!--- applies to season 2012 onwards only --->
								<cfif RIGHT(request.dsn,4) GE 2012 AND Len(Trim("#QPlayer.AddressLine1##QPlayer.AddressLine2##QPlayer.AddressLine3##QPlayer.Postcode#")) GT 0>
									<table>
										<tr>
											<td align="left">
												<span class="pix13bold">#QPlayer.AddressLine1#&nbsp;&##8226;&nbsp;#QPlayer.AddressLine2#&nbsp;&##8226;&nbsp;#QPlayer.AddressLine3#&nbsp;&##8226;&nbsp;#QPlayer.Postcode#</span>
											</td>
										</tr>
									</table>
								</cfif>
					
				</table>
			</cfif>
	</cfif>
	
	
	<table WIDTH="100%" border="1" cellspacing="0" cellpadding="5"  class="loggedinScreen">
		<tr>
			<td><span class="pix10">games  = #QPlayerHistory.RecordCount# (started=#QPlayerActivity1.ACount#&nbsp;&nbsp;sub played? Y=#QPlayerActivity2.ACount#, N=#QPlayerActivity3.ACount#)</span></td>
			
			
			
			<cfif QPlayerYellows.CardCount GT 0>
				<cfset YellowCardCount = QPlayerYellows.CardCount >
			<cfelse>
				<cfset YellowCardCount = 0 >
			</cfif>
			<cfif QPlayerReds.CardCount GT 0>
				<cfset RedCardCount = QPlayerReds.CardCount >
			<cfelse>
				<cfset RedCardCount = 0 >
			</cfif>
			<cfif QPlayerOranges.CardCount GT 0>
				<cfset YellowCardCount = YellowCardCount + QPlayerOranges.CardCount >
				<cfset RedCardCount = RedCardCount + QPlayerOranges.CardCount >
			</cfif>
			
			
			
			<cfif YellowCardCount + RedCardCount GT 0 >
				<td><span class="pix10">yellow cards = #YellowCardCount#</span></td>
				<td><span class="pix10">red cards = #RedCardCount#</span></td>
			</cfif>
			<cfif QPlayerGoals.TotalGoalsScored GT 0>
				<td><span class="pix10">goals scored = #NumberFormat(QPlayerGoals.TotalGoalsScored, '999')#</span></td>
				<td><span class="pix10">goals per game played = #NumberFormat(Evaluate(QPlayerGoals.TotalGoalsScored/QPlayerHistory.RecordCount), '999.999')#</span></td>
			</cfif>
			<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
				<td bgcolor="aqua"><span class="pix10bold"><a href="UpdateForm.cfm?TblName=Player&ID=#PI#&LeagueCode=#LeagueCode#">click here<br>for Updating/Deleting<br>Player screen</a></span></td>
			</cfif>
			<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
				<td bgcolor="aqua"><span class="pix10bold"><a href="LUList.cfm?TblName=Player&LeagueCode=#LeagueCode#&FirstNumber=#QPlayerHistory.shortcol#&LastNumber=#QPlayerHistory.shortcol#">click here<br>for Suspensions<br>and Registrations</a></span></td>
			</cfif>
			
		</tr>
	</table>
	</cfoutput>

	<table WIDTH="100%" border="1" cellspacing="0" cellpadding="5"  class="loggedinScreen">
		<tr>
			<cfoutput query="QPlayerSuspensions" >
				<tr>
					<td width="100%" class="bg_suspend">
					<cfif FirstDay IS NOT "">
						<cfif NumberOfMatches GT 0>
							<span class="pix10boldred">#NumberOfMatches# match ban</span>
						<cfelse>
							<span class="pix10"><strong>#ROUND(Evaluate((DateDiff("h", FirstDay, LastDay) +25)/ 24))#</strong> days suspension</span>
						</cfif>				
						<span class="pix10">from <strong>#DateFormat( FirstDay , 'DD MMMM YYYY')#</strong></span>
					 </cfif>
					<cfif LastDay IS '2999-12-31' >
						<span class="pix10boldred"> suspension ongoing</span>
					<cfelse>
						<span class="pix10"> to <strong>#DateFormat( LastDay , 'DD MMMM YYYY')#</strong></span>
					</cfif>
					 
					</td>
				</tr>
			</cfoutput>
			
			
			
	</table>
	<table width="100%" border="1" cellspacing="0" cellpadding="2" class="loggedinScreen">
		<cfoutput query="QPlayerHistory" >
			<cfset Highlight = "No">
			<cflock scope="session" timeout="10" type="readonly">
				<cfif session.fmTeamID IS HomeTeamID OR session.fmTeamID IS AwayTeamID >
					<cfset Highlight = "Yes">
				</cfif>
			</cflock>
			<tr>
				<td width="30%" <cfif Highlight>class="bg_highlight"</cfif> >
					<span class="pix13">#CompetitionName#</span>
					<cfif TRIM(#RoundName#) IS NOT "" >
						 <span class="pix10"><BR> #RoundName#</span>
					</cfif>
				</td>
				<td width="25%" align="RIGHT" <cfif Highlight>class="bg_highlight"</cfif> >
					<span class="pix13"><cfif HomeAway IS "H"><strong>#HomeTeam# #HomeOrdinal#</strong><cfelse>#HomeTeam# #HomeOrdinal#</cfif></span>
				</td>
				<cfif Result IS "P" >
					<td width="4%" colspan="2" align="CENTER" <cfif Highlight>class="bg_highlight"</cfif> ><span class="pix10boldred">Postponed</span></td>
				<cfelseif Result IS "Q" >
					<td width="4%" colspan="2" align="CENTER" <cfif Highlight>class="bg_highlight"</cfif> ><span class="pix10boldred">Abandoned</span></td>
				<cfelseif Result IS "W" >
					<td width="4%" colspan="2" align="CENTER" <cfif Highlight>class="bg_highlight"</cfif> ><span class="pix10boldred">Void</span></td>
				<cfelseif Result IS "T" ><!--- should never happen, how can a player have an appearance in a TEMP game? --->
					<td width="4%" colspan="2" align="CENTER" <cfif Highlight>class="bg_highlight"</cfif> ><span class="pix10boldred">TEMP</span></td>

				<cfelse>
					<td width="2%" align="CENTER" <cfif Highlight>class="bg_highlight"</cfif> >
						<span class="pix13">
						<cfif Result IS "H" >
							H
						<cfelseif Result IS "A" >
							-
						<cfelseif Result IS "D" >
							D
						<cfelse>
							#HomeGoals#
						</cfif>
						</span>
					</td>
					<td  width="2%" align="CENTER" <cfif Highlight>class="bg_highlight"</cfif> >
						<span class="pix13">
						<cfif Result IS "H" >
							-
						<cfelseif Result IS "A" >
							A
						<cfelseif Result IS "D" >
							D
						<cfelse>
							#AwayGoals#
						</cfif> 
						</span>
					</td>
				</cfif>
				<td width="25%" align="left" <cfif Highlight>class="bg_highlight"</cfif>>
					<span class="pix13"><cfif HomeAway IS "A"><strong>#AwayTeam# #AwayOrdinal#</strong><cfelse>#AwayTeam# #AwayOrdinal#</cfif></span>			
				</td>
				<cfif GoalsScored IS 0>
					<td width="1%"><span class="pix13">&nbsp;</span></td>
				<cfelse>
					<td width="1%" bgcolor="White" align="center"><span class="pix13bold">#GoalsScored#</span></td>
				</cfif>
				<cfif Card IS 0>
					<td width="1%" align="center"><span class="pix13">&nbsp;</span></td>
				<cfelseif Card IS 1>
					<td width="1%" bgcolor="Yellow" align="center"><span class="pix13bold">Y</span></td>
				<cfelseif Card IS 3>
					<td width="1%" bgcolor="Red" align="center"><span class="pix13boldwhite">R</span></td>
				<cfelseif Card IS 4>
					<td width="1%" bgcolor="Orange" align="center"><span class="pix13bold">4</span></td>
				<cfelse>
					<td width="1%" bgcolor="White" align="center"><span class="pix13boldred">?</span></td>
				</cfif>
				<td width="8%"><a href="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(FixtureDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#"><span class="pix10">#DateFormat(FixtureDate,'DDD DD MMM')#</span></a></td>
				<cfif Activity IS 1>
					<td width="2%" align="center"><span class="pix10">&nbsp;</span></td>
				<cfelseif Activity IS 2>
					<td width="2%" align="center" bgcolor="silver"><span class="pix10">sub<br>Y</span></td>
				<cfelseif Activity IS 3>
					<td width="2%" align="center" bgcolor="white"><span class="pix10">sub<br>N</span></td>
				</cfif>
				<td width="4%"><a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=#HomeAway#&DivisionID=#DivisionID#"><img src="gif/TeamSheet.gif" alt="Team Sheet" width="35" height="23" border="1" align="top"></a></td>
			</tr>
		</cfoutput>
	</table>
</cfif>
