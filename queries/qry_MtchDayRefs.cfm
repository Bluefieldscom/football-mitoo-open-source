<!--- called by MtchDay.cfm --->

<CFQUERY NAME="MtchDayRefs" dbtype="query">
	SELECT
		role,
		Competition,
		KORoundName,
		HomeTeam,
		HomeOrdinal,
		AwayTeam,
		AwayOrdinal,
		RefsName
	FROM 
		refereesappointed as RefereesAppointed
	ORDER BY
		Refsort
</CFQUERY>