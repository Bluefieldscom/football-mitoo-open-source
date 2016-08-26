<!--- called by InclAdjustNewLeagueTableRows.cfm --->

<cfquery name="QAdjustRows" datasource="#request.DSN#">
	SELECT 		
		ConstitutionID,
		TeamID,
		Name,
		Rank,
		HomeGamesPlayed + AwayGamesPlayed as GamesPlayed,
		HomePoints + AwayPoints + HomePointsAdjust + AwayPointsAdjust as Points,
		HomeGoalsFor + AwayGoalsFor as GoalsFor,
		HomeGoalsAgainst + AwayGoalsAgainst as GoalsAgainst
	FROM
		leaguetable 
	WHERE
		DivisionID = #ThisDivisionID# 
	ORDER BY
		Rank
</cfquery>
