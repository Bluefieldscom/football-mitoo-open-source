<cfquery name="QInsertNewFixtures" datasource="#request.DSN#">
	INSERT INTO
		fixture
			(HomeID, 
			AwayID, 
			FixtureDate, 
			KORoundID, 
			RefereeID, 
			AsstRef1ID, 
			AsstRef2ID, 
			FourthOfficialID, 
			AssessorID, 
			Fixturenotes, 
			PrivateNotes,
			LeagueCode,
			MatchNumber, 
			PitchAvailableID)
	VALUES
		(#QNewFixtures.HomeID#, 
		#QNewFixtures.AwayID#, 
		'#QNewFixtures.FixtureDate#', 
		#QNewFixtures.KORoundID#, 
		#QNewFixtures.RefereeID#, 
		#QNewFixtures.AsstRef1ID#, 
		#QNewFixtures.AsstRef2ID#, 
		#QNewFixtures.FourthOfficialID#, 
		#QNewFixtures.AssessorID#, 
		'#QNewFixtures.Fixturenotes#', 
		'#QNewFixtures.PrivateNotes#', 
		'#QNewFixtures.LeagueCode#',
		#QNewFixtures.MatchNumber#,
		#QNewFixtures.PitchAvailableID#		)
</cfquery>
