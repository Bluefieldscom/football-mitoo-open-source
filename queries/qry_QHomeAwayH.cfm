<!--- Called by MissingGoalscorers.cfm --->

<cfquery name="QHomeAwayH" datasource="#request.DSN#" >
	SELECT DISTINCT 
		FixtureID 
	FROM 
		appearance 
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' 
			cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND HomeAway = 'H'
</cfquery>
