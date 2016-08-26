<!--- called by inclShowJABOnly.cfm --->
<cfquery name="DelOrTypeTeam" datasource="#request.DSN#">
	DELETE FROM team 
	WHERE 
		team.longcol LIKE '% or %'
	AND
		team.ID NOT IN (SELECT teamid from constitution )
</cfquery>
