<!--- called by LeagueTab.cfm, LeagueTabExpand.cfm --->

<cfquery name="QNewLeagueTable" datasource="#request.DSN#">
	SELECT
		ConstitutionID,
		TeamID,
		PointsAdjustment,
		Name,
		Special,
		HomeGamesPlayed,
		HomeGamesWon,
		HomeGamesDrawn,
		HomeGamesLost,
		HomeGoalsFor,
		HomeGoalsAgainst,
		HomePoints,
		HomePointsAdjust,
		AwayGamesPlayed,
		AwayGamesWon,
		AwayGamesDrawn,
		AwayGamesLost,
		AwayGoalsFor,
		AwayGoalsAgainst,
		AwayPoints,
		AwayPointsAdjust
	FROM
		leaguetable
	WHERE
		DivisionID = #ThisDivisionID#
	ORDER BY
		Rank
</cfquery>
