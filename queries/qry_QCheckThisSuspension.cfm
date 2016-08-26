<!--- called by TeamList.cfm --->

<CFQUERY NAME="QCheckThisSuspension" datasource="#request.DSN#">
	SELECT
		ID,
		PlayerID,
		FirstDay, 
		LastDay,
		NumberOfMatches
	FROM
		suspension
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND PlayerID = <cfqueryparam value = #ThisPlayerID#	cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND FirstDay = '#ThisSDate#'
</CFQUERY>
