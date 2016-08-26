<!--- called by BatchUpdate.cfm --->

<CFQUERY NAME="Q00002" datasource="#request.DSN#">
	SELECT LEFT(t.Notes,7) as AwayNoScore
	FROM
		team AS t,
		constitution AS c
	WHERE
		c.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND c.ID = <cfqueryparam value = #AwayID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND t.ID = c.TeamID
</CFQUERY>

