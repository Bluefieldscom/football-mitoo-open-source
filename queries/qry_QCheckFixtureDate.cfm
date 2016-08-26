<!--- called by InclCheckFixtureDate.cfm --->

<cfquery name="QCheckFixtureDate" datasource="#request.DSN#">
	SELECT
		t1.LongCol as HomeTeam,
		o1.LongCol as HomeOrdinal,
		t2.LongCol as AwayTeam,
		o2.LongCol as AwayOrdinal,
		LEFT(m1.LongCol,3) as HomeMatchNumber,
		LEFT(m1.LongCol,3) as AwayMatchNumber,
		d.Notes
	FROM
		constitution AS c1,
		team AS t1,
		ordinal AS o1,
		constitution AS c2,
		team AS t2,
		ordinal AS o2,
		matchno AS m1,
		matchno AS m2,
		division AS d
	WHERE
		c1.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND c2.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND d.id = <cfqueryparam value = #DivisionID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND c1.ID = <cfqueryparam value = #HomeID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND c2.ID = <cfqueryparam value = #AwayID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND c1.DivisionID = <cfqueryparam value = #DivisionID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND c2.DivisionID = <cfqueryparam value = #DivisionID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND t1.id = c1.TeamID 
		AND o1.id = c1.OrdinalID 
		AND t2.id = c2.TeamID 
		AND o2.id = c2.OrdinalID 
		AND m1.id = c1.ThisMatchNoID 
		AND m2.id = c2.ThisMatchNoID							
</cfquery>

