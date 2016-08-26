<!--- called by KOHist.cfm --->

<cfquery name="QKOHist" datasource="#request.DSN#" >
	SELECT
		f.Result as AwardedResult,
		f.HomeGoals as HomeGoals,
		f.AwayGoals as AwayGoals,
		f.HomeID as HomeID,
		f.AwayID as AwayID,
		f.MatchNumber as MatchNumber ,
		f.FixtureDate as FixtureDate,
		k.longcol as RoundName,
		k.mediumcol as RoundSort,
		t1.shortcol as HomeGuest ,
		t2.shortcol as AwayGuest ,
		t1.longcol as HomeTeamName,
		o1.longcol as HomeOrdinal,
		t2.longcol as AwayTeamName,
		o2.longcol as AwayOrdinal,
		t1.ID as HomeTeamID,
		t2.ID as AwayTeamID,
		o1.ID as HomeOrdinalID,
		o2.ID as AwayOrdinalID,
		IF(d.notes LIKE '%HideDivision%','Yes','No') as HideScore
	FROM
		fixture AS f,
		koround AS k,
		constitution AS c1,
		constitution AS c2,
		team AS t1,
		ordinal AS o1,
		team AS t2,
		ordinal AS o2,
		division AS d
	WHERE
		c1.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND c2.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND c1.DivisionID = <cfqueryparam value = #DivisionID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND c2.DivisionID = <cfqueryparam value = #DivisionID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND f.KORoundID = k.ID 
		AND c1.ID = f.HomeID 
		AND c2.ID = f.AwayID 
		AND t1.ID = c1.TeamID 
		AND o1.ID = c1.OrdinalID 
		AND t2.ID = c2.TeamID 
		AND o2.ID = c2.OrdinalID
		AND c1.DivisionID = d.ID
	ORDER BY
		RoundSort, MatchNumber, HomeTeamName, HomeOrdinal, AwayTeamName, AwayOrdinal
</cfquery>
