<!--- called by InclUpdtPitchAvailable.cfm --->

<CFQUERY name="UpdtPitchAvailable" datasource="#request.DSN#">
	UPDATE
		pitchavailable
	SET
		PitchNoID = <cfqueryparam value = #PitchNoID# cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		PitchStatusID = <cfqueryparam value = #PitchStatusID# cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		VenueID = <cfqueryparam value = #VenueID# cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		TeamID = <cfqueryparam value = #TeamID# cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		OrdinalID = <cfqueryparam value = #OrdinalID# cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		BookingDate = '#BookingDate#'
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = <cfqueryparam value = #ID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>

