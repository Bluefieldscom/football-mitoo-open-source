<!--- called by InclLookUpPlayer.cfm --->
<cfquery name="QSimilarSurnames" datasource="#request.DSN#" >
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
	AND surname LIKE '#Left(GetTblName.Surname,4)#%'
ORDER BY
	surname, forename, mediumcol
</cfquery>
