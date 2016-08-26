<!--- called by MoveToMisc.cfm, SuspendPlayer.cfm --->

<CFQUERY NAME="QGetFixtureInfo" datasource="#request.DSN#">
SELECT 
	d.longcol as DivisionName,
	d.id as DivisionID,
	CASE
	WHEN o1.LongCol IS NULL
	THEN t1.LongCol
	ELSE CONCAT(t1.LongCol, " ", o1.LongCol)
	END
	as HomeTeamName ,
	CASE
	WHEN o2.LongCol IS NULL
	THEN t2.LongCol
	ELSE CONCAT(t2.LongCol, " ", o2.LongCol)
	END
	as AwayTeamName,
	f.HomeGoals,
	f.AwayGoals,
	f.FixtureDate,
	f.Result,
	k.longcol as RoundName ,
	f.MatchNumber as MatchNumber ,
	f.HomeID ,
	f.AwayID ,
	f.FixtureDate ,
	f.FixtureNotes ,
	f.PrivateNotes,
	IF(f.Result IN('H','A','D') AND f.HomeGoals=0 AND f.AwayGoals=0, NULL,f.HomeGoals) as Homegoals,
	IF(f.Result IN('H','A','D') AND f.HomeGoals=0 AND f.AwayGoals=0, NULL,f.AwayGoals) as Awaygoals,
	f.Result
FROM
	division d,
	fixture AS f,
	constitution AS c1,
	constitution AS c2,
	team AS t1,
	team AS t2,
	ordinal AS o1,
	ordinal AS o2,
	koround AS k 
WHERE
	f.ID=#FID#
	AND	f.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">	
	AND c1.DivisionID = d.id
	AND f.HomeID = c1.ID 
	AND f.AwayID = c2.ID 
	AND t1.ID = c1.TeamID 
	AND o1.id = c1.OrdinalID 
	AND t2.ID = c2.TeamID 
	AND o2.id = c2.OrdinalID 
	AND f.KORoundID = k.ID
</CFQUERY>
