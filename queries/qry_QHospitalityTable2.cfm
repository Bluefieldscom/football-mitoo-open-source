<!--- called from HospitalityTable.cfm --->

<cfquery name="QHospitalityTable2" dbtype="query">
	SELECT
		TeamID,
		TeamName,
		OrdinalName,
		HMarkedGames as TotalMarkedGames,
		HMarks / HMarkedGames as HospitalityMarks
	FROM
		QHospitalityTable1
	WHERE
		HMarks > 0
	ORDER BY
		HospitalityMarks <cfif SortOrder is "HighAtTop">DESC</cfif>, TeamName, OrdinalName
</cfquery>

