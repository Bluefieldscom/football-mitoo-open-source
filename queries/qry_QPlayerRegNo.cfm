<!--- called by InclBatchUpdate1.cfm,RegisterPlayer.cfm --->

<CFQUERY NAME="QPlayerRegNo" datasource="#request.DSN#">
	SELECT
		ID, Surname, Forename
	FROM
		player
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ShortCol = #PlayerRegNo#
</CFQUERY>