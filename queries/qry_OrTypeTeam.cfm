<!--- called by inclShowJABOnly.cfm --->
<cfquery name="QOrTypeTeam" datasource="#request.DSN#">
	SELECT 
		team.leaguecode,
		team.longcol as TeamName
	FROM
		team 
	WHERE 
		team.longcol LIKE '% or %'
	AND
		team.ID NOT IN (SELECT teamid from constitution )
	ORDER BY
		team.leaguecode, TeamName
</cfquery>
