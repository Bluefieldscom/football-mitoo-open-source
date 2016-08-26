<!--- called by CheckRule12SineDie.cfm --->
<cfquery Name="QSurnamesDobs"  datasource="#request.DSN#" >
	SELECT
		ID,
		surname,
		forename,
		mediumcol as DOB,
		shortcol as RegNo,
		notes
	FROM
		player
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND UPPER(surname) = '#ThisSurname#'
		AND mediumcol = '#ThisDOB#'
</cfquery>
