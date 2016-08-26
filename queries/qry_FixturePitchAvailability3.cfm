<!--- called by InclFixturePitchAvailability.cfm --->

<!--- note the WHERE clause specifies only four "keys" that must match
LeagueCode
TeamID (Home)
OrdinalID (Home)
Date (Booking Date is the same as Fixture Date)
--->

<cfquery name="FixturePitchAvailability3" datasource="#request.DSN#">
	SELECT
		h.ID ,
		v.LongCol as VenueName ,
		v.MapURL,
		pn.LongCol as PitchName ,
		ps.LongCol as PitchStatus
	FROM
		pitchavailable AS h,
		venue AS v,
		pitchno AS pn,
		pitchstatus AS ps
	WHERE
		h.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND h.TeamID = #ThisTeamID#
		AND h.OrdinalID = #ThisOrdinalID#
		AND h.BookingDate = #ThisBookingDate#
		AND h.VenueID = v.ID 
		AND h.PitchNoID = pn.ID
		AND h.PitchStatusID = ps.ID
</cfquery>


