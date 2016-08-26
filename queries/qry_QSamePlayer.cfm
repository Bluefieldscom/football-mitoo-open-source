<!--- Called by LUList.cfm --->

<!--- check for duplicate player names --->

<cfquery name="QSamePlayer" datasource="#request.DSN#" >
	SELECT
		surname, forename
	FROM
		player
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID NOT IN (SELECT ID FROM player WHERE LeagueCode = LeagueCode AND NOTES LIKE '%p=p%')
	GROUP BY
		surname, forename
	HAVING
		COUNT(*) >= 2 
</cfquery>
