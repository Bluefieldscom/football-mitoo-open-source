<table width="80%" class="leagueTable" >
<!---																		****************************************************************
																			* This chunk of code produces the league table column headings *
																			****************************************************************
--->
		<tr>
			<td><span class="pix13bold">&nbsp;</span></td>
			<td align="center"><span class="pix13bold">Games<BR>Played</span></td>
			<td align="center"><span class="pix13bold">Games<BR>Won</span></td>
			<td align="center"><span class="pix13bold">Games<BR>Drawn</span></td>
			<td align="center"><span class="pix13bold">Games<BR>Lost</span></td>
			<cfif HideGoals IS "No">  <!--- otherwise hide next three columns: Goals For, Goals Against and  Goal Difference (or Average) --->
				<td align="center"><span class="pix13bold">Goals<BR>For</span></td>
				<td align="center"><span class="pix13bold">Goals<BR>Against</span></td>
				<cfif LeagueTblCalcMethod IS "No Method" >
				<cfelseif LeagueTblCalcMethod IS "Goal Average">
					<td align="center"><span class="pix13bold">Goal<BR>Average</span></td>
				<cfelse>
					<td align="center"><span class="pix13bold">Goal<BR>Difference</span></td>
				</cfif>
			</cfif>
			<td align="center"><span class="pix13bold">Points</span></td>
			<td align="center"><span class="pix13bold">Average Points<br />per Game</span></td>
		</tr>		
	<cfoutput query="QLeagueTableRows">
	<!--- 
																			*****************************************************
																			* This chunk of code produces the league table rows *
																			*****************************************************
	--->
		<cfset Highlight = "No">
		
		<cfif StructKeyExists(session, "fmTeamID") >
			<cfif session.fmTeamID IS TeamID>
				<cfset Highlight = "Yes">
			</cfif>
		</cfif>
		<cfif AveDenom IS 0>
		<cfelse>
			<tr class="bg_highlight0" onmouseover="this.className='bg_highlight2';" onmouseout="this.className='bg_highlight0';" >
			<td align="LEFT" <cfif Highlight>class="bg_highlight"</cfif> >
			
				<a href="TeamHist.cfm?CI=#CIdentity#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#" >
				<span class="pix13realblack">#ClubName# #OrdinalName#</span><!--- Team --->
				</a>
			</td>
			<td align="center" <cfif Highlight>class="bg_highlight"</cfif>><span class="pix13realblack">#GamesPlayed#</span></td><!--- Games Played --->
			<td align="center" <cfif Highlight>class="bg_highlight"</cfif>><span class="pix13realblack">#GamesWon#</span></td><!--- Games Won --->
			<td align="center" <cfif Highlight>class="bg_highlight"</cfif>><span class="pix13realblack">#GamesDrawn#</span></td><!--- Games Drawn --->
			<td align="center" <cfif Highlight>class="bg_highlight"</cfif>><span class="pix13realblack">#GamesLost#</span></td><!--- Games Lost --->
			<cfif HideGoals IS "No">  <!--- otherwise hide next three columns: Goals For, Goals Against and  Goal Difference (or Average) --->
				<td align="center" <cfif Highlight>class="bg_highlight"</cfif>><span class="pix13realblack">#GoalsFor#</span></td><!--- Goals For --->
				<td align="center" <cfif Highlight>class="bg_highlight"</cfif>><span class="pix13realblack">#GoalsAgainst#</span></td><!--- Goals Against --->
				<cfif LeagueTblCalcMethod IS "No Method" >
				<cfelseif LeagueTblCalcMethod IS "Goal Average">
					<td align="center" <cfif Highlight>class="bg_highlight"</cfif>><cfif GoalAverage GT 99.9999><span class="pix13realblack">99.9999</span><cfelse><span class="pix13realblack">#NumberFormat( GoalAverage, "99.9999")#</span></cfif></td>
				<cfelse>
					<td align="center" <cfif Highlight>class="bg_highlight"</cfif>><span class="pix13">#NumberFormat( GoalDiff, "L+999999^")#</span></td>
				</cfif>
			</cfif>

			<td align="center" <cfif Highlight>class="bg_highlight"</cfif>><span class="pix13realblack">#Points#</span></td><!--- Points --->
			<td align="center" <cfif Highlight>class="bg_highlight"</cfif>><span class="pix13realblack">#NumberFormat( AvePoints, "9.99")#</span></td><!--- Average Points per Game --->
		</tr>
		</cfif>		
	</cfoutput>
</table>
