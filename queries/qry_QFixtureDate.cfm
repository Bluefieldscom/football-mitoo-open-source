<!--- called by InclSchedule01.cfm, TeamList.cfm, StartingLineUpList.cfm --->

<cfquery name="QFixtureDate" datasource="#request.DSN#">
	SELECT
		t1.ShortCol as HomeGuest,
		t2.ShortCol as AwayGuest,
		t1.id as ThisTeamID, 
		o1.id as ThisOrdinalID,
		d.LongCol as CompetitionName,
		f.FixtureDate ,
		f.HomeID ,
		f.AwayID ,
		f.HomeGoals ,
		f.AwayGoals ,
		f.Result ,
		f.FixtureNotes ,
		f.PrivateNotes,
		f.HomeTeamNotes ,
		f.AwayTeamNotes ,
		f.RefereeMarksH,
		f.RefereeID,
		f.RefereeMarksA,
		f.AsstRef1Marks,
		f.AsstRef2Marks,
		f.HomePointsAdjust,
		f.AwayPointsAdjust,
		f.Attendance,
		f.HospitalityMarks,
		f.HomeSportsmanshipMarks,
		f.AwaySportsmanshipMarks,
		f.HomeClubOfficialsBenches,
		f.AwayClubOfficialsBenches,
		f.StateOfPitch,
		f.ClubFacilities,
		f.Hospitality,
		f.PitchAvailableID,
		f.MatchNumber,
		<!--- applies to season 2012 onwards only --->
			<cfif RIGHT(request.dsn,4) GE 2012>
				f.RefereeReportReceived, f.HideMatchOfficials, f.RefMatchCardAnswers, f.RefMatchCardProblems,
			</cfif>
		CASE
		WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0
		THEN r.LongCol
		ELSE CONCAT(r.Surname, ", ", r.Forename)
		END
		as RefName ,
		CASE
		WHEN LENGTH(TRIM(r1.Forename)) = 0 AND LENGTH(TRIM(r1.Surname)) = 0
		THEN r1.LongCol
		ELSE CONCAT(r1.Surname, ", ", r1.Forename)
		END
		as AsstRef1Name ,
		CASE
		WHEN LENGTH(TRIM(r2.Forename)) = 0 AND LENGTH(TRIM(r2.Surname)) = 0
		THEN r2.LongCol
		ELSE CONCAT(r2.Surname, ", ", r2.Forename)
		END
		as AsstRef2Name ,
		CASE
		WHEN LENGTH(TRIM(r3.Forename)) = 0 AND LENGTH(TRIM(r3.Surname)) = 0
		THEN r3.LongCol
		ELSE CONCAT(r3.Surname, ", ", r3.Forename)
		END
		as FourthOfficialName ,
		CASE
		WHEN LENGTH(TRIM(r4.Forename)) = 0 AND LENGTH(TRIM(r4.Surname)) = 0
		THEN r4.LongCol
		ELSE CONCAT(r4.Surname, ", ", r4.Forename)
		END
		as AssessorName ,
		k.LongCol as RoundName ,
		t1.LongCol as HomeTeam    ,
		o1.LongCol as HomeOrdinal ,
		t2.LongCol as AwayTeam    ,
		o2.LongCol as AwayOrdinal ,
		LEFT(t1.Notes,7) as HomeNoScore ,
		LEFT(t2.Notes,7) as AwayNoScore ,
		f.AsstRef1MarksH,
		f.AsstRef1MarksA,
		f.AsstRef2MarksH,
		f.AsstRef2MarksA,
		f.AssessmentMarks,
		f.MatchOfficialsExpenses,
		f.HomeTeamSheetOK,
		f.AwayTeamSheetOK,
		c1.DivisionID as CurrentDivisionID,
		f.KOTime,
		(SELECT COUNT(*) FROM appearance WHERE FixtureID = f.ID) as AppearanceCount
	FROM
		fixture AS f,
		division AS d,
		referee AS r,
		referee AS r1,
		referee AS r2,
		referee AS r3,
		referee AS r4,
		koround AS k,
		constitution AS c1,
		team AS t1,
		ordinal AS o1,
		constitution AS c2 ,
		team AS t2,
		ordinal AS o2
	WHERE
		c1.LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype = "CF_SQL_VARCHAR" maxlength = "5">
		AND c2.LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype = "CF_SQL_VARCHAR" maxlength = "5">					
		AND f.ID = <cfqueryparam value = #FID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND c1.ID = f.HomeID 
		AND c2.ID = f.AwayID 
		AND r.ID = f.RefereeID	
		AND r1.ID = f.AsstRef1ID
		AND r2.ID = f.AsstRef2ID
		AND r3.ID = f.FourthOfficialID
		AND r4.ID = f.AssessorID
		AND k.ID = f.KORoundID
		AND t1.id = c1.TeamID 
		AND o1.id = c1.OrdinalID 
		AND t2.id = c2.TeamID 
		AND o2.id = c2.OrdinalID
		AND d.id = c1.DivisionID
</cfquery>

