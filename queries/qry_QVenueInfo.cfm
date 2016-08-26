<!--- called by PitchAvailableList.cfm --->

<CFQUERY NAME="QVenueInfo"  dbtype="query">
	SELECT
		DISTINCT VenueName, HVID
	FROM
		QPitchAvailable
	ORDER BY
		VenueName
</CFQUERY>


