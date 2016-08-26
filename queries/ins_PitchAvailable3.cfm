<!--- called by MtchDay.cfm --->

<cfquery name="InsertPA" datasource="#request.DSN#">
	INSERT INTO pitchavailable
		(TeamID, 
		OrdinalID, 
		VenueID, 
		PitchNoID, 
		PitchStatusID, 
		BookingDate, 
		LeagueCode)
	VALUES
		(#QDefaultVenue1.ThisTeamID#, 
		#QDefaultVenue1.ThisOrdinalID#, 
		#QDefaultVenue1.ThisVenueID#, 
		#QDefaultVenue1.ThisPitchNoID#, 
		1, 
		'#DateFormat(QDefaultVenue1.ThisBookingDate,"YYYY-MM-DD")#', 
		'#QDefaultVenue1.ThisLeagueCode#')
</cfquery>

