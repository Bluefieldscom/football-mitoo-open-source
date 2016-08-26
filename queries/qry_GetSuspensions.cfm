<!--- called by RefreshLeagueTable.cfm --->

<CFQUERY NAME="QGetSuspensions" datasource="#request.DSN#">
	SELECT
		SUM(NumberOfMatches) as MBCount
	FROM
		suspension
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
</CFQUERY>
