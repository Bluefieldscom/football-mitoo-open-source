<!--- called by inclShowJABOnly.cfm --->
<cfquery name="QOrphanedTeamDetails" datasource="#request.DSN#">
	SELECT id FROM teamdetails WHERE teamid NOT IN (SELECT id FROM team)
</cfquery>
