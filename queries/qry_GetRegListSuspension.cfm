<!--- called from RegistListText.cfm --->

<CFQUERY NAME="QSuspens" datasource="#request.DSN#">
	SELECT
		FirstDay,
		LastDay,
		NumberOfMatches
	FROM
		suspension
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND FirstDay IS NOT NULL 
		AND LastDay IS NOT NULL 
		AND suspension.PlayerID = <cfqueryparam value = #RPID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
	ORDER BY
		FirstDay
</CFQUERY>

