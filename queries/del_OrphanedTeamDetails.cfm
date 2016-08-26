<!--- called by inclShowJABOnly.cfm --->
<cfquery name="DelOrphanedTeamDetails" datasource="#request.DSN#">
	DELETE FROM teamdetails WHERE teamid NOT IN (SELECT id FROM team)
</cfquery>
