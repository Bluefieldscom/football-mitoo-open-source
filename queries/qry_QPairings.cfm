<!--- called by LUList.cfm --->
<cfquery name="QPairings" datasource="#request.DSN#" >
	SELECT
		pdp1.PID as PID1,
		pdp2.PID as PID2
	FROM
	playerduplicatepairings pdp1,
	playerduplicatepairings pdp2
	WHERE
	pdp1.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND pdp2.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND pdp2.PID > pdp1.PID
	ORDER BY
	PID1, PID2
</cfquery>

