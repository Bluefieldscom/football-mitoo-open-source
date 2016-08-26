<table width="80%" class="leagueTable" >
<!---																		****************************************************************
																			* This chunk of code produces the league table column headings *
																			****************************************************************
--->
		<tr>
			<td><span class="pix13bold">&nbsp;<cfoutput>#QNewLeagueTable.RecordCount#</cfoutput> Teams</span></td>
			<td align="center"><span class="pix13bold"> </span></td>
			<td align="center"><span class="pix13bold">Games<BR>Played</span></td>
			<td align="center"><span class="pix13bold">Games<BR>Won</span></td>
			<td align="center"><span class="pix13bold">Games<BR>Drawn</span></td>
			<td align="center"><span class="pix13bold">Games<BR>Lost</span></td>
			<cfif HideGoals IS "No">  <!--- otherwise hide next three columns: Goals For, Goals Against and  Goal Difference (or Average) --->
				<td align="center"><span class="pix13bold">Goals<BR>For</span></td>
				<td align="center"><span class="pix13bold">Goals<BR>Against</span></td>
				<cfif LeagueTblCalcMethod IS "No Method" >
				<cfelseif HideGoalDiff IS "Yes" >				
				<cfelseif LeagueTblCalcMethod IS "Goal Average">
					<td align="center"><span class="pix13bold">Goal<BR>Average</span></td>
				<cfelse>
					<td align="center"><span class="pix13bold">Goal<BR>Difference</span></td>
				</cfif>
			</cfif>
			<td align="center"><span class="pix13bold">Points</span></td>
		</tr>		
	<cfoutput query="QNewLeagueTable">
	<!--- 
																			*****************************************************
																			* This chunk of code produces the league table rows *
																			*****************************************************
	--->
		<cfif request.fmTeamID IS TeamID AND CurrentRow LE PromotedRows > <!--- HiLitePromoted #7CFC00 --->
			<cfset BGColorSpec = "##7CFC00">
		<cfelseif request.fmTeamID IS TeamID AND CurrentRow GE (QNewLeagueTable.RecordCount-RelegatedRows+1) > <!--- HiLiteRelegated #FF6347 --->
			<cfset BGColorSpec = "##FF6347">
		<cfelseif CurrentRow LE PromotedRows > <!--- Promoted #90EE90 --->
			<cfset BGColorSpec = "##90EE90">
		<cfelseif CurrentRow GE (QNewLeagueTable.RecordCount-RelegatedRows+1) > <!--- Relegated #FFA07A --->
			<cfset BGColorSpec = "##FFA07A">
		<cfelseif request.fmTeamID IS TeamID > <!--- HiLite #FFD0E3 --->
			<cfset BGColorSpec = "##FFD0E3">
		<cfelse>
			<cfset BGColorSpec = "">
		</cfif>
		<tr class="bg_highlight0" onmouseover="this.className='bg_highlight2';" onmouseout="this.className='bg_highlight0';" >
			<td align="LEFT" bgcolor="#BGColorSpec#" ><a href="TeamHist.cfm?CI=#ConstitutionID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#" ><span class="pix13realblack">#Name#</span></a></td>
			<td align="center" width="8%"  bgcolor="#BGColorSpec#"><a href="http://www.mitoo.co/?q=#Name#"><span class="pix13realblack">Follow</span></a></td><!--- Games Played --->
			<td align="center" width="8%"  bgcolor="#BGColorSpec#"><span class="pix13realblack">#HomeGamesPlayed+AwayGamesPlayed#</span></td><!--- Games Played --->
			<td align="center" width="8%"  bgcolor="#BGColorSpec#"><span class="pix13realblack">#HomeGamesWon+AwayGamesWon#</span></td><!--- Games Won --->
			<td align="center" width="8%"  bgcolor="#BGColorSpec#"><span class="pix13realblack">#HomeGamesDrawn+AwayGamesDrawn#</span></td><!--- Games Drawn --->
			<td align="center" width="8%"  bgcolor="#BGColorSpec#"><span class="pix13realblack">#HomeGamesLost+AwayGamesLost#</span></td><!--- Games Lost --->
			<cfset GoalsFor = HomeGoalsFor+AwayGoalsFor >
			<cfset GoalsAgainst = HomeGoalsAgainst+AwayGoalsAgainst >
			<cfset GoalDiff = GoalsFor - GoalsAgainst >
			<cfset Points = HomePoints + AwayPoints >
			<cfset PointsAdjust = HomePointsAdjust + AwayPointsAdjust + PointsAdjustment >
			<cfif HideGoals IS "No">  <!--- otherwise hide next three columns: Goals For, Goals Against and  Goal Difference (or Average) --->
				<td align="center" width="8%"  bgcolor="#BGColorSpec#"><span class="pix13realblack">#GoalsFor#</span></td><!--- Goals For --->
				<td align="center" width="8%"  bgcolor="#BGColorSpec#"><span class="pix13realblack">#GoalsAgainst#</span></td><!--- Goals Against --->
				<cfif LeagueTblCalcMethod IS "No Method" >
				<cfelseif HideGoalDiff IS "Yes" >
				<cfelseif LeagueTblCalcMethod IS "Goal Average">
					<cfif GoalsAgainst IS 0 >
						<cfset GoalAverage = 9999999 >
					<cfelse>
						<cfset GoalAverage = GoalsFor / GoalsAgainst >
					</cfif>
					<td align="center" width="8%"  bgcolor="#BGColorSpec#"><cfif GoalAverage GT 99.9999><span class="pix13realblack">99.9999</span><cfelse><span class="pix13">#NumberFormat( GoalAverage, "99.9999")#</span></cfif></td>
				<cfelse>
					<cfif Len(Trim(Special)) GT 0 > 
						<cfset BGColorSpec = "bg_suspend" >
					</cfif>			
					<td align="center" width="8%"  bgcolor="#BGColorSpec#"><span class="pix13realblack">#NumberFormat( GoalDiff, "L+999999^")#</span></td>
				</cfif>
			</cfif>
			<!--- Points --->
			<cfif Len(Trim(Special)) GT 0 >  
				<cfset BGColorSpec = "bg_suspend" >
			</cfif>			
			<td align="center" width="8%"  bgcolor="#BGColorSpec#"><cfif PointsAdjust IS 0><span class="pix13realblack">#Points#</span><cfelse><span class="pix13boldnavy">#Points+PointsAdjust#</span></cfif></td>
		</tr>		
	</cfoutput>
	<tr><td><img src="trans.gif" height="15" width="1" /><!--<SPACER TYPE="block" HEIGHT="15" WIDTH="1">--></td></tr>
</table>
