<!--- Called by MissingAppearances.cfm, MissingAppearances2.cfm, MissingGoalscorers.cfm --->
<cfquery name="QResultHA" datasource="#request.DSN#" >
	SELECT
		ID
	FROM
		fixture
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND (	(HomeGoals IS NULL AND AwayGoals IS NULL) OR FixtureNotes LIKE '%TEAM SHEET MISSING%'	)
	ORDER BY ID
</cfquery>
