<cfquery name="GetPitchAvailableID" datasource="#request.DSN#">
	SELECT
		ID as PA_ID
	FROM
		pitchavailable as PitchAvailable
	WHERE
		TeamID = <cfqueryparam value = #form.TeamID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND OrdinalID = <cfqueryparam value = #form.OrdinalID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND VenueID = <cfqueryparam value = #form.VenueID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND PitchNoID = <cfqueryparam value = #form.PitchNoID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND PitchStatusID = <cfqueryparam value = #form.PitchStatusID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND BookingDate = '#ThisDate#'
		AND LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
</cfquery>
