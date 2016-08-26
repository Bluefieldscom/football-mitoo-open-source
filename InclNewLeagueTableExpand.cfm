<table width="80%" class="leagueTable" >
<!---																		****************************************************************
																			* This chunk of code produces the league table column headings *
																			****************************************************************
--->
		<tr>
			<td width="2%" rowspan="3" align="center" valign="top"><span class="pix10boldnavy"></span></td>
			<td rowspan="3" ><span class="pix13bold"><cfoutput>#QNewLeagueTable.RecordCount#</cfoutput> Teams</span></td>
			<td align="center" <cfif HideGoals IS "Yes">colspan="6"<cfelse>colspan="8"</cfif>><span class="pix13bold">Home</span></td>
			<td <cfoutput>rowspan="#QNewLeagueTable.RecordCount+3#"</cfoutput>>&nbsp;</td>
			<td align="center" <cfif HideGoals IS "Yes">colspan="6"<cfelse>colspan="8"</cfif>><span class="pix13bold">Away</span></td>
		</tr>	
		<tr>
			<td align="center" colspan="4"><span class="pix10bold">Games</span></td>
			<cfif HideGoals IS "No">  
				<td colspan="2" align="center" ><span class="pix10bold">Goals</span></td>
			</cfif>
			<td width="4%" rowspan="2" align="center" valign="top"><span class="pix10bold">Points</span></td>
			<td width="2%" rowspan="2" align="center" valign="top"><span class="pix10boldnavy">Adj</span></td>
			<td align="center" colspan="4"><span class="pix10bold">Games</span></td>
			<cfif HideGoals IS "No">  
				<td colspan="2" align="center" ><span class="pix10bold">Goals</span></td>
			</cfif>
			<td width="4%" rowspan="2" align="center" valign="top"><span class="pix10bold">Points</span></td>
			<td width="2%" rowspan="2" align="center" valign="top"><span class="pix10boldnavy">Adj</span></td>
		</tr>	
		<tr>
			<!--- Home --->
			<td width="4%" align="center"><span class="pix10bold">P</span></td>
			<td width="4%" align="center"><span class="pix10bold">W</span></td>
			<td width="4%" align="center"><span class="pix10bold">D</span></td>
			<td width="4%" align="center"><span class="pix10bold">L</span></td>
			<cfif HideGoals IS "No">  <!--- otherwise hide next three columns: Goals For, Goals Against and  Goal Difference (or Average) --->
				<td width="4%" align="center" ><span class="pix10bold">F</span></td>
				<td width="4%" align="center" ><span class="pix10bold">A</span></td>
			</cfif>
			
			<!--- Away --->
			<td width="4%" align="center"><span class="pix10bold">P</span></td>
			<td width="4%" align="center"><span class="pix10bold">W</span></td>
			<td width="4%" align="center"><span class="pix10bold">D</span></td>
			<td width="4%" align="center"><span class="pix10bold">L</span></td>
			<cfif HideGoals IS "No">  <!--- otherwise hide next three columns: Goals For, Goals Against and  Goal Difference (or Average) --->
				<td width="4%" align="center" ><span class="pix10bold">F</span></td>
				<td width="4%" align="center" ><span class="pix10bold">A</span></td>
			</cfif>

		</tr>	
		
	<cfoutput query="QNewLeagueTable">
	<!--- 
																			******************************************************************************
																			* This chunk of code produces the league table rows split into Home and Away *
																			******************************************************************************
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
			<td align="center" width="2%"  bgcolor="#BGColorSpec#"><span class="pix10boldnavy"><cfif PointsAdjustment IS 0><cfelse> #NumberFormat(PointsAdjustment, "L+999")#</cfif></span></td>
			<td align="LEFT" bgcolor="#BGColorSpec#" ><a href="TeamHist.cfm?CI=#ConstitutionID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#" ><span class="pix13realblack">#Name#</span></a></td>
			<td align="center" width="4%" bgcolor="#BGColorSpec#"><span class="pix13realblack">#HomeGamesPlayed#</span></td>
			<td align="center" width="4%" bgcolor="#BGColorSpec#"><span class="pix13realblack">#HomeGamesWon#</span></td>
			<td align="center" width="4%"  bgcolor="#BGColorSpec#"><span class="pix13realblack">#HomeGamesDrawn#</span></td>
			<td align="center" width="4%"  bgcolor="#BGColorSpec#"><span class="pix13realblack">#HomeGamesLost#</span></td>
			<cfif HideGoals IS "No">  <!--- otherwise hide next two columns: Goals For, Goals Against --->
				<td width="4%" align="center" bgcolor="#BGColorSpec#"><span class="pix13realblack">#HomeGoalsFor#</span></td>
				<td width="4%" align="center" bgcolor="#BGColorSpec#"><span class="pix13realblack">#HomeGoalsAgainst#</span></td>
			</cfif>
			<td align="center" width="4%"  bgcolor="#BGColorSpec#"><span class="pix13realblack">#HomePoints#</span></td>
			<td align="center" width="2%"  bgcolor="#BGColorSpec#"><span class="pix10boldnavy"><cfif HomePointsAdjust IS 0>&nbsp;<cfelse>#NumberFormat(HomePointsAdjust, "L+999")#</cfif></span></td>
			<td align="center" width="4%"  bgcolor="#BGColorSpec#"><span class="pix13realblack">#AwayGamesPlayed#</span></td>
			<td align="center" width="4%"  bgcolor="#BGColorSpec#"><span class="pix13realblack">#AwayGamesWon#</span></td>
			<td align="center" width="4%"  bgcolor="#BGColorSpec#"><span class="pix13realblack">#AwayGamesDrawn#</span></td>
			<td align="center" width="4%"  bgcolor="#BGColorSpec#"><span class="pix13realblack">#AwayGamesLost#</span></td>
			<cfif HideGoals IS "No">  <!--- otherwise hide next two columns: Goals For, Goals Against --->
				<td width="4%" align="center" bgcolor="#BGColorSpec#"><span class="pix13realblack">#AwayGoalsFor#</span></td>
				<td width="4%" align="center" bgcolor="#BGColorSpec#"><span class="pix13realblack">#AwayGoalsAgainst#</span></td>
			</cfif>
			<td align="center" width="4%"  bgcolor="#BGColorSpec#"><span class="pix13realblack">#AwayPoints#</span></td>
			<td align="center" width="2%"  bgcolor="#BGColorSpec#"><span class="pix10boldnavy"><cfif AwayPointsAdjust IS 0>&nbsp;<cfelse>#NumberFormat(AwayPointsAdjust, "L+999")#</cfif></span></td>
		</tr>		
	</cfoutput>
</table>
