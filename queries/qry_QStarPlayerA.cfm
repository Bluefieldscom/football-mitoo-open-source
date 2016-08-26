<!--- called by InclGoalscorers.cfm --->

<CFQUERY NAME="QStarPlayerA" dbtype="query">
	SELECT 
		PlayerSurname,
		PlayerForename
	FROM
		QAwayStarPlayer
	WHERE
		<!--- FixtureID = <cfqueryparam value = #FID# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8"> --->
		FixtureID = #FID#
	ORDER BY
		PlayerSurname, PlayerForename
</cfquery>
