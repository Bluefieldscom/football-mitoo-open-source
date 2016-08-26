<!--- the only difference between PlayersHistory.cfm and PlayersHistory2.cfm is PlayersHistory.cfm has the extra link at the top to *  see Player: Goals Scored --->

<!--- This is a "cut down" version of PlayersHist.cfm in that sensitive information is not displayed i.e. player's notes, suspensions, red/yellow cards 
It is only available to people who have the short 3 char password allowing them access to the yellow League Reports menu--->
<cfif NOT StructkeyExists(url, "PI") >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfinclude template="queries/qry_QPlayer.cfm"> <!--- this is INDEED required for the surname and forenames in the heading of "Player's Appearances"  in PlayersHistory.cfm --->
<cflock scope="session" timeout="10" type="exclusive">
	<cfset session.fmPlayerID = PI >
</cflock>
<cfset PlayersHist = "Yes">  <!--- a switch to tell the Heading in Toolbar2 that it's a Player's History --->
<cfinclude template="InclBegin.cfm">
<cfinclude template="queries/qry_QPlayerHistory.cfm">
<cfif QPlayerHistory.RecordCount IS "0">
		<span class="pix18bold">No history</span>
<cfelse>
	
	<cfinclude template="queries/qry_QPlayerActivity1.cfm">
	<cfinclude template="queries/qry_QPlayerActivity2.cfm">
	<cfinclude template="queries/qry_QPlayerActivity3.cfm">

	<cfinclude template="queries/qry_QPlayerGoals.cfm">
	<table WIDTH="100%" border="1" cellspacing="0" cellpadding="5" class="loggedinScreen">
		<cfoutput>
		<tr>
			<td><span class="pix10">games  = #QPlayerHistory.RecordCount# (started=#QPlayerActivity1.ACount#&nbsp;&nbsp;sub played? Y=#QPlayerActivity2.ACount#, N=#QPlayerActivity3.ACount#)</span></td>
			<cfif QPlayerGoals.TotalGoalsScored GT 0>
				<td align="center"><span class="pix10">goals scored = #NumberFormat(QPlayerGoals.TotalGoalsScored, '999')#</span></td>
				<td><span class="pix10">goals per game played = #NumberFormat(Evaluate(QPlayerGoals.TotalGoalsScored/(QPlayerActivity1.ACount+QPlayerActivity2.ACount)), '999.999')#</span></td>
			</cfif>
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
				<td width="25%" <cfif Highlight>class="bg_highlight"</cfif>>
					<span class="pix13"><cfif HomeAway IS "A"><strong>#AwayTeam# #AwayOrdinal#</strong><cfelse>#AwayTeam# #AwayOrdinal#</cfif></span>			
				</td>
				<cfif GoalsScored IS 0>
					<td width="1%"><span class="pix13">&nbsp;</span></td>
				<cfelse>
					<td width="1%" bgcolor="White" align="center"><span class="pix13bold">#GoalsScored#</span></td>
				</cfif>
				<td width="9%"><a href="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(FixtureDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#"><span class="pix10">#DateFormat(FixtureDate,'DDD DD MMM')#</span></a></td>
				<cfif Activity IS 1>
					<td width="2%" align="center"><span class="pix10">&nbsp;</span></td>
				<cfelseif Activity IS 2>
					<td width="2%" align="center" bgcolor="silver"><span class="pix10">sub<br>Y</span></td>
				<cfelseif Activity IS 3>
					<td width="2%" align="center" bgcolor="white"><span class="pix10">sub<br>N</span></td>
				</cfif>
			</tr>
		</cfoutput>
	</table>
</cfif>
