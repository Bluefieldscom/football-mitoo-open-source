<cfquery name="QNewFixtures" dbtype="query">
	SELECT 
		HomeID, AwayID, FixtureDate, KORoundID, RefereeID, AsstRef1ID, AsstRef2ID, FourthOfficialID, AssessorID, Fixturenotes, LeagueCode, MatchNumber, PitchAvailableID
	FROM
		request.NewFixtures
</cfquery>
