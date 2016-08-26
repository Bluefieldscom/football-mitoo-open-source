<!--- Called by LUList.cfm --->

<CFQUERY NAME="VenueList" datasource="#request.DSN#">
	SELECT 
		ID,
		LongCol,
		MediumCol,
		ShortCol,
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
		AND LongCol IS NOT NULL 
	ORDER BY
		 ShortCol, LongCol
</CFQUERY>


