<table width="100%" border="0" cellspacing="2" cellpadding="0" >
<!---																		****************************************************************
																			* This chunk of code produces the league table column headings *
																			****************************************************************
--->
		<tr>
			<td rowspan="3" ><span class="pix13bold"><cfoutput>#QLeagueTableComponents.RecordCount#</cfoutput> Teams</span></td>
			<td align="center" <cfif HideGoals IS "Yes">colspan="5"<cfelse>colspan="7"</cfif>><span class="pix13bold">Home</span></td>
			<td <cfoutput>rowspan="#QLeagueTableComponents.RecordCount+3#"</cfoutput>>&nbsp;</td>
			<td align="center" <cfif HideGoals IS "Yes">colspan="5"<cfelse>colspan="7"</cfif>><span class="pix13bold">Away</span></td>
		</tr>	
		<tr>
			<td align="center" colspan="4"><span class="pix10bold">Games</span></td>
			<cfif HideGoals IS "No">  
				<td align="center" colspan="2"><span class="pix10bold">Goals</span></td>
			</cfif>
			<td width="50" rowspan="2" align="center" valign="top"><span class="pix10bold">Points</span></td>

			<td align="center" colspan="4"><span class="pix10bold">Games</span></td>
			<cfif HideGoals IS "No">  
				<td align="center" colspan="2"><span class="pix10bold">Goals</span></td>
			</cfif>
			<td width="50" rowspan="2" align="center" valign="top"><span class="pix10bold">Points</span></td>
		</tr>	
		<tr>
			<!--- Home --->
			<td width="50" align="center"><span class="pix10bold">Played</span></td>
			<td width="50" align="center"><span class="pix10bold">Won</span></td>
			<td width="50" align="center"><span class="pix10bold">Drawn</span></td>
			<td width="50" align="center"><span class="pix10bold">Lost</span></td>
			<cfif HideGoals IS "No">  <!--- otherwise hide next 2 columns: Goals For, Goals Against --->
				<td width="50" align="center"><span class="pix10bold">For</span></td>
				<td width="50" align="center"><span class="pix10bold">Against</span></td>
			</cfif>
			
			<!--- Away --->
			<td width="50" align="center"><span class="pix10bold">Played</span></td>
			<td width="50" align="center"><span class="pix10bold">Won</span></td>
			<td width="50" align="center"><span class="pix10bold">Drawn</span></td>
			<td width="50" align="center"><span class="pix10bold">Lost</span></td>
			<cfif HideGoals IS "No">  <!--- otherwise hide next 2 columns: Goals For, Goals Against --->
				<td width="50" align="center"><span class="pix10bold">For</span></td>
				<td width="50" align="center"><span class="pix10bold">Against</span></td>
			</cfif>

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
		
		<tr class="bg_highlight0" onmouseover="this.className='bg_highlight2';" onmouseout="this.className='bg_highlight0';" >
			<td align="LEFT" <cfif Highlight>class="bg_highlight"</cfif> >
				<a href="TeamHist.cfm?CI=#CIdentity#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#" >
				<span class="pix13">#ClubName# #OrdinalName#</span><!--- Team --->
				</a>
			</td>
			<td align="center" <cfif Highlight>class="bg_highlight"</cfif>><span class="pix13">#CountHomeGamesPlayed + CountHomeGamesResultAwarded#</span></td>
			<td align="center" <cfif Highlight>class="bg_highlight"</cfif>><span class="pix13">#CountHomeWins + CountHomeWinResultAwarded#</span></td>
			<td align="center" <cfif Highlight>class="bg_highlight"</cfif>><span class="pix13">#CountHomeDraws + CountHomeDrawResultAwarded#</span></td>
			<td align="center" <cfif Highlight>class="bg_highlight"</cfif>><span class="pix13">#CountHomeDefeats + CountHomeDefeatResultAwarded#</span></td>
			<cfif HideGoals IS "No">  <!--- otherwise hide next 2 columns: Goals For, Goals Against --->
				<td align="center" <cfif Highlight>class="bg_highlight"</cfif>><span class="pix13">#IIF(SumHomeGoalsFor IS "",0,SumHomeGoalsFor)#</span></td>
			<td align="center" <cfif Highlight>class="bg_highlight"</cfif>><span class="pix13">#IIF(SumAwayGoalsAgainst IS "",0,SumAwayGoalsAgainst)#</span></td>
			
			</cfif>
			<cfif LeagueTblCalcMethod IS "Two Points for a Win" >
				<cfset HomePoints = ((CountHomeWins+CountHomeWinResultAwarded)*2) + CountHomeDraws + CountHomeDrawResultAwarded >
			<cfelse>
				<cfset HomePoints = ((CountHomeWins+CountHomeWinResultAwarded)*3) + CountHomeDraws + CountHomeDrawResultAwarded >
			</cfif>
			<td align="center" <cfif Highlight>class="bg_highlight"</cfif>><span class="pix13">#HomePoints#</span><cfif IsNumeric(SumHomePointsAdjust) AND SumHomePointsAdjust IS NOT 0><span class="pix13">[#NumberFormat(SumHomePointsAdjust, "L+999")#]</cfif></span></td>
			
			
			
			<td align="center" <cfif Highlight>class="bg_highlight"</cfif>><span class="pix13">#CountAwayGamesPlayed + CountAwayGamesResultAwarded#</span></td>
			<td align="center" <cfif Highlight>class="bg_highlight"</cfif>><span class="pix13">#CountAwayWins + CountAwayWinResultAwarded#</span></td>
			<td align="center" <cfif Highlight>class="bg_highlight"</cfif>><span class="pix13">#CountAwayDraws + CountAwayDrawResultAwarded#</span></td>
			<td align="center" <cfif Highlight>class="bg_highlight"</cfif>><span class="pix13">#CountAwayDefeats + CountAwayDefeatResultAwarded#</span></td>
			<cfif HideGoals IS "No">  <!--- otherwise hide next 2 columns: Goals For, Goals Against --->
				<td align="center" <cfif Highlight>class="bg_highlight"</cfif>><span class="pix13">#IIF(SumAwayGoalsFor IS "",0,SumAwayGoalsFor)#</span></td>
			<td align="center" <cfif Highlight>class="bg_highlight"</cfif>><span class="pix13">#IIF(SumHomeGoalsAgainst IS "",0,SumHomeGoalsAgainst)#</span></td>
			
			</cfif>
			<cfif LeagueTblCalcMethod IS "Two Points for a Win" >
				<cfset AwayPoints = ((CountAwayWins+CountAwayWinResultAwarded)*2) + CountAwayDraws + CountAwayDrawResultAwarded >
			<cfelse>
				<cfset AwayPoints = ((CountAwayWins+CountAwayWinResultAwarded)*3) + CountAwayDraws + CountAwayDrawResultAwarded >
			</cfif>
			<td align="center" <cfif Highlight>class="bg_highlight"</cfif>><span class="pix13">#AwayPoints#</span><cfif IsNumeric(SumAwayPointsAdjust) AND SumAwayPointsAdjust IS NOT 0><span class="pix13">[#NumberFormat(SumAwayPointsAdjust, "L+999")#]</cfif></span></td>			
		</tr>		
	</cfoutput>
</table>
