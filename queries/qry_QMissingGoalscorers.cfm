<!--- Called by MissingGoalscorers.cfm --->

<cfquery name="QMissingGoalscorers" datasource="#request.DSN#" >
SELECT
	'Home' as MType,
	t1.longcol as HomeTeam ,
	t2.longcol as AwayTeam ,
	t1.ID as HomeTeamID,
	t2.ID as AwayTeamID,
	o1.longcol as HomeOrdinal ,
	o2.longcol as AwayOrdinal ,
	k.longcol as RoundName ,
	f.MatchNumber as MatchNumber ,
	f.HomeID ,
	f.AwayID ,
	f.FixtureDate ,
	f.HomeGoals ,
	f.AwayGoals ,
	f.Result ,
	f.ID as FID ,
	d.longcol as DivName ,
	d.mediumcol as DivSort ,
	d.ID as DID,
	IF(d.Notes LIKE '%External%','External','Internal') as CompetitionType
FROM
	fixture f,
	constitution c1 ,
	constitution c2 ,
	team t1 ,
	team t2 ,
	ordinal o1 ,
	ordinal o2 ,
	koround k ,
	division d
WHERE
	f.ID NOT IN (#ResultHAList#) AND
	f.FixtureDate < #BoundaryDate# AND
	f.ID IN (#HomeFIDList#) AND
	f.ID NOT IN (#AwayFIDList#) AND 
	(t1.shortcol <> 'GUEST' OR t1.shortcol IS NULL) AND
	f.HomeID = c1.ID AND
	f.AwayID = c2.ID AND
	t1.ID = c1.TeamID AND
	o1.id = c1.OrdinalID AND
	t2.ID = c2.TeamID AND
	o2.id = c2.OrdinalID AND
	f.KORoundID = k.ID AND
	d.id = c1.DivisionID		
UNION
SELECT
	'Away' as MType,
	t1.longcol as HomeTeam ,
	t2.longcol as AwayTeam ,
	t1.ID as HomeTeamID,
	t2.ID as AwayTeamID,
	o1.longcol as HomeOrdinal ,
	o2.longcol as AwayOrdinal ,
	k.longcol as RoundName ,
	f.MatchNumber as MatchNumber ,
	f.HomeID ,
	f.AwayID ,
	f.FixtureDate ,
	f.HomeGoals ,
	f.AwayGoals ,
	f.Result ,
	f.ID as FID ,
	d.longcol as DivName ,
	d.mediumcol as DivSort ,
	d.ID as DID,
	IF(d.Notes LIKE '%External%','External','Internal') as CompetitionType
FROM
	fixture f,
	constitution c1 ,
	constitution c2 ,
	team t1 ,
	team t2 ,
	ordinal o1 ,
	ordinal o2 ,
	koround k ,
	division d
WHERE
	f.ID NOT IN (#ResultHAList#) AND 
	f.FixtureDate < #BoundaryDate# AND
	f.ID IN (#AwayFIDList#) AND 
	f.ID NOT IN (#HomeFIDList#) AND
	(t2.shortcol <> 'GUEST' OR t2.shortcol IS NULL) AND
	f.HomeID = c1.ID AND
	f.AwayID = c2.ID AND
	t1.ID = c1.TeamID AND
	o1.id = c1.OrdinalID AND
	t2.ID = c2.TeamID AND
	o2.id = c2.OrdinalID AND
	f.KORoundID = k.ID AND
	d.id = c1.DivisionID		
UNION
SELECT
	'Both' as MType,
	t1.longcol as HomeTeam ,
	t2.longcol as AwayTeam ,
	t1.ID as HomeTeamID,
	t2.ID as AwayTeamID,
	o1.longcol as HomeOrdinal ,
	o2.longcol as AwayOrdinal ,
	k.longcol as RoundName ,
	f.MatchNumber as MatchNumber ,
	f.HomeID ,
	f.AwayID ,
	f.FixtureDate ,
	f.HomeGoals ,
	f.AwayGoals ,
	f.Result ,
	f.ID as FID ,
	d.longcol as DivName ,
	d.mediumcol as DivSort ,
	d.ID as DID,
	IF(d.Notes LIKE '%External%','External','Internal') as CompetitionType
FROM
	fixture f,
	constitution c1 ,
	constitution c2 ,
	team t1 ,
	team t2 ,
	ordinal o1 ,
	ordinal o2 ,
	koround k ,
	division d
WHERE
	f.ID NOT IN (#ResultHAList#) AND 
	f.FixtureDate < #BoundaryDate# AND
	f.ID IN (#AwayFIDList#) AND
	f.ID IN (#HomeFIDList#) AND 
	f.HomeID = c1.ID AND
	f.AwayID = c2.ID AND
	t1.ID = c1.TeamID AND
	o1.id = c1.OrdinalID AND
	t2.ID = c2.TeamID AND
	o2.id = c2.OrdinalID AND
	f.KORoundID = k.ID AND
	d.id = c1.DivisionID
ORDER BY
		FixtureDate DESC, DivSort, MatchNumber, HomeTeam, AwayTeam
</cfquery>
