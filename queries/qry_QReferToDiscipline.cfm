<!--- called by ReferToDiscipline.cfm --->

<cfquery name="QReferToDiscipline" datasource="#request.DSN#" >
	SELECT
		f.ID as FID,
		f.HomeID,
		f.AwayID,
		f.FixtureNotes,
		f.PrivateNotes,
		f.HomeGoals,
		f.AwayGoals,
		t1.LongCol as HomeTeamName,
		t2.LongCol as AwayTeamName,
		o1.LongCol as HomeTeamOrdinal,
		o2.LongCol as AwayTeamOrdinal,
		d.ID as DID
	FROM
		fixture AS f,
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
		AND (f.FixtureNotes LIKE '%DISCIP%' OR 	f.PrivateNotes LIKE '%DISCIP%' )
		AND c1.ID = f.HomeID 
		AND c2.ID = f.AwayID 
		AND c1.TeamID = t1.ID 
		AND c2.TeamID = t2.ID 
		AND c1.OrdinalID = o1.ID 
		AND c2.OrdinalID = o2.ID 
		AND c1.DivisionID = d.ID
</cfquery>