<!--- called by LUList.cfm for Team output --->
<cfquery name="QTeamNormalVenue2" datasource="#request.DSN#">
	SELECT 
		v.LongCol as VenueName,
		v.AddressLine1,
		v.AddressLine2,
		v.AddressLine3,
		v.PostCode,
		v.VenueTel,
		o.LongCol as OrdinalName
	FROM
		teamdetails td, 
		venue v,
		ordinal o
	WHERE 
		td.LeagueCode =  <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND o.ID IN (SELECT OrdinalID FROM constitution WHERE TeamID=#TeamList.ID#)
		AND td.TeamID = #TeamList.ID#
		AND td.VenueID = v.ID
		AND td.OrdinalID = o.ID
</cfquery>
