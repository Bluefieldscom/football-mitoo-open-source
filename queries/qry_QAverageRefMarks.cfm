<!--- called by AverageRefMarks.cfm --->


<cfquery name="QAverageRefMarks" dbtype="query">
	SELECT
		HTID as TID,
		HOID as OID,
		SumRefereeMarksH as HMarks,
		SumRefereeMarksA as AMarks,
		QAveRefMarksH.TeamName as TName,
		QAveRefMarksH.OrdinalName as OName,
		HGames,
		AGames,
		(SumRefereeMarksH+SumRefereeMarksA)/(HGames+AGames) as SortOrder
	FROM
		QAveRefMarksA,
		QAveRefMarksH
	WHERE
		HTID = ATID AND
		HOID = AOID
	ORDER BY
		SortOrder
</cfquery>
