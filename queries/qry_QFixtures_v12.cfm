<!--- Called by MtchDayOfficials.cfm --->

<CFQUERY NAME="QFixtures" datasource="#request.DSN#">
SELECT 
	t1.longcol as HomeTeam ,
	t2.longcol as AwayTeam ,
	t1.shortcol as HomeGuest ,
	t2.shortcol as AwayGuest ,
	t1.ID as HomeTeamID,
	t2.ID as AwayTeamID,
	o1.ID as HomeOrdinalID ,
	o2.ID as AwayOrdinalID ,
	o1.longcol as HomeOrdinal ,
	o2.longcol as AwayOrdinal ,
	r.ID as RefsID ,
	CASE
	WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0
	THEN r.LongCol
	ELSE CONCAT(r.Forename, " ", r.Surname)
	END
	as RefsFullName ,
	CASE
	WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0
	THEN r.LongCol
	ELSE CONCAT(LEFT(r.Forename,1), ". ", r.Surname)
	END
	as RefsName ,
	r.mediumcol as RefsNo ,
	CONCAT(
	CASE WHEN LENGTH(TRIM(r.HomeTel)) > 0 THEN CONCAT("H: ",r.HomeTel," ") ELSE "" END,
	CASE WHEN LENGTH(TRIM(r.WorkTel)) > 0 THEN CONCAT("W: ",r.WorkTel," ") ELSE "" END,
	CASE WHEN LENGTH(TRIM(r.MobileTel)) > 0 THEN CONCAT("M: ",r.MobileTel," ") ELSE "" END,
	CASE WHEN LENGTH(TRIM(r.Notes)) > 0 THEN CONCAT(r.Notes," ") ELSE "" END
	) 
	as RefsNotes,		
	r.EmailAddress1 as RefsEmail1,
	r.EmailAddress2 as RefsEmail2,
	r1.ID as AR1ID ,
	CASE
	WHEN LENGTH(TRIM(r1.Forename)) = 0 AND LENGTH(TRIM(r1.Surname)) = 0
	THEN r1.LongCol
	ELSE CONCAT(r1.Forename, " ", r1.Surname)
	END
	as AR1FullName ,
	CASE
	WHEN LENGTH(TRIM(r1.Forename)) = 0 AND LENGTH(TRIM(r1.Surname)) = 0
	THEN r1.LongCol
	ELSE CONCAT(LEFT(r1.Forename,1), ". ", r1.Surname)
	END
	as AR1Name ,
	r1.mediumcol as AR1No ,
	CONCAT(
	CASE WHEN LENGTH(TRIM(r1.HomeTel)) > 0 THEN CONCAT("H: ",r1.HomeTel," ") ELSE "" END,
	CASE WHEN LENGTH(TRIM(r1.WorkTel)) > 0 THEN CONCAT("W: ",r1.WorkTel," ") ELSE "" END,
	CASE WHEN LENGTH(TRIM(r1.MobileTel)) > 0 THEN CONCAT("M: ",r1.MobileTel," ") ELSE "" END,
	CASE WHEN LENGTH(TRIM(r1.Notes)) > 0 THEN CONCAT(r1.Notes," ") ELSE "" END
	) 
	as AR1Notes,		
	r1.EmailAddress1 as AR1Email1,
	r1.EmailAddress2 as AR1Email2,
	r2.ID as AR2ID ,
	CASE
	WHEN LENGTH(TRIM(r2.Forename)) = 0 AND LENGTH(TRIM(r2.Surname)) = 0
	THEN r2.LongCol
	ELSE CONCAT(r2.Forename, " ", r2.Surname)
	END
	as AR2FullName ,
	CASE
	WHEN LENGTH(TRIM(r2.Forename)) = 0 AND LENGTH(TRIM(r2.Surname)) = 0
	THEN r2.LongCol
	ELSE CONCAT(LEFT(r2.Forename,1), ". ", r2.Surname)
	END
	as AR2Name ,
	r2.mediumcol as AR2No ,
	CONCAT(
	CASE WHEN LENGTH(TRIM(r2.HomeTel)) > 0 THEN CONCAT("H: ",r2.HomeTel," ") ELSE "" END,
	CASE WHEN LENGTH(TRIM(r2.WorkTel)) > 0 THEN CONCAT("W: ",r2.WorkTel," ") ELSE "" END,
	CASE WHEN LENGTH(TRIM(r2.MobileTel)) > 0 THEN CONCAT("M: ",r2.MobileTel," ") ELSE "" END,
	CASE WHEN LENGTH(TRIM(r2.Notes)) > 0 THEN CONCAT(r2.Notes," ") ELSE "" END
	) 
	as AR2Notes,		
	r2.EmailAddress1 as AR2Email1,
	r2.EmailAddress2 as AR2Email2,
	r3.ID as FourthOfficialID ,
	CASE
	WHEN LENGTH(TRIM(r3.Forename)) = 0 AND LENGTH(TRIM(r3.Surname)) = 0
	THEN r3.LongCol
	ELSE CONCAT(r3.Forename, " ", r3.Surname)
	END
	as FourthOfficialFullName ,
	CASE
	WHEN LENGTH(TRIM(r3.Forename)) = 0 AND LENGTH(TRIM(r3.Surname)) = 0
	THEN r3.LongCol
	ELSE CONCAT(LEFT(r3.Forename,1), ". ", r3.Surname)
	END
	as FourthOfficialName ,
	r3.mediumcol as FourthOfficialNo ,
	CONCAT(
	CASE WHEN LENGTH(TRIM(r3.HomeTel)) > 0 THEN CONCAT("H: ",r3.HomeTel," ") ELSE "" END,
	CASE WHEN LENGTH(TRIM(r3.WorkTel)) > 0 THEN CONCAT("W: ",r3.WorkTel," ") ELSE "" END,
	CASE WHEN LENGTH(TRIM(r3.MobileTel)) > 0 THEN CONCAT("M: ",r3.MobileTel," ") ELSE "" END,
	CASE WHEN LENGTH(TRIM(r3.Notes)) > 0 THEN CONCAT(r3.Notes," ") ELSE "" END
	) 
	as FourthOfficialNotes,		
	r3.EmailAddress1 as FourthOfficialEmail1,
	r3.EmailAddress2 as FourthOfficialEmail2,
	
	r4.ID as AssessorID ,
	CASE
	WHEN LENGTH(TRIM(r4.Forename)) = 0 AND LENGTH(TRIM(r4.Surname)) = 0
	THEN r4.LongCol
	ELSE CONCAT(r4.Forename, " ", r4.Surname)
	END
	as AssessorFullName ,
	CASE
	WHEN LENGTH(TRIM(r4.Forename)) = 0 AND LENGTH(TRIM(r4.Surname)) = 0
	THEN r4.LongCol
	ELSE CONCAT(LEFT(r4.Forename,1), ". ", r4.Surname)
	END
	as AssessorName ,
	r4.mediumcol as AssessorNo ,
	CONCAT(
	CASE WHEN LENGTH(TRIM(r4.HomeTel)) > 0 THEN CONCAT("H: ",r4.HomeTel," ") ELSE "" END,
	CASE WHEN LENGTH(TRIM(r4.WorkTel)) > 0 THEN CONCAT("W: ",r4.WorkTel," ") ELSE "" END,
	CASE WHEN LENGTH(TRIM(r4.MobileTel)) > 0 THEN CONCAT("M: ",r4.MobileTel," ") ELSE "" END,
	CASE WHEN LENGTH(TRIM(r4.Notes)) > 0 THEN CONCAT(r4.Notes," ") ELSE "" END
	) 
	as AssessorNotes,		
	r4.EmailAddress1 as AssessorEmail1,
	r4.EmailAddress2 as AssessorEmail2,
	
	k.longcol as RoundName ,
	d1.notes as DivNotes,
	d1.longcol as DivName1 ,
	d1.ID as DID ,
	IF(d1.notes LIKE '%EXTERNAL%','Yes','No') as ExternalComp,
	IF(d1.notes LIKE '%HideDivision%','Yes','No') as HideScore,

	f.HomeID as FHomeID,
	f.AwayID as FAwayID,
	f.MatchNumber as MatchNumber ,	
	f.FixtureDate ,
	f.FixtureNotes ,
	f.PrivateNotes,
	f.HomeTeamNotes,
	f.AwayTeamNotes,
	f.Attendance ,
	f.Result ,
	IF(f.Result IN('H','A','D') AND f.HomeGoals=0 AND f.AwayGoals=0, NULL,f.HomeGoals) as Homegoals,
	IF(f.Result IN('H','A','D') AND f.HomeGoals=0 AND f.AwayGoals=0, NULL,f.AwayGoals) as Awaygoals,
	f.HomePointsAdjust ,
	f.AwayPointsAdjust ,
	f.ID as FID,
	f.PitchAvailableID as PA_ID,
	m.ID AS MatchReportID,
	d1.MediumCol as SortOrder,
	f.KOTime,
	f.RefereeMarksH,
	f.RefereeMarksA,
	f.HomeTeamSheetOK,
	f.AwayTeamSheetOK
