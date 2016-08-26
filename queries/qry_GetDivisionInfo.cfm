<!--- called by InclConstit01.cfm --->

<CFQUERY NAME="GetDivisionInfo" dbtype="query">
	SELECT
		CompetitionID,
		CompetitionDescription
	FROM
		QCompetition
	ORDER BY
		CompetitionSortOrder
</CFQUERY>

