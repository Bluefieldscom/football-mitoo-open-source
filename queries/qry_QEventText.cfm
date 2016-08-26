<cfquery name="QEventText" datasource="#request.DSN#">
	SELECT 
		EventText
	FROM
		event 
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND EventDate = '#ThisDate#'
</cfquery>

