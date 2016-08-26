<!--- called by RegisteredPlayers.cfm --->

<cfquery name="QPlayersCount" datasource="#request.DSN#" >
	SELECT
		COUNT(*) as cnt
	FROM
		player
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND shortcol <> 0
</cfquery>
