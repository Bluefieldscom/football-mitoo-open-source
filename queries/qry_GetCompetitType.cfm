<!--- called by InclSchedule01.cfm --->

<cfquery name="GetCompetitType" dbtype="query">
	SELECT
		CompetitionNotes as Notes
	FROM
		QCompetition
	WHERE
		CompetitionID = #DivisionID#
</cfquery>
