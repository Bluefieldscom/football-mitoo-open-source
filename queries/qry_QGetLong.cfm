<!--- called from Toolbar2.cfm --->

<cfquery name="GetLong" dbtype="query">
	SELECT 
		CompetitionDescription,
		CompetitionNotes
	FROM 
		QCompetition 
	WHERE 
		CompetitionID = <cfqueryparam value = #ThisCompetitionID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>