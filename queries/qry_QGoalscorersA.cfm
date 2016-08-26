<!--- called by InclGoalscorers.cfm --->

<CFQUERY NAME="QGoalscorersA" dbtype="query">
	SELECT 
		PlayerSurname,
		PlayerForename,
		GoalsScored
	FROM
		QAllAwayGoalScorers
	WHERE
		<!--- FixtureID = <cfqueryparam value = #FID# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8"> --->
		FixtureID = #FID#
	ORDER BY
		PlayerSurname, PlayerForename
</cfquery>
