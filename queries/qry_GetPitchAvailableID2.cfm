<cfquery name="GetPitchAvailableID2" datasource="#request.DSN#">
	SELECT
		ID as PA_ID
	FROM
		pitchavailable 
	WHERE
		TeamID = #ThisTeamID# 
		AND OrdinalID = #ThisOrdinalID# 
		AND VenueID = #ThisVenueID# 
		AND PitchNoID = #ThisPitchNoID# 
		AND PitchStatusID = #ThisPitchStatusID#  
		AND BookingDate = '#ThisBookingDate#' 
		AND LeagueCode = '#ThisLeagueCode#'
</cfquery>

