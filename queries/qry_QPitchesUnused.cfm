<!--- called by PitchesToday.cfm --->
<cfquery name="QPitchesUnused" datasource="#request.DSN#">
SELECT
	v.ID as VID,
	v.longcol as VenueName,
	p.longcol as PitchNumber,
	s.LongCol as PitchStatus,
	t.LongCol as HomeTeam    ,
	o.LongCol as HomeOrdinal
FROM
		pitchavailable h,
		venue v,
		pitchno p,
		pitchstatus s,
		team t,
		ordinal o
WHERE
	h.LeagueCode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND bookingdate='#ThisDate#'
	AND h.ID NOT IN (#PitchAvailableIDList#)
		AND h.VenueID = v.ID
		AND h.PitchnoID = p.id
		AND h.PitchStatusID = s.ID
		AND t.id = h.TeamID 
		AND o.id = h.OrdinalID 
	ORDER BY 
		VenueName, PitchNumber;
</cfquery>

<cfset UnusedVIDList = ValueList(QPitchesUnused.VID)>
<cfif UnusedVIDList IS "">
	<cfset UnusedVIDList = ListAppend(UnusedVIDList, 0)>
</cfif>