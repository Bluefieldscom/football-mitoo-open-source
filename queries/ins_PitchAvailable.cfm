<!--- called by InclInsrtPitchAvailable.cfm --->

<cfquery name="InsertHG" datasource="#request.DSN#">
	INSERT INTO pitchavailable
		(TeamID, OrdinalID, VenueID, PitchNoID, PitchStatusID, BookingDate, LeagueCode)
	VALUES
		( <cfqueryparam value = #form.TeamID# cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		 <cfqueryparam value = #form.OrdinalID# cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		 <cfqueryparam value = #form.VenueID# cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		 <cfqueryparam value = #form.PitchNoID# cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		 <cfqueryparam value = #form.PitchStatusID# cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		 '#ThisDate#',
		 <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">)
</cfquery>


