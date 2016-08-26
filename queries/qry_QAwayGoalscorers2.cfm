<!--- Called by MissingGoalscorers.cfm --->

<cfquery name="QAwayGoalscorers2" datasource="#request.DSN#" >
	SELECT 
		DISTINCT f.ID as FID,
		f.AwayGoals as AwayGoals,
		COALESCE(SUM(a.GoalsScored),0) as SumAwayGoalsScored
	FROM
		fixture AS f,
		appearance AS a
	WHERE
		f.LeagueCode = <cfqueryparam value = '#request.filter#' 
			cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND f.ID NOT IN (#ResultHAList#) 
		AND a.HomeAway = 'A' 
		AND a.FixtureID = f.ID 
	GROUP BY
		FID, AwayGoals
	HAVING
		SumAwayGoalsScored > AwayGoals
</cfquery>
