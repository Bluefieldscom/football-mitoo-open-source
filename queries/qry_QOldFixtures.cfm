<!--- called by News.cfm --->

<cfquery name="QOldFixtures" datasource="#request.DSN#" >
	SELECT
		t1.longcol as HomeTeam,
		t2.longcol as AwayTeam,
		t1.ID as HomeTeamID,
		t2.ID as AwayTeamID,
		o1.longcol as HomeOrdinal,
		o2.longcol as AwayOrdinal,
		k.longcol as RoundName,
		f.MatchNumber as MatchNumber,
		f.HomeID,
		f.AwayID,
		f.FixtureDate,
		f.FixtureNotes,
		f.HomeGoals,
		f.AwayGoals,
		f.Result,
		f.ID as FID,
		d.longcol as DivName
	FROM
		fixture AS f,
		constitution AS c1,
		constitution AS c2,
		team AS t1,
		team AS t2,
		ordinal AS o1,
		ordinal AS o2,
		koround AS k,
		division AS d
	WHERE
		c1.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND c2.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND f.FixtureDate < #CreateODBCDate(Now())# 
		AND f.HomeGoals IS NULL 
		AND f.AwayGoals IS NULL 
		AND f.ID NOT IN (select id from fixture where leaguecode=c1.LeagueCode and PrivateNotes LIKE '%NoAutomaticWarning%')
		AND ( f.Result IS NULL  OR  f.Result = 'P'  OR  f.Result = 'Q' OR  f.Result = 'W')
		AND f.HomeID = c1.ID 
		AND f.AwayID = c2.ID 
		AND t1.ID = c1.TeamID 
		AND o1.id = c1.OrdinalID 
		AND t2.ID = c2.TeamID 
		AND o2.id = c2.OrdinalID 
		AND f.KORoundID = k.ID 
		AND d.id = c1.DivisionID
	ORDER BY
		FixtureDate DESC, d.MediumCol, MatchNumber, HomeTeam, AwayTeam <!--- f.FixtureDate DESC, d.mediumcol, f.MatchNumber, t1.longcol, t2.longcol --->
</cfquery>
