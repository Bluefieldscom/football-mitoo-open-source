<!--- called by LUList.cfm --->
<cfquery name="QSimilarName" datasource="#request.DSN#" >
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
		AND surname LIKE '#Left(PlayerList.Surname,4)#%'
	ORDER BY
		surname, forename, mediumcol
</cfquery>
