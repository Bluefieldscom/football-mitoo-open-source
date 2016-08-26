<!--- called by GatherTeamsUnderClub.cfm  --->
<cfquery name="QDistinctIgnoredToken" dbtype="query">
	SELECT DISTINCT IgnoredToken FROM qignoredtoken ORDER BY IgnoredToken
</cfquery>
