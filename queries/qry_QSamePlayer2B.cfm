<!--- Called by LUList.cfm --->

<!--- find  duplicates of player surname and date of birth --->

<cfquery name="QSamePlayer2B" datasource="#request.DSN#" >
	SELECT
		surname,
		mediumcol
	FROM
		player
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID NOT IN (SELECT ID FROM player WHERE LeagueCode = LeagueCode AND mediumcol IS NULL)
		AND ID NOT IN (#IgnorePIDList#)
	GROUP BY
		surname, mediumcol
	HAVING
		COUNT(*) >= 2 
</cfquery>
