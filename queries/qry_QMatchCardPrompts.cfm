<!--- called by MatchCard.cfm --->

<CFQUERY NAME="QMatchCardPrompts" datasource="#request.DSN#">
	SELECT
		Notes
	FROM
		newsitem
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND LongCol = 'MatchCardPrompts'
</CFQUERY>


