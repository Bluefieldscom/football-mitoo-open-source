<!--- called by ListChoose.cfm --->

<CFQUERY NAME="GetVInfo" dbtype="query">
	SELECT
		VenueID,
		VenueDescription
	FROM
		QVenue
	ORDER BY
		VenueSortOrder, VenueDescription
</CFQUERY>



