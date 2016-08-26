<!--- called by inclCreateNewLeagueTableRows.cfm --->
<cfquery name="QLeagueTableRows" dbtype="query" >
	SELECT
		DivisionID,
		#PointsForWin# as PointsForWin,
		#PointsForDraw# as PointsForDraw,
		#PointsForLoss# as PointsForLoss,
		CIdentity,
		TeamID,
		PointsAdjustment,
		CompetitionName,
		ClubName,
		OrdinalName,
		OrdinalID,

		SumHomeGoalsFor,
		SumAwayGoalsFor,
		SumHomeGoalsAgainst,
		SumAwayGoalsAgainst,
		
		CountHomeWinNormal,
		CountAwayWinNormal,
		CountHomeDrawNormal,
		CountAwayDrawNormal,				
		CountHomeDefeatNormal,
		CountAwayDefeatNormal,
		
		CountHomeWinResultAwarded,
		CountAwayWinResultAwarded,
		CountHomeDrawResultAwarded,
		CountAwayDrawResultAwarded,
		CountHomeDefeatResultAwarded,
		CountAwayDefeatResultAwarded,
		CountHomeWinOnPenalties,
		CountAwayWinOnPenalties,
		CountHomeDefeatOnPenalties,
		CountAwayDefeatOnPenalties,
		CountHomeVoid,
		CountAwayVoid,
		SumHomePointsAdjust,
		SumAwayPointsAdjust,

		((CountHomeWinNormal+CountHomeWinResultAwarded+CountHomeWinOnPenalties+CountAwayWinNormal+CountAwayWinResultAwarded+CountAwayWinOnPenalties)*(#PointsForWin#))
		  + 
		((CountHomeDrawNormal+CountHomeDrawResultAwarded+CountAwayDrawNormal+CountAwayDrawResultAwarded)*(#PointsForDraw#))
		  + 
		((CountHomeDefeatNormal+CountHomeDefeatOnPenalties+CountAwayDefeatNormal+CountAwayDefeatOnPenalties)*(#PointsForLoss#))
		  +
		(SumHomePointsAdjust+SumAwayPointsAdjust+PointsAdjustment) as Points,

		(SumHomeGoalsFor+SumAwayGoalsFor)-(SumHomeGoalsAgainst+SumAwayGoalsAgainst) as GoalDiff, 
		
		(SumHomeGoalsFor+SumAwayGoalsFor) as GoalsFor, 

		(SumHomeGoalsFor+SumAwayGoalsFor) / (SumHomeGoalsAgainst+SumAwayGoalsAgainst) as GoalAverage 
	FROM
		QLeagueTableComponents
	ORDER BY
		<CFSWITCH expression="#LeagueTblCalcMethod#">
			<CFCASE VALUE = "Goal Difference" >
					Points DESC, GoalDiff DESC, GoalsFor DESC, ClubName, OrdinalName
			</CFCASE>
			<CFCASE VALUE = "Goal Average" >		
					Points DESC,  GoalAverage DESC, ClubName, OrdinalName
			</CFCASE>
			<CFCASE VALUE = "No Method" >		
					Points DESC, ClubName, OrdinalName
			</CFCASE>
			<CFCASE VALUE = "Two Points for a Win" >
					Points DESC, GoalDiff DESC, GoalsFor DESC, ClubName, OrdinalName
			</CFCASE>
			<CFDEFAULTCASE>		
				<!--- Should never reach here! --->
				Reached default case in LeagueTab (1) - Aborting....
				<CFABORT>
			</CFDEFAULTCASE>
		</CFSWITCH>
</cfquery>
