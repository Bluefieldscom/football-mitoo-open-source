<!--- called by ContributoryReport.cfm --->

<cfquery name="QName001" dbtype="query">
	SELECT
		TeamName,
		TotalMarks,
		NumberOfMarks,
		AveMarks,
		Verdict
	FROM
		QName
	ORDER BY
		AveMarks DESC, TeamName
</cfquery>
