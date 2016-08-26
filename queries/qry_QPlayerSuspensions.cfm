<!--- called by PlayersHist.cfm --->

<CFQUERY NAME="QPlayerSuspensions" datasource="#request.DSN#">
	SELECT
		ID,
		FirstDay, 
		LastDay,
		NumberOfMatches
	FROM
		suspension
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND PlayerID = <cfqueryparam value = #PI# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
	ORDER BY
		FirstDay
</CFQUERY>
