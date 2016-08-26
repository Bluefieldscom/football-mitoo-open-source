<!--- called from teamList.cfm --->

<CFQUERY NAME="QTeamSheetFixtureInfo" datasource="#request.DSN#">
SELECT
	t1.LongCol as teamName1 ,
	o1.LongCol as ordinalName1 ,
	t2.LongCol as teamName2 ,
	o2.LongCol as ordinalName2 ,
	f.HomeGoals as HomeGoals ,
	f.AwayGoals as AwayGoals ,
	f.fixtureDate as fixtureDate ,
	f.RefereeMarksH,
	f.RefereeMarksA,
	d.LongCol as divisionName ,
	d.Notes as divisionNotes ,
	f.HomeID as HomeID ,
	f.AwayID as AwayID
	<!--- TR added --->
	, c1.teamID as hometeamID, 
	c1.ordinalID as hometeamOrdID,
	c2.teamID as awayteamID, 
	c2.ordinalID as awayteamOrdID,
	k.longcol as koroundname
FROM
	division AS d, 
	team AS t1, 
	ordinal AS o1, 
	team AS t2, 
	ordinal AS o2, 
	constitution AS c1, 
	constitution AS c2, 
	fixture AS f,
	koround as k
WHERE
	c1.LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND c2.LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND f.ID = <cfqueryparam value = #FID# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
	AND f.HomeID = c1.ID 
	AND f.AwayID = c2.ID 
	AND c1.teamID = t1.ID 
	AND c1.ordinalID = o1.ID 
	AND c2.teamID = t2.ID 
	AND c2.ordinalID = o2.ID 
	AND d.ID = c1.divisionID
	AND f.KORoundID = k.ID
</CFQUERY>
