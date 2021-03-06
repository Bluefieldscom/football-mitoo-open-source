<!--- called by InclCheckFixtureDate.cfm, InclInsrtGroupOfFixtures.cfm --->

<cfquery name="QFixtureOK2" datasource="#request.DSN#">

SELECT
	d.LongCol as CompareDivisionName ,
	f.HomeID as hID,
	f.AwayID as aID,
	t1.LongCol as HomeTeam,
	o1.LongCol as HomeOrdinal,
	t2.LongCol as AwayTeam,
	o2.LongCol as AwayOrdinal
FROM
	division AS d,
	fixture AS f,
	constitution AS c1,
	team AS t1,
	ordinal AS o1,
	constitution AS c2,
	team AS t2,
	ordinal AS o2
WHERE
	c1.LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND c2.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND f.FixtureDate = #CreateODBCDate(DesiredDate)#			
	AND f.AwayID IN 
		(SELECT ID 
			FROM constitution 
			WHERE LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
				AND TeamID = #HomeTeamID# AND OrdinalID = #HomeOrdinalID#)	
	AND d.ID = c1.DivisionID
	AND c1.ID = f.HomeID
	AND t1.id = c1.TeamID
	AND o1.id = c1.OrdinalID
	AND c2.ID = f.AwayID
	AND t2.id = c2.TeamID
	AND o2.id = c2.OrdinalID
UNION
SELECT
	d.LongCol as CompareDivisionName,
	f.HomeID as hID,
	f.AwayID as aID,
	t1.LongCol as HomeTeam,
	o1.LongCol as HomeOrdinal,
	t2.LongCol as AwayTeam,
	o2.LongCol as AwayOrdinal
FROM
	division AS d,
	fixture  AS f,
	constitution AS c1,
	team AS t1,
	ordinal AS o1,
	constitution AS c2,
	team AS t2,
	ordinal AS o2
WHERE
	c1.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND c2.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND f.FixtureDate = #CreateODBCDate(DesiredDate)#
	AND f.HomeID IN 
		(SELECT ID 
			FROM constitution 
			WHERE LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
				AND TeamID = #HomeTeamID# AND OrdinalID = #HomeOrdinalID#) 
	AND d.ID = c1.DivisionID
	AND c1.ID = f.HomeID
	AND t1.id = c1.TeamID
	AND o1.id = c1.OrdinalID
	AND c2.ID = f.AwayID
	AND t2.id = c2.TeamID
	AND o2.id = c2.OrdinalID
UNION
SELECT
	d.LongCol as CompareDivisionName,
	f.HomeID as hID,
	f.AwayID as aID ,
	t1.LongCol as HomeTeam,
	o1.LongCol as HomeOrdinal,
	t2.LongCol as AwayTeam,
	o2.LongCol as AwayOrdinal
FROM
	division AS d,
	fixture AS f,
	constitution AS c1,
	team AS t1,
	ordinal AS o1,
	constitution AS c2,
	team AS t2,
	ordinal AS o2
WHERE
	c1.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND c2.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND f.FixtureDate = #CreateODBCDate(DesiredDate)#
	AND f.AwayID IN 
		(SELECT ID 
			FROM constitution 
			WHERE LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
				AND TeamID = #AwayTeamID# AND OrdinalID = #AwayOrdinalID#) 
	AND d.ID = c1.DivisionID
	AND c1.ID = f.HomeID
	AND t1.id = c1.TeamID
	AND o1.id = c1.OrdinalID
	AND c2.ID = f.AwayID
	AND t2.id = c2.TeamID
	AND o2.id = c2.OrdinalID
UNION
SELECT
	d.LongCol as CompareDivisionName,
	f.HomeID as hID,
	f.AwayID as aID,
	t1.LongCol as HomeTeam,
	o1.LongCol as HomeOrdinal,
	t2.LongCol as AwayTeam,
	o2.LongCol as AwayOrdinal
FROM
	division AS d,
	fixture AS f,
	constitution AS c1,
	team AS t1,
	ordinal AS o1,
	constitution AS c2,
	team AS t2,
	ordinal AS o2
WHERE
	c1.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND c2.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND f.FixtureDate = #CreateODBCDate(DesiredDate)#
	AND f.HomeID IN 
		(SELECT ID 
			FROM constitution 
			WHERE LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
				AND TeamID = #AwayTeamID# AND OrdinalID = #AwayOrdinalID#) 
	AND d.ID = c1.DivisionID
	AND c1.ID = f.HomeID
	AND t1.id = c1.TeamID
	AND o1.id = c1.OrdinalID
	AND c2.ID = f.AwayID
	AND t2.id = c2.TeamID
	AND o2.id = c2.OrdinalID

</cfquery>
