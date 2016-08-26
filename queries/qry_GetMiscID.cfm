<!--- called from TransferTeamToMisc.cfm --->

<CFQUERY NAME="GetMiscID" datasource="#request.DSN#">
	SELECT
		ID, longcol, mediumcol, shortcol, notes, LeagueCode
	FROM
		division as Division
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
			cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND LongCol = 'Miscellaneous'
</CFQUERY>
