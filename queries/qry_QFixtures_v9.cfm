<!--- Called by RegistListForm.cfm --->
<!---
List ALL the Results for all Teams within a specified Club
for the ALL competitions they are entered in )
--->

<CFQUERY NAME="QFixtures" datasource="#request.DSN#">
SELECT
	'H' as HomeAway,
	f.ID as FID ,
	f.FixtureDate ,
	k.longcol as RoundName,
	f.Result ,
	f.HomeID ,
	f.AwayID ,
	IF(f.Result IN('H','A','D') AND f.HomeGoals=0 AND f.AwayGoals=0, NULL,f.HomeGoals) as Homegoals,
	IF(f.Result IN('H','A','D') AND f.HomeGoals=0 AND f.AwayGoals=0, NULL,f.AwayGoals) as Awaygoals,
	f.HomePointsAdjust ,
	f.AwayPointsAdjust ,
	f.Attendance ,
	f.HomeSportsmanshipMarks,
	f.AwaySportsmanshipMarks,
	t1.longcol as HomeTeam ,
	t2.longcol as AwayTeam ,
	o1.longcol as HomeOrdinal ,
	o2.longcol as AwayOrdinal ,
	d.longcol as CompetitionName,
	d.mediumcol as CompSortOrder,
	f.KOTime
FROM
	fixture AS f,
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
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
	AND c2.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
	AND f.HomeID IN (<cfqueryparam value = #request.ChosenConstitsAllSides# 
						cfsqltype="CF_SQL_INTEGER" list="Yes" maxlength="6">) 
	AND c1.ID = HomeID 
	AND c2.ID = AwayID 
	AND t1.ID = c1.TeamID 
	AND t2.ID = c2.TeamID 
	AND o1.ID = c1.OrdinalID 
	AND o2.ID = c2.OrdinalID 
	AND k.ID = f.KORoundID 
	AND d.ID = c1.DivisionID
UNION
SELECT
	'A' as HomeAway,
	f.ID as FID ,
	f.FixtureDate ,
	k.longcol as RoundName,
	f.Result ,
	f.HomeID ,
	f.AwayID ,
	f.HomeGoals ,
	f.AwayGoals ,
	f.HomePointsAdjust ,
	f.AwayPointsAdjust ,
	f.Attendance ,
	f.HomeSportsmanshipMarks,
	f.AwaySportsmanshipMarks,
	t1.longcol as HomeTeam ,
	t2.longcol as AwayTeam ,
	o1.longcol as HomeOrdinal ,
	o2.longcol as AwayOrdinal ,
	d.longcol as CompetitionName,
	d.mediumcol as CompSortOrder,
	f.KOTime
FROM
	fixture AS f,
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
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
	AND c2.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
	AND f.AwayID IN (<cfqueryparam value = #request.ChosenConstitsAllSides# 
						cfsqltype="CF_SQL_INTEGER" list="Yes" maxlength="6">)  
	AND c1.ID = HomeID 
	AND c2.ID = AwayID 
	AND t1.ID = c1.TeamID 
	AND t2.ID = c2.TeamID 
	AND o1.ID = c1.OrdinalID 
	AND o2.ID = c2.OrdinalID 
	AND k.ID = f.KORoundID 
	AND d.ID = c1.DivisionID
ORDER BY FixtureDate, CompSortOrder

		
</CFQUERY>
