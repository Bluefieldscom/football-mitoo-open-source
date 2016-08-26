<!--- called by PitchAvailableList.cfm --->

<cfquery name="QPitchAvailable" datasource="#request.DSN#">
	SELECT
		v.LongCol as VenueName ,
		pn.LongCol as PitchName ,
		ps.LongCol as PitchStatus ,
		h.ID as HID ,
		h.TeamID as HTID ,
		h.OrdinalID as HOID ,
		h.VenueID as HVID ,
		h.PitchNoID as PNID ,
		h.PitchStatusID as PSID,
		h.BookingDate as BookingDate
	FROM
		pitchavailable AS h,
		venue AS v,
		pitchno AS pn,
		pitchstatus AS ps
	WHERE
		h.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND h.TeamID = <cfqueryparam value = #ThisTeamID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND h.OrdinalID = <cfqueryparam value = #ThisOrdinalID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND h.VenueID = v.ID 
		AND h.PitchNoID = pn.ID
		AND h.PitchStatusID = ps.ID
UNION
SELECT
		'*UNKNOWN*' as VenueName ,
		'-' as PitchName ,
		'-' as PitchStatus ,
		0 as HID ,
		#ThisTeamID# as HTID ,
		#ThisOrdinalID# as HOID ,
		0 as HVID ,
		0 as PNID ,
		0 as PSID,
		f.FixtureDate as BookingDate
	FROM
		fixture f, constitution c
	WHERE
		f.LeagueCode =  <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND f.PitchAvailableID = 0
		AND c.TeamID = <cfqueryparam value = #ThisTeamID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND c.OrdinalID = <cfqueryparam value = #ThisOrdinalID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND f.HomeID = c.ID
	ORDER BY
		BookingDate
</cfquery>


