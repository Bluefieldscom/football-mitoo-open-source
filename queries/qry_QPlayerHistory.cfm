<!--- called by PlayersHist.cfm --->

<!---
Present the user with a list of ALL the Matches where the specified Player
has appeared in the team.....across ALL competitions  
--->

<CFQUERY NAME="QPlayerHistory" datasource="#request.DSN#">

	SELECT
		p.shortcol,
		f.FixtureDate ,
		f.ID as FID ,
		k.LongCol as RoundName ,
		f.Result ,
		f.HomeID ,
		f.AwayID ,
		f.HomeGoals ,
		f.AwayGoals ,
		t1.LongCol as HomeTeam ,
		t2.LongCol as AwayTeam ,
		t1.ID as HomeTeamID,
		t2.ID as AwayTeamID,
		o1.LongCol as HomeOrdinal ,
		o2.LongCol as AwayOrdinal ,
		d.LongCol as CompetitionName ,
		d.ID as DID ,
		c1.ID as HID ,
		c2.ID as AID ,
		a.GoalsScored ,
		a.HomeAway ,
		a.Card ,
		a.Activity,
		IF(d.notes LIKE '%HideDivision%','Yes','No') as HideScore		
	FROM
		fixture AS f,
		koround AS k,
		constitution AS c1,
		constitution AS c2,
		team AS t1,
		team AS t2,
		ordinal AS o1,
		ordinal AS o2,
		division AS d,
		appearance AS a,
		player AS p
	WHERE
		c1.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND c2.LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND p.ID = <cfqueryparam value = #PI# cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND c1.ID = HomeID 
		AND c2.ID = AwayID 
		AND t1.ID = c1.TeamID 
		AND t2.ID = c2.TeamID 
		AND o1.ID = c1.OrdinalID 
		AND o2.ID = c2.OrdinalID 
		AND k.ID = f.KORoundID 
		AND d.ID = c1.DivisionID 
		AND a.FixtureID = f.ID 
		AND p.ID = a.PlayerID
	ORDER BY
		FixtureDate
</CFQUERY>
