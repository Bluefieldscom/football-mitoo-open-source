<!--- called by LeagueTabExpandXLS.cfm and LeagueTabXLS.cfm --->
<cfquery name="ExpandedLeagueTable" datasource="#request.DSN#">
	SELECT 
	Rank, Name, PointsAdjustment,
	HomeGamesPlayed, HomeGamesWon, HomeGamesDrawn, HomeGamesLost, HomeGoalsFor, HomeGoalsAgainst, HomePoints, HomePointsAdjust,
	AwayGamesPlayed, AwayGamesWon, AwayGamesDrawn, AwayGamesLost, AwayGoalsFor, AwayGoalsAgainst, AwayPoints, AwayPointsAdjust
	 FROM leaguetable
	 WHERE DivisionID = #DivisionID# ORDER BY Rank
</cfquery>
