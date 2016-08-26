<!--- called by RefsRanking.cfm --->

<CFQUERY NAME="QRefsCounties" datasource="#request.DSN#">	
	SELECT DISTINCT ParentCounty as PCounty
	FROM
		referee
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#'	cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	ORDER BY
		PCounty
</CFQUERY>
