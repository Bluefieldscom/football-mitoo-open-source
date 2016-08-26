<!--- Called by MissingGoalscorers.cfm --->

<cfquery name="QNoHomeAppearance" datasource="#request.DSN#" >
	SELECT
		ID
	FROM
		fixture
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID NOT IN (#ResultHAList#) 
		AND ID NOT IN (#HomeAwayHList#) 
		AND HomeID NOT IN 
			(SELECT c.ID 
			FROM constitution AS c, 
				 team AS t 
			WHERE
				c.LeagueCode = <cfqueryparam value = '#request.filter#' 
								cfsqltype="CF_SQL_VARCHAR" maxlength="5">
				AND t.ShortCol = 'GUEST' 
				AND c.TeamID = t.ID) 
		AND FixtureDate < #BoundaryDate# 
		AND HomeGoals > 0
</cfquery>
