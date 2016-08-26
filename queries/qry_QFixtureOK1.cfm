<!--- called by InclCheckFixtureDate.cfm, InclInsrtGroupOfFixtures.cfm --->

<cfquery name="QFixtureOK1" datasource="#request.DSN#">
	SELECT
		HomeID as hID,
		AwayID as aID,
		f.FixtureDate,
		t1.LongCol as HomeTeam,
		o1.LongCol as HomeOrdinal,
		t2.LongCol as AwayTeam,
		o2.LongCol as AwayOrdinal 
	FROM
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
		AND f.HomeID = <cfqueryparam value = #HomeID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND f.AwayID = <cfqueryparam value = #AwayID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND c1.DivisionID = <cfqueryparam value = #DivisionID# 
							cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND c2.DivisionID = <cfqueryparam value = #DivisionID# 
							cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND c1.ID = f.HomeID 
		AND t1.id = c1.TeamID 
		AND o1.id = c1.OrdinalID 
		AND c2.ID = f.AwayID 
		AND t2.id = c2.TeamID 
		AND o2.id = c2.OrdinalID
</cfquery>
