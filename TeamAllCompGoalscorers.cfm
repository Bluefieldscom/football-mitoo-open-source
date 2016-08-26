<!--- called from TeamHistAll.cfm --->

<table align="center" border="0" cellpadding="5" cellspacing="5">
<tr>
<td valign="top">
<cfinclude template = "queries/qry_QGoalsScoredAllComp.cfm">
<cfif QGoalsScored.RecordCount IS 0>
	<cfoutput>
		<span class="pix10">Goalscorer information has not been recorded so there is no goalscorer table.</span>
	</cfoutput>
<cfelse>
	<cfset Maxx = QGoalsScored.RecordCount>
	<cfset PlayerIDList = ValueList(QGoalsScored.PlayerID)>
	<cfset PlayerSurnameList = ValueList(QGoalsScored.PlayerSurname)>
	<cfset PlayerForenameList = ValueList(QGoalsScored.PlayerForename)>
	<cfset GamesGamesStartedList = ValueList(QGoalsScored.GamesStarted)>
	<cfset GamesGamesSubPlayedList = ValueList(QGoalsScored.GamesSubPlayed)>
	<cfset GamesGamesSubNotPlayedList = ValueList(QGoalsScored.GamesSubNotPlayed)>
	<cfset GoalsList = ValueList(QGoalsScored.Goals)>
	<table border="1" cellspacing="1" cellpadding="3" align="CENTER">
	<cfoutput>
		<tr>
			<td rowspan="3" align="center"><span class="pix10bold">&nbsp;</span></td>
			<td rowspan="3" align="left"><span class="pix10bold">Goalscorers<br>All Competitions<BR>#QTeam.Name# #QTeam.Ord#</span></td>
			<td colspan="4" align="center"><span class="pix10bold">Games</span></td>
			<td rowspan="3" align="center"><span class="pix10bold">Goals</span></td>
		</tr>
		<tr>
			<td rowspan="2" align="center"><span class="pix10bold">Played</span></td>
			<td rowspan="2" align="center"><span class="pix10bold">Started</span></td>
			<td colspan="2" align="center"><span class="pix10bold">Sub Used?</span></td>
		</tr>
		<tr>
			<td align="center"><span class="pix10bold">Yes</span></td>
			<td align="center"><span class="pix10bold">No</span></td>
		</tr>
		<cfloop index="x" from="1" to="#Maxx#" step="1" >
				<tr>
					<td><span class="pix10"><a href="PlayersHistory2.cfm?PI=#ListGetAt(PlayerIDList,x)#&LeagueCode=#LeagueCode#">See Appearances</a></span></td>
					<td><span class="pix10"><strong>#ListGetAt(PlayerSurnameList,x)#</strong> #Left(ListGetAt(PlayerForenameList,x), 1)#</span></td>
					<td align="CENTER"><span class="pix10">#ListGetAt(GamesGamesStartedList,x)+ListGetAt(GamesGamesSubPlayedList,x)#</span></td>
					<td align="CENTER"><span class="pix10"><cfif ListGetAt(GamesGamesStartedList,x) IS 0>&nbsp;<cfelse>#ListGetAt(GamesGamesStartedList,x)#</cfif></span></td>
					<td align="CENTER"><span class="pix10"><cfif ListGetAt(GamesGamesSubPlayedList,x) IS 0>&nbsp;<cfelse>#ListGetAt(GamesGamesSubPlayedList,x)#</cfif></span></td>
					<td align="CENTER"><span class="pix10"><cfif ListGetAt(GamesGamesSubNotPlayedList,x) IS 0>&nbsp;<cfelse>#ListGetAt(GamesGamesSubNotPlayedList,x)#</cfif></span></td>
					<td align="CENTER"><span class="pix10">#NumberFormat(ListGetAt(GoalsList,x), '999')#</span></td>
				</tr>
		</cfloop>
	</cfoutput>
	</table>
</cfif>
</td>
<td valign="top">
<cfif QNoGoalsScored.RecordCount IS 0>
<cfelse>
	<cfset Maxx = QNoGoalsScored.RecordCount>
	<cfset PlayerIDList = ValueList(QNoGoalsScored.PlayerID)>
	<cfset PlayerSurnameList = ValueList(QNoGoalsScored.PlayerSurname)>
	<cfset PlayerForenameList = ValueList(QNoGoalsScored.PlayerForename)>
	<cfset GamesGamesStartedList = ValueList(QNoGoalsScored.GamesStarted)>
	<cfset GamesGamesSubPlayedList = ValueList(QNoGoalsScored.GamesSubPlayed)>
	<cfset GamesGamesSubNotPlayedList = ValueList(QNoGoalsScored.GamesSubNotPlayed)>
	<table border="1" cellspacing="1" cellpadding="3" align="CENTER">
	<cfoutput>
		<tr>
			<td rowspan="3" align="center"><span class="pix10bold">&nbsp;</span></td>
			<td rowspan="3" align="left"><span class="pix10bold">Appearances<br>All Competitions<BR>#QTeam.Name# #QTeam.Ord#</span></td>
			<td colspan="4" align="center"><span class="pix10bold">Games</span></td>
		</tr>
		<tr>
			<td rowspan="2" align="center"><span class="pix10bold">Played</span></td>
			<td rowspan="2" align="center"><span class="pix10bold">Started</span></td>
			<td colspan="2" align="center"><span class="pix10bold">Sub Used?</span></td>
		</tr>
		<tr>
			<td align="center"><span class="pix10bold">Yes</span></td>
			<td align="center"><span class="pix10bold">No</span></td>
		</tr>
		<cfloop index="x" from="1" to="#Maxx#" step="1" >
				<tr>
					<td><span class="pix10"><a href="PlayersHistory2.cfm?PI=#ListGetAt(PlayerIDList,x)#&LeagueCode=#LeagueCode#">See Appearances</a></span></td>
					<td><span class="pix10"><strong>#ListGetAt(PlayerSurnameList,x)#</strong> #Left(ListGetAt(PlayerForenameList,x), 1)#</span></td>
					<td align="CENTER"><span class="pix10">#ListGetAt(GamesGamesStartedList,x)+ListGetAt(GamesGamesSubPlayedList,x)#</span></td>
					<td align="CENTER"><span class="pix10"><cfif ListGetAt(GamesGamesStartedList,x) IS 0>&nbsp;<cfelse>#ListGetAt(GamesGamesStartedList,x)#</cfif></span></td>
					<td align="CENTER"><span class="pix10"><cfif ListGetAt(GamesGamesSubPlayedList,x) IS 0>&nbsp;<cfelse>#ListGetAt(GamesGamesSubPlayedList,x)#</cfif></span></td>
					<td align="CENTER"><span class="pix10"><cfif ListGetAt(GamesGamesSubNotPlayedList,x) IS 0>&nbsp;<cfelse>#ListGetAt(GamesGamesSubNotPlayedList,x)#</cfif></span></td>
				</tr>
		</cfloop>
	</cfoutput>
	</table>
</cfif>
</td>
</tr>
</table>