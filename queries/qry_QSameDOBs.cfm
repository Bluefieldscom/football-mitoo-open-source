<!--- called by InclLookUpPlayer.cfm --->
<cfquery name="QSameDOBs" datasource="#request.DSN#" >
SELECT
	id,
	surname,
	forename,
	mediumcol,
	shortcol
FROM
	player
WHERE
	leaguecode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND mediumcol='#DateFormat(GetTblName.mediumcol, "YYYY-MM-DD")#'
ORDER BY
	surname, forename, mediumcol
</cfquery>
