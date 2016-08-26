<!--- Called by MissingGoalscorers.cfm --->

<cfquery name="QHomeGoalscorers2" datasource="#request.DSN#" >
	SELECT 
		DISTINCT f.ID as FID,
		f.HomeGoals as HomeGoals,
		COALESCE(SUM(a.GoalsScored),0) as SumHomeGoalsScored
	FROM
		fixture AS f,
		appearance AS a
	WHERE
		f.LeagueCode = <cfqueryparam value = '#request.filter#' 
			cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND f.ID NOT IN (#ResultHAList#) 
		AND a.HomeAway = 'H' 
		AND a.FixtureID = f.ID
	GROUP BY
		FID, HomeGoals
	HAVING
		SumHomeGoalsScored > HomeGoals
</cfquery>
