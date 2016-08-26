<!--- called by LeagueTabMonth.cfm --->

<cfquery name="QLeagueTableRows" dbtype="query" >
	SELECT
		PointsForWin,
		PointsForDraw,
		PointsForLoss,
		CIdentity,
		TeamID,
		OrdinalID,
		ClubName,
		OrdinalName,
		CountHomeGamesPlayed,
		CountAwayGamesPlayed,
		SumHomeGoalsFor,
		SumAwayGoalsFor,
		SumHomeGoalsAgainst,
		SumAwayGoalsAgainst,
		CountHomeWins,
		CountAwayWins,
		CountHomeDraws,
		CountAwayDraws,				
		CountHomeDefeats,
		CountAwayDefeats,
		((CountHomeWins+CountAwayWins)*PointsForWin) + ((CountHomeDraws+CountAwayDraws)*PointsForDraw) + ((CountHomeDefeats+CountAwayDefeats)*PointsForLoss) as Points,
		CountHomeGamesPlayed + CountAwayGamesPlayed as AveDenom,
		(((CountHomeWins+CountAwayWins)*PointsForWin) + ((CountHomeDraws+CountAwayDraws)*PointsForDraw) + ((CountHomeDefeats+CountAwayDefeats)*PointsForLoss)) /	(CountHomeGamesPlayed+CountAwayGamesPlayed ) as AvePoints,				
		(SumHomeGoalsFor+SumAwayGoalsFor)-(SumHomeGoalsAgainst+SumAwayGoalsAgainst) as GoalDiff,
		(SumHomeGoalsFor+SumAwayGoalsFor) as GoalsFor,
		(SumHomeGoalsAgainst+SumAwayGoalsAgainst) as GoalsAgainst,
		(SumHomeGoalsFor+SumAwayGoalsFor) / (SumHomeGoalsAgainst+SumAwayGoalsAgainst) as GoalAverage,
		CountHomeWins + CountAwayWins as GamesWon,
		CountHomeDraws + CountAwayDraws as GamesDrawn,
		CountHomeDefeats + CountAwayDefeats as GamesLost,
		CountHomeGamesPlayed + CountAwayGamesPlayed as GamesPlayed
	FROM
		QLeagueTableComponents
	ORDER BY
		<CFSWITCH expression="#LeagueTblCalcMethod#">
			<CFCASE VALUE = "Goal Difference" >
					AvePoints DESC, GoalDiff DESC, GoalsFor DESC, ClubName, OrdinalName
			</CFCASE>
			<CFCASE VALUE = "Goal Average" >		
					AvePoints DESC,  GoalAverage DESC, ClubName, OrdinalName
			</CFCASE>
			<CFCASE VALUE = "No Method" >		
					AvePoints DESC, ClubName, OrdinalName
			</CFCASE>
			<CFCASE VALUE = "Two Points for a Win" >
					AvePoints DESC, GoalDiff DESC, GoalsFor DESC, ClubName, OrdinalName
			</CFCASE>
			<CFDEFAULTCASE>		
				<CFABORT showError="No calculation method defined for league">
			</CFDEFAULTCASE>
		</CFSWITCH>
</cfquery>
