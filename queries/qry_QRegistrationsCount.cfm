<!--- called by RegisteredPlayers.cfm --->

<cfquery name="QRegistrationsCount" datasource="#request.DSN#" >
	SELECT
		COUNT(*) as cnt
	FROM
		register
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND TeamID IS NOT NULL
</cfquery>
