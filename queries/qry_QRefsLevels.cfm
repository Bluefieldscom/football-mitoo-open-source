<!--- called by RefsRanking.cfm --->

<CFQUERY NAME="QRefsLevels" datasource="#request.DSN#">	
	SELECT DISTINCT Level
	FROM
		referee
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#'	cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	ORDER BY
		Level
</CFQUERY>
