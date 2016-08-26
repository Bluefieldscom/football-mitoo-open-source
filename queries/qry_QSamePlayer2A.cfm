<!--- Called by LUList.cfm --->
<!--- find  duplicates of player forename and date of birth --->
<cfquery name="QSamePlayer2A" datasource="#request.DSN#" >
	SELECT
		forename,
		mediumcol
	FROM
		player
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID NOT IN (SELECT ID FROM player WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> AND mediumcol IS NULL)
		AND	ID NOT IN (#IgnorePIDList#)
	GROUP BY
		forename, mediumcol
	HAVING
		COUNT(*) >= 2 
</cfquery>
