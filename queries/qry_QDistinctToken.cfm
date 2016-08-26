<!--- called by GatherTeamsUnderClub.cfm  --->
<cfquery name="QDistinctToken" dbtype="query">
	SELECT DISTINCT Token FROM qtoken ORDER BY Token
</cfquery>
