<!--- called by InclSchedule01.cfm --->

<CFQUERY NAME="FixturePitchAvailability" datasource="#request.DSN#">
	SELECT
		h.id as FPA_ID,
		v.LongCol as VenueName ,
		pn.LongCol as PitchName ,
		ps.LongCol as PitchStatus
	FROM
		pitchavailable AS h,
		venue AS v,
		pitchno AS pn,
		pitchstatus AS ps
	WHERE
		h.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND h.TeamID = <cfqueryparam value = #ThisTeamID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND h.OrdinalID = <cfqueryparam value = #ThisOrdinalID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND h.BookingDate = '#ThisDate#'
		AND h.VenueID = v.ID 
		AND h.PitchNoID = pn.ID
		AND h.PitchStatusID = ps.ID
</CFQUERY>


