<!--- called by PitchesToday.cfm --->
<cfquery name="QVenuesFree" datasource="#request.DSN#">
SELECT
	v.ID as FreeVID,
	v.longcol as VenueName
FROM
	venue v
WHERE
	v.LeagueCode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND v.ID NOT IN (#VIDList#)
	AND v.ID NOT IN (#UnusedVIDList#)
	ORDER BY 
		VenueName
</cfquery>
