<!--- called from Toolbar2.cfm --->

<cfquery name="GetVenueDescription" dbtype="query">
	SELECT 
		VenueDescription 
	FROM 
		QVenue 
	WHERE 
		VenueID = #ThisVenueID#
</cfquery>

