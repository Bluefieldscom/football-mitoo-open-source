<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel)>
	<cfif Find( "HideDivision", QKnockOut.Notes ) OR Find( "SuppressTable", QKnockOut.Notes ) OR QKnockOut.CompetitionDescription IS "Miscellaneous" OR QKnockOut.CompetitionDescription IS "Friendly" >
		<span class="pix18boldred">Spreadsheet Suppressed</span><cfabort>
	</cfif>
</cfif>
<cfinclude template="queries/qry_ExpandedLeagueTable.cfm">
<cfinclude template="queries/qry_QGetPointsAdjust.cfm">

<cfsetting enablecfoutputonly="yes">
<CFCONTENT type="application/msexcel">
<cfheader name="Content-Disposition" value="filename=LeagueTable.xls">
<cfoutput>
<!--- HideGoals will suppress Goals For, Goals Against and Goal Difference columns --->
<cfif Find( "HideGoals", QKnockOut.Notes )>
	<cfset HideGoals = "Yes">
	<cfset ThisColSpan = 7 >
<cfelse>
	<cfset HideGoals = "No">
	<cfset ThisColSpan = 9 >
</cfif>

<table>

<tr> <td colspan="#ThisColSpan#" align="center">#SeasonName#</td></tr>
<tr> <td colspan="#ThisColSpan#" align="center">#LeagueName#</td></tr>

<tr> <td colspan="#ThisColSpan#" align="center">#ThisCompetitionDescription#</td></tr>
<tr> 
	<td> </td>
	<td> </td>
	<td align="right">P</td>
	<td align="right">W</td>
	<td align="right">D</td>
	<td align="right">L</td>
	<cfif HideGoals IS "Yes">
	<cfelse>
		<td align="right">F</td>
		<td align="right">A</td> 
	</cfif>
	<td align="right">Pts</td>
</tr>
</cfoutput>
<cfoutput query="ExpandedLeagueTable" >
<tr>
<td>#Rank#</td>
<td>#Name# <cfif PointsAdjustment IS NOT 0>[ #NumberFormat(PointsAdjustment,"+9")# points ]</cfif></td>
<td>#HomeGamesPlayed+AwayGamesPlayed#</td>
<td>#HomeGamesWon+AwayGamesWon#</td>
<td>#HomeGamesDrawn+AwayGamesDrawn#</td>
<td>#HomeGamesLost+AwayGamesLost#</td>
<cfif HideGoals IS "Yes">
<cfelse>
	<td>#HomeGoalsFor+AwayGoalsFor#</td>
	<td>#HomeGoalsAgainst+AwayGoalsAgainst#</td>
</cfif>
<td>#HomePoints+AwayPoints+HomePointsAdjust+AwayPointsAdjust+PointsAdjustment#</td>
</tr>
</cfoutput>
<cfoutput>
<tr bgcolor="White">
	<td height="20" colspan="#ThisColSpan#" align="LEFT"  >&nbsp;</td>
</tr>
</cfoutput>
<cfoutput query="QGetPointsAdjust">
	<tr bgcolor="White">
		<td colspan="#(ThisColSpan + 3)#" align="LEFT"  >
		<span class="pix10">
			#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#:
			<cfif HomePointsAdjust IS NOT 0>[#NumberFormat(HomePointsAdjust,"+9")# <cfif HomePointsAdjust IS 1 OR HomePointsAdjust IS -1>point<cfelse>points</cfif>]</cfif> #HomeTeamName# #HomeOrdinal# #HomeGoals# v #AwayGoals#
			#AwayTeamName# #AwayOrdinal# <cfif AwayPointsAdjust IS NOT 0>[#NumberFormat(AwayPointsAdjust,"+9")# <cfif AwayPointsAdjust IS 1 OR AwayPointsAdjust IS -1>point<cfelse>points</cfif>]</cfif>
			<cfif AwardedResult IS "H" >
				- Home Win was awarded
			<cfelseif AwardedResult IS "A" >
				- Away Win was awarded
			<cfelseif AwardedResult IS "D" >
				- Draw was awarded
			<cfelseif AwardedResult IS "W" >
				- Void
			<cfelse>
			</cfif>
		</span>
		</td>
	</tr>
</cfoutput>
</table>