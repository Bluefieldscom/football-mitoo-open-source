<!--- called by FixtResMonth.cfm --->
<!--- List of ALL the Fixtures & Results for the specified League and Division. --->

<CFQUERY NAME="QFixtures" datasource="#request.DSN#">
SELECT
	t1.longcol as HomeTeam ,
	t2.longcol as AwayTeam ,
	t1.shortcol as HomeGuest ,
	t2.shortcol as AwayGuest ,
	t1.ID as HomeTeamID,
	t2.ID as AwayTeamID,
	o1.longcol as HomeOrdinal ,
	o2.longcol as AwayOrdinal ,
	o1.ID as HomeOrdinalID ,
	o2.ID as AwayOrdinalID ,
	IF(d.notes LIKE '%HideDivision%','Yes','No') as HideScore,
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
	
	k.longcol as RoundName ,
	f.MatchNumber as MatchNumber ,
	f.HomeID ,
	f.AwayID ,
	f.FixtureDate ,
	f.FixtureNotes ,
	f.PrivateNotes,
	<!--- applies to season 2012 onwards only --->
		<cfif RIGHT(request.dsn,4) GE 2012>
				f.RefereeReportReceived, f.HideMatchOfficials, f.RefMatchCardAnswers, f.RefMatchCardProblems,
		</cfif>
	f.Attendance ,
	IF(f.Result IN('H','A','D') AND f.HomeGoals=0 AND f.AwayGoals=0, NULL,f.HomeGoals) as Homegoals,
	IF(f.Result IN('H','A','D') AND f.HomeGoals=0 AND f.AwayGoals=0, NULL,f.AwayGoals) as Awaygoals,
	f.Result ,
	f.HomePointsAdjust,
	f.AwayPointsAdjust,
	m.ID AS MatchReportID,
	f.ID as FID,
	f.PitchAvailableID as PA_ID,
	f.KOTime
FROM
	fixture AS f LEFT JOIN matchreport m ON m.ShortCol = f.ID,
	constitution AS c1,
	constitution AS c2,
	team AS t1,
	team AS t2,
	ordinal AS o1,
	ordinal AS o2,
	referee AS r,
	referee AS r1,
	referee AS r2,
	referee AS r3,
	referee AS r4,
	koround AS k,
	division AS d
WHERE
	c1.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND c2.LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5">  
	AND MONTH(f.FixtureDate) = <cfqueryparam value = #MonthNo# 
									cfsqltype="CF_SQL_INTEGER" maxlength="2">
	AND c1.DivisionID = <cfqueryparam value = #DivisionID# 
							cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
	AND c2.DivisionID = <cfqueryparam value = #DivisionID# 
							cfsqltype="CF_SQL_INTEGER" maxlength="8">  
	AND f.HomeID = c1.ID 
	AND f.AwayID = c2.ID 
	AND t1.ID = c1.TeamID 
	AND o1.id = c1.OrdinalID 
	AND t2.ID = c2.TeamID 
	AND o2.id = c2.OrdinalID 
	AND f.RefereeID = r.ID 
	AND f.AsstRef1ID = r1.ID 
	AND f.AsstRef2ID = r2.ID 
	AND f.FourthOfficialID = r3.ID 
	AND f.AssessorID = r4.ID 
	AND f.KORoundID = k.ID
	AND d.ID = c1.DivisionID
ORDER BY
		FixtureDate, <cfif KickOffTimeOrder>KOTime,</cfif> MatchNumber, HomeTeam, HomeOrdinal, AwayTeam, AwayOrdinal
		
</CFQUERY>
