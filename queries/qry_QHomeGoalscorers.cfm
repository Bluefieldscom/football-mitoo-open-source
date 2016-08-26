<!--- Called by MissingGoalscorers.cfm --->

<cfquery name="QHomeGoalscorers" datasource="#request.DSN#" >
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
		FID, HomeGoals <!--- f.ID, f.HomeGoals --->
	HAVING
		SumHomeGoalsScored <> HomeGoals <!--- NOT SUM(a.GoalsScored) = f.HomeGoals --->
</cfquery>
