<!--- Called by inclLeagueInfo.cfm --->

<CFQUERY NAME="QVenueInformation" datasource="#request.DSN#">
	SELECT 
		LongCol as VenueDescription,
		AddressLine1,
		AddressLine2,
		AddressLine3,
		PostCode,
		VenueTel,
		MapURL
	FROM
		venue
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = #ThisVenueID#
</CFQUERY>
