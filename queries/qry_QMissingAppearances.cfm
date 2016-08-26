<!--- Called by MissingAppearances.cfm --->

<cfquery name="QMissingAppearances" datasource="#request.DSN#" >
	SELECT
		'Home' as MType,
		t1.longCol as HomeTeam ,
		t2.longCol as AwayTeam ,
		t1.ID as HomeTeamID,
		t2.ID as AwayTeamID,
		o1.longCol as HomeOrdinal ,
		o2.longCol as AwayOrdinal ,
		k.longCol as RoundName ,
		r.longCol as RefereeName ,
		f.MatchNumber as MatchNumber ,
		f.HomeID ,
		f.AwayID ,
		f.FixtureDate ,
		f.HomeGoals ,
		f.AwayGoals ,
		f.Result ,
		f.ID as FID ,
		f.HomeTeamSheetOK,
		f.AwayTeamSheetOK,
		d.longCol as DivName ,
		d.mediumCol as DivSort ,
		d.ID as DID
	FROM
		fixture AS f,
		constitution AS c1,
		constitution AS c2,
		team AS t1,
		team AS t2,
		ordinal AS o1,
		ordinal AS o2,
		koround AS k,
		division AS d,
		referee AS r
	WHERE
		c1.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND c2.LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND f.ID NOT IN (#ResultHAList#) 
		AND f.FixtureDate < #BoundaryDate# 
		AND f.ID NOT IN (#HomeFIDList#) 
		AND f.ID IN (#AwayFIDList#) 
		AND f.HomeID = c1.ID 
		AND f.AwayID = c2.ID 
		AND f.RefereeID = r.ID 
		AND t1.ID = c1.TeamID 
		AND o1.id = c1.OrdinalID 
		AND t2.ID = c2.TeamID 
		AND o2.id = c2.OrdinalID 
		AND f.KORoundID = k.ID 
		AND d.id = c1.DivisionID 
		AND t1.id NOT IN (SELECT ID FROM team WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> AND ShortCol = 'GUEST')
		AND d.id NOT IN 
			(SELECT ID 
				FROM division 
				WHERE 
					LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
					AND ( Notes LIKE '%HideDivision%'))		
	UNION
	SELECT
		'Away' as MType,
		t1.longCol as HomeTeam ,
		t2.longCol as AwayTeam ,
		t1.ID as HomeTeamID,
		t2.ID as AwayTeamID,
		o1.longCol as HomeOrdinal ,
		o2.longCol as AwayOrdinal ,
		k.longCol as RoundName ,
		r.longCol as RefereeName ,
		f.MatchNumber as MatchNumber ,
		f.HomeID ,
		f.AwayID ,
		f.FixtureDate ,
		f.HomeGoals ,
		f.AwayGoals ,
		f.Result ,
		f.ID as FID ,
		f.HomeTeamSheetOK,
		f.AwayTeamSheetOK,
		d.longCol as DivName ,
		d.mediumCol as DivSort ,
		d.ID as DID
	FROM
		fixture AS f,
		constitution AS c1,
		constitution AS c2,
		team AS t1,
		team AS t2,
		ordinal AS o1,
		ordinal AS o2,
		koround AS k,
		division AS d,
		referee AS r
	WHERE
		c1.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND c2.LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND f.ID NOT IN (#ResultHAList#) 
		AND f.FixtureDate < #BoundaryDate# 
		AND f.ID NOT IN (#AwayFIDList#) 
		AND f.ID IN (#HomeFIDList#) 
		AND f.HomeID = c1.ID 
		AND f.AwayID = c2.ID 
		AND f.RefereeID = r.ID 
		AND t1.ID = c1.TeamID 
		AND o1.id = c1.OrdinalID 
		AND t2.ID = c2.TeamID 
		AND o2.id = c2.OrdinalID 
		AND f.KORoundID = k.ID 
		AND d.id = c1.DivisionID 
		AND t2.id NOT IN (SELECT ID FROM team WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> AND ShortCol = 'GUEST')
		AND d.id NOT IN 
			(SELECT ID 
				FROM division 
				WHERE 
					LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
					AND ( Notes LIKE '%HideDivision%'))		
	UNION
	SELECT
		'Both' as MType,
		t1.longCol as HomeTeam ,
		t2.longCol as AwayTeam ,
		t1.ID as HomeTeamID,
		t2.ID as AwayTeamID,
		o1.longCol as HomeOrdinal ,
		o2.longCol as AwayOrdinal ,
		k.longCol as RoundName ,
		r.longCol as RefereeName ,
		f.MatchNumber as MatchNumber ,
		f.HomeID ,
		f.AwayID ,
		f.FixtureDate ,
		f.HomeGoals ,
		f.AwayGoals ,
		f.Result ,
		f.ID as FID ,
		f.HomeTeamSheetOK,
		f.AwayTeamSheetOK,
		d.longCol as DivName ,
		d.mediumCol as DivSort ,
		d.ID as DID
	FROM
		fixture AS f,
		constitution AS c1,
		constitution AS c2,
		team AS t1,
		team AS t2,
		ordinal AS o1,
		ordinal AS o2,
		koround AS k,
		division AS d,
		referee AS r
	WHERE
		c1.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND c2.LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND f.ID NOT IN (#ResultHAList#) 
		AND f.FixtureDate < #BoundaryDate# 
		AND f.ID NOT IN (#AwayFIDList#) 
		AND f.ID NOT IN (#HomeFIDList#) 
		AND f.HomeID = c1.ID 
		AND f.AwayID = c2.ID 
		AND f.RefereeID = r.ID 
		AND t1.ID = c1.TeamID 
		AND o1.id = c1.OrdinalID 
		AND t2.ID = c2.TeamID 
		AND o2.id = c2.OrdinalID 
		AND f.KORoundID = k.ID 
		AND d.id = c1.DivisionID 
		AND t1.id NOT IN (SELECT ID FROM team WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> AND ShortCol = 'GUEST')
		AND t2.id NOT IN (SELECT ID FROM team WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> AND ShortCol = 'GUEST')
		AND d.id NOT IN 
			(SELECT ID 
				FROM division 
				WHERE 
					LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
					AND ( Notes LIKE '%HideDivision%'))		
	ORDER BY
			FixtureDate DESC, DivSort, MatchNumber, HomeTeam, AwayTeam	
</cfquery>
	