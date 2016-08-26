<!--- Called by LUList.cfm --->

<!--- check for duplicate combinations of player surname, forename and date of birth --->
	

<cfquery name="QSamePlayer3" datasource="#request.DSN#" >
	SELECT
		surname, 
		forename, 
		mediumcol
	FROM
		player
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	GROUP BY
		surname, forename, mediumcol
	HAVING
		COUNT(*) >= 2 
</cfquery>
