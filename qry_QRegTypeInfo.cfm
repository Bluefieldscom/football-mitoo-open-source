<!--- Called by RegisteredPlayers.cfm --->

<cfquery name="QRegTypeInfo" datasource="#request.DSN#" >
SELECT
	t.longcol as clubname,
	p.shortcol as regno,
	p.surname,
	p.forename,
	firstday,
	lastday 
FROM 
	 register r, 
	 team t, 
	 player p 
WHERE
	r.leaguecode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
	AND regtype=<cfqueryparam value = '#url.RegType#' cfsqltype="CF_SQL_VARCHAR" maxlength="1">
	AND r.teamID=t.id 
	AND r.playerID=p.ID 
ORDER BY 
	t.longcol, p.surname, p.forename
</cfquery>