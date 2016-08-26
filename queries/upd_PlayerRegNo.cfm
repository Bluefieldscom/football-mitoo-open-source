<!--- called by PlayersHist.cfm --->

<CFQUERY NAME="UpdtPlayerRegNo" datasource="#request.DSN#">
	UPDATE
		player
	SET
		ShortCol = #NewRegNo#
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = <cfqueryparam value = #PlayerID#	cfsqltype="CF_SQL_INTEGER" maxlength="8">
</CFQUERY>