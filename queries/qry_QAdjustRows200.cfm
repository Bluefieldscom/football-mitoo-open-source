<!--- called by InclAdjustNewLeagueTableRows.cfm --->

<cfquery name="QAdjustRows200" dbtype="query" >
	SELECT
		Rank,
		ConstitutionID,
		TeamName, 
		OrdinalName, 
		SumHomeGoalsFor+SumAwayGoalsFor as GoalsFor,
		SumHomeGoalsAgainst+SumAwayGoalsAgainst as GoalsAgainst,
		(SumHomeGoalsFor+SumAwayGoalsFor) - (SumHomeGoalsAgainst+SumAwayGoalsAgainst) as GoalDiff
	FROM
		QAdjustRows100
	ORDER BY
		GoalDiff DESC, GoalsFor DESC
</cfquery>
