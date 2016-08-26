<!--- called by Unsched.cfm --->

<cfquery name="QGetPointsAdjust" datasource="#request.DSN#">
	SELECT 
		f.result as AwardedResult,
		f.HomeID as HomeID,
		f.AwayID as AwayID,
		f.HomeGoals,
		f.AwayGoals,
		f.HomePointsAdjust as HomePointsAdjust,
		f.AwayPointsAdjust as AwayPointsAdjust,
		f.FixtureDate as FixtureDate,
		t1.LongCol as HomeTeamName,
		o1.LongCol as HomeOrdinal,
		t2.LongCol as AwayTeamName,
		o2.LongCol as AwayOrdinal,
		t1.ID as HomeTeamID,
		t2.ID as AwayTeamID
	FROM
		fixture AS f,
		constitution AS c1,
		constitution AS c2,
		team AS t1,
		ordinal AS o1,
		team AS t2,
		ordinal AS o2
	WHERE
		c1.LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND c2.LeagueCode = <cfqueryparam value = '#request.filter#' 
								cfsqltype="CF_SQL_VARCHAR" maxlength="5">  
		AND (f.result IN ('H','A','D','W') OR
			(f.HomePointsAdjust <> 0 OR
			f.AwayPointsAdjust <> 0)) 
		AND c1.DivisionID = <cfqueryparam value = #DivisionID# 
								cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND c2.DivisionID = <cfqueryparam value = #DivisionID# 
								cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND c1.ID = f.HomeID 
		AND c2.ID = f.AwayID 
		AND t1.ID = c1.TeamID 
		AND o1.ID = c1.OrdinalID 
		AND t2.ID = c2.TeamID 
		AND o2.ID = c2.OrdinalID
	ORDER BY
		FixtureDate <!--- f.FixtureDate --->
</cfquery>
