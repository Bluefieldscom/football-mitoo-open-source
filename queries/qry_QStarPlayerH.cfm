<!--- called by InclGoalscorers.cfm --->

<CFQUERY NAME="QStarPlayerH" dbtype="query">
	SELECT 
		PlayerSurname,
		PlayerForename
	FROM
		QHomeStarPlayer
	WHERE
		<!--- FixtureID = <cfqueryparam value = #FID# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8"> --->
		FixtureID = #FID#
	ORDER BY
		PlayerSurname, PlayerForename
</cfquery>
