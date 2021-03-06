<!---  called by inclCreateNewLeagueTableRows.cfm  --->
<cfquery name="InsLeagueTable" datasource="#request.DSN#">
	INSERT INTO
		leaguetable 
		(
		DivisionID,
		Rank,
		Name,
		ConstitutionID,
		TeamID,
		PointsAdjustment,
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
		)
	VALUES
		(
		#ThisDivisionID#,
		#Rank#,
		'#Name#',
		#ConstitutionID#,
		#TeamID#,
		#PointsAdjustment#,
		#HomeGamesPlayed#,
		#HomeGamesWon#,
		#HomeGamesDrawn#,
		#HomeGamesLost#,
		#HomeGoalsFor#,
		#HomeGoalsAgainst#,
		#HomePoints#,
		#HomePointsAdjust#,
		#AwayGamesPlayed#,
		#AwayGamesWon#,
		#AwayGamesDrawn#,
		#AwayGamesLost#,
		#AwayGoalsFor#, 
		#AwayGoalsAgainst#,
		#AwayPoints#,
		#AwayPointsAdjust#
		)
</cfquery>
