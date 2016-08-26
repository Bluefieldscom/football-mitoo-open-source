<!--- Called by TeamHist.cfm --->

<CFQUERY NAME="QTeam" datasource="#request.DSN#">
SELECT
	t.LongCol as Name,
	o.LongCol as Ord,
	c.TeamID,
	c.OrdinalID
FROM
	constitution AS c,
	team AS t,
	ordinal AS o
WHERE
	c.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
	AND c.ID = <cfqueryparam value = #CI# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
	AND t.ID = c.TeamID 
	AND o.ID = c.OrdinalID
</CFQUERY>
