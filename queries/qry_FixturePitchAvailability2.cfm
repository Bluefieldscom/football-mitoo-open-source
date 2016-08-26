<!--- called by InclFixturePitchAvailability.cfm --->

<!--- note the WHERE clause specifies five "keys" that must match
ID (from Fixture.PitchAvailableID)
LeagueCode
TeamID (Home)
OrdinalID (Home)
Date (Booking Date is the same as Fixture Date)
--->

<cfquery name="FixturePitchAvailability2" datasource="#request.DSN#">
	SELECT
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
		h.ID = #ThisID# <!--- ID (from Fixture.PitchAvailableID) --->
		AND h.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND h.TeamID = #ThisTeamID#
		AND h.OrdinalID = #ThisOrdinalID#
		AND h.BookingDate = #ThisBookingDate#
		AND h.VenueID = v.ID 
		AND h.PitchNoID = pn.ID
		AND h.PitchStatusID = ps.ID
</cfquery>


