<!--- called by PlayersBanned.cfm --->

<cfquery name="PlayersBanned" datasource="#request.DSN#" >
SELECT
	SUM(s.NumberOfMatches) as MatchCount, 
	p.surname, 
	p.forename,
	p.shortcol as RegNo,
	p.ID as PID
FROM 
	matchbanheader mbh, 
	suspension s,
	player p
WHERE
	mbh.leaguecode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND mbh.suspensionid=s.id
	AND s.playerid=p.id
GROUP BY p.id
HAVING MatchCount >= 5
ORDER BY MatchCount desc, surname, forename
</cfquery>