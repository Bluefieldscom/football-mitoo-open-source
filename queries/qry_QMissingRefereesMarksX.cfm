<!--- Called by MissingRefereeMarks.cfm --->

<cfquery name="QMissingRefereesMarks" datasource="#request.DSN#" >
SELECT
	t1.longCol as HomeTeam,
	t2.longCol as AwayTeam,
	t1.ID as HomeTeamID,
	t2.ID as AwayTeamID,
	o1.longCol as HomeOrdinal,
	o2.longCol as AwayOrdinal,
	k.LongCol as RoundName,
	f.MatchNumber as MatchNumber,
	f.HomeID,
	f.AwayID,
	f.RefereeID,
	f.RefereeMarksH,
	f.RefereeMarksA,		
	f.FixtureDate,
	f.FixtureNotes,
	f.HomeGoals,
	f.AwayGoals,
	f.Result,
	f.ID as FID,
	d.LongCol as DivName,
	d.ID as DID,
	CASE
	WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0
	THEN r.LongCol
	ELSE CONCAT(r.Forename, " ", r.Surname)
	END
	as RefsName
FROM
	fixture AS f,
	constitution AS c1,
	constitution AS c2,
	team AS t1,
	team AS t2,
	ordinal AS o1,
	ordinal AS o2,
	koround AS k,
	division AS d,
	referee AS r
WHERE
	c1.LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype = "CF_SQL_VARCHAR" maxlength = "5">
	AND c2.LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype = "CF_SQL_VARCHAR" maxlength = "5">
	AND f.ID NOT IN 
		(SELECT ID 
			FROM fixture 
			WHERE LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
				AND (FixtureNotes LIKE '%TEAM SHEET MISSING%' OR PrivateNotes LIKE '%IgnoreMissingRefereeMarks%')) 
	AND f.FixtureDate < #CreateODBCDate(NOW()- 3 )# 
	AND f.ID NOT IN 
		(SELECT ID 
			FROM fixture 
			WHERE LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
				AND result IN ('H','A','D')) 
	AND f.RefereeID NOT IN 
		( SELECT ID 
			FROM referee 
			WHERE LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
				AND LEFT(Notes,10) = 'No Referee') 
	AND d.id NOT IN 
		(SELECT ID 
			FROM division 
			WHERE 
				LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
				AND ( Notes LIKE '%External%'))		
	AND (f.RefereeMarksH IS NULL OR	f.RefereeMarksA IS NULL) 
	AND f.HomeID = c1.ID 
	AND f.AwayID = c2.ID 
	AND t1.ID = c1.TeamID 
	AND o1.id = c1.OrdinalID 
	AND t2.ID = c2.TeamID 
	AND o2.id = c2.OrdinalID 
	AND f.KORoundID = k.ID 
	AND d.id = c1.DivisionID 
	AND r.ID = f.RefereeID
ORDER BY
	FixtureDate DESC, r.ShortCol, d.MediumCol, MatchNumber, HomeTeam, AwayTeam <!--- f.FixtureDate DESC, r.ShortCol, d.MediumCol, f.MatchNumber, t1.LongCol, t2.LongCol --->
</cfquery>

