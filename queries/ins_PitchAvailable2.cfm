<!--- called by UnschedAction.cfm --->

<cfquery name="InsertPA" datasource="#request.DSN#">
	INSERT INTO pitchavailable
		(TeamID, OrdinalID, VenueID, PitchNoID, PitchStatusID, BookingDate, LeagueCode)
	VALUES
		(#ThisTeamID#, #ThisOrdinalID#, #ThisVenueID#, #ThisPitchNoID#, #ThisPitchStatusID#, '#ThisBookingDate#', '#ThisLeagueCode#')
</cfquery>