FROM
	fixture f 
	LEFT JOIN matchreport m ON m.ShortCol = f.ID
	LEFT JOIN referee r ON r.ID = f.refereeID
	LEFT JOIN referee r1 ON r1.ID = f.AsstRef1ID
	LEFT JOIN referee r2 ON r2.ID = f.AsstRef2ID
	LEFT JOIN referee r3 ON r3.ID = f.FourthOfficialID
	LEFT JOIN referee r4 ON r4.ID = f.AssessorID
	LEFT JOIN koround k ON k.ID = f.KORoundID
	LEFT JOIN constitution c1 ON c1.ID = f.HomeID
	LEFT JOIN constitution c2 ON c2.ID = f.AwayID
	LEFT JOIN team t1 ON c1.TeamID = t1.ID
	LEFT JOIN team t2 ON c2.TeamID = t2.ID
	LEFT JOIN ordinal o1 ON c1.OrdinalID = o1.ID
	LEFT JOIN ordinal o2 ON c2.OrdinalID = o2.ID
	LEFT JOIN division d1 ON c1.DivisionID = d1.ID
WHERE
	f.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
	AND FixtureDate = #CreateODBCDate(MDate)# 
ORDER BY
	SortOrder, MatchNumber, HomeTeam, HomeOrdinal, AwayTeam, AwayOrdinal;
</CFQUERY>
