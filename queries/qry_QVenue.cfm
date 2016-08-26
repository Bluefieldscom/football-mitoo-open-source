<!--- Called by inclLeagueInfo.cfm --->

<CFQUERY NAME="QVenue" datasource="#request.DSN#">
	SELECT 
		ID         as VenueID,
		LongCol    as VenueDescription,
		ShortCol   as VenueSortOrder
	FROM
		venue
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
</CFQUERY>
