<!--- called by PitchesToday.cfm --->
<cfquery name="QPitchesUsed" datasource="#request.DSN#">
	SELECT 
		v.id as VID,
		v.longcol as VenueName,
		p.longcol as PitchNumber,
		s.LongCol as PitchStatus,
		t1.LongCol as HomeTeam    ,
		o1.LongCol as HomeOrdinal ,
		t2.LongCol as AwayTeam    ,
		o2.LongCol as AwayOrdinal,
		f.PitchAvailableID AS PitchAvailableID
	FROM 	
		fixture f,
		pitchavailable h,
		venue v,
		pitchno p,
		pitchstatus s,
		team t1,
		team t2,
		ordinal o1,
		ordinal o2,
		constitution c1,
		constitution c2
	WHERE 
		f.leaguecode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND f.fixturedate='#ThisDate#'
		AND f.PitchAvailableID > 0
		AND f.pitchavailableID = h.ID
		AND h.VenueID = v.ID
		AND h.PitchnoID = p.id
		AND h.PitchStatusID = s.ID
		AND c1.ID = f.HomeID 
		AND c2.ID = f.AwayID 
		AND t1.id = c1.TeamID 
		AND o1.id = c1.OrdinalID 
		AND t2.id = c2.TeamID 
		AND o2.id = c2.OrdinalID
	ORDER BY 
		VenueName, PitchNumber;
</cfquery>