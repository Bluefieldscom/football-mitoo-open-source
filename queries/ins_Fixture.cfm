<!--- called by InclInsrtGroupOfFixtures.cfm --->

<cfquery datasource="#request.DSN#">
	INSERT INTO
		fixture
		( HomeID,	
		AwayID,	
		MatchNumber,
		FixtureDate,
		Result,
		RefereeID,
		AsstRef1ID,
		AsstRef2ID,
		FourthOfficialID,
		AssessorID,
		RefereeMarksH,
		RefereeMarksA,
		AsstRef1Marks,
		AsstRef2Marks,
		HomeSportsmanshipMarks,
		AwaySportsmanshipMarks,	
		KORoundID,
		FixtureNotes,
		PrivateNotes,
		LeagueCode,
		PitchAvailableID
		)
	VALUES
		( <cfqueryparam value = #HomeID# cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		<cfqueryparam value = #AwayID# cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		<cfif Find( "MatchNumbers", QDesired.Notes)>
			#QDesired.HomeMatchNumber#,
		<cfelse>
			0,
		</cfif>
		#CreateODBCDate(DesiredDate)#,
		<cfif OpType IS "Temporary">
			'T',
		<cfelse>
			NULL,
		</cfif>
		#RefereeID#,
		#AsstRef1ID#,
		#AsstRef2ID#,
		#FourthOfficialID#,
		#AssessorID#,
		NULL,
		NULL,
		NULL,
		NULL,
		NULL,
		NULL,
		#KORoundID#,
		NULL,
		NULL,
		<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">,
		#FixturePitchAvailabilityID#
		
		)
</cfquery>
