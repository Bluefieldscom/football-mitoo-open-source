<!--- called from SportsmanshipTable.cfm --->

<cfquery name="QSportsmanshipTable2" dbtype="query">
	SELECT
		TeamID,
		TeamName,
		OrdinalName,
		HMarkedGames+AMarkedGames as TotalMarkedGames,
		(HMarks+AMarks) / (HMarkedGames+AMarkedGames) as SportsmanshipMarks
	FROM
		QSportsmanshipTable1
	WHERE
		HMarks+AMarks > 0
	ORDER BY
		SportsmanshipMarks <cfif SortOrder is "HighAtTop">DESC</cfif>, TeamName, OrdinalName
</cfquery>

