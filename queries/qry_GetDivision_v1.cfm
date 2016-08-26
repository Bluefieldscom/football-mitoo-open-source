<!--- Called by Toolbar1.cfm --->

<CFQUERY NAME="GetDivision" dbtype="query">
	SELECT
		CompetitionID,
		CompetitionDescription,
		CompetitionSortOrder,
		CompetitionCode,
		CompetitionNotes
	FROM
		QCompetition
	ORDER BY
		CompetitionSortOrder
</CFQUERY>
