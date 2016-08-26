<!--- called by  FixtureDetailsXLS.cfm --->

<cfquery name="QFixtures" datasource="#request.DSN#" >
SELECT
	t1.longCol AS HomeTeam ,
	t2.longCol AS AwayTeam ,
	t1.shortCol AS HomeGuest ,
	t2.shortCol AS AwayGuest ,
	t1.ID AS HomeTeamID,
	t2.ID AS AwayTeamID,
	o1.longCol AS HomeOrdinal ,
	o2.longCol AS AwayOrdinal ,
	r.ID AS RefsID ,
	CASE
		WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0
		THEN r.LongCol
		ELSE CONCAT(r.Forename, " ", r.Surname)
		END
		as RefsName,
	r.mediumCol AS RefsNo ,
	r1.ID AS AR1ID ,
	CASE
		WHEN LENGTH(TRIM(r1.Forename)) = 0 AND LENGTH(TRIM(r1.Surname)) = 0
		THEN r1.LongCol
		ELSE CONCAT(r1.Forename, " ", r1.Surname)
		END
		as AR1Name ,
	r1.mediumCol AS AR1No ,
	r2.ID AS AR2ID ,
	CASE
		WHEN LENGTH(TRIM(r2.Forename)) = 0 AND LENGTH(TRIM(r2.Surname)) = 0
		THEN r2.LongCol
		ELSE CONCAT(r2.Forename, " ", r2.Surname)
		END
		as AR2Name ,
	r2.mediumCol AS AR2No ,
	r3.ID as FourthOfficialID ,
	CASE
		WHEN LENGTH(TRIM(r3.Forename)) = 0 AND LENGTH(TRIM(r3.Surname)) = 0
		THEN r3.LongCol
		ELSE CONCAT(r3.Forename, " ", r3.Surname)
		END
		as FourthOfficialName ,
	r3.mediumcol as FourthOfficialNo ,
	k.longCol AS RoundName ,
	d.longCol AS DivName ,
	CASE
		WHEN d.Notes LIKE '%External%'
		THEN 'Yes'
		ELSE 'No'
		END
		as External,
	f.HomeID AS FHomeID,
	f.AwayID AS FAwayID,
	f.MatchNumber AS MatchNumber ,	
	f.FixtureDate,
	f.FixtureNotes,
	f.HomeTeamNotes,
	f.AwayTeamNotes,
	f.PrivateNotes,
	f.KOTime,
	f.Result,
	f.HomeGoals,
	f.AwayGoals,
	(select v.longcol from pitchavailable p, venue v where pitchavailableid = p.ID and p.venueid = v.id) as VenueName,
	(select n.longcol from pitchavailable p, pitchno n where pitchavailableid = p.ID and p.PitchNoID = n.id) as PitchNumber,
	f.HomeSportsmanshipMarks,
	f.AwaySportsmanshipMarks
	
FROM
	fixture AS f,
	referee AS r,
	referee AS r1,
	referee AS r2,
	referee AS r3,
	koround AS k,
	constitution AS c1,
	constitution AS c2,
	team AS t1,
	team AS t2,
	ordinal AS o1,
	ordinal AS o2,
	division AS d
WHERE
	c1.LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype = "CF_SQL_VARCHAR" maxlength = "5">
	AND c2.LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype = "CF_SQL_VARCHAR" maxlength = "5">
	AND FixtureDate BETWEEN '#D1#' AND '#D2#' 
	AND HomeID = c1.ID 
	AND AwayID = c2.ID 
	AND t1.ID = c1.TeamID 
	AND o1.id = c1.OrdinalID 
	AND t2.ID = c2.TeamID 
	AND o2.id = c2.OrdinalID 
	AND f.RefereeID = r.ID 
	AND f.AsstRef1ID = r1.ID 
	AND f.AsstRef2ID = r2.ID 
	AND f.FourthOfficialID = r3.ID 
	AND f.KORoundID = k.ID 
	AND d.id = c1.DivisionID
ORDER BY
	FixtureDate, d.MediumCol, MatchNumber, HomeTeam, AwayTeam
</cfquery>
