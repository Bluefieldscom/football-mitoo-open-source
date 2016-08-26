<!--- Called by VenueInformation.cfm --->

<CFQUERY NAME="QThisVenue" datasource="#request.DSN#">
	SELECT 
		LongCol    as VenueDescription,
		Notes,
		AddressLine1,
		AddressLine2,
		AddressLine3,
		PostCode,
		VenueTel,
		MapURL,
		CompassPoint
	FROM
		venue
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = #url.ID#
</CFQUERY>
