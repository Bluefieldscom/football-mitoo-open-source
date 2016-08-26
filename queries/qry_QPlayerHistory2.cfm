<!--- called by PlayersHist.cfm --->

<!---
Present the user with a list of ALL the Matches where the specified Player
has appeared in the team.....across ALL competitions  
--->

<CFQUERY NAME="QPlayerHistory2" datasource="#request.DSN#">

	SELECT
		COUNT(d.LongCol) as CompCount,
		f.FixtureDate ,
		f.ID as FID ,
		f.Result ,
		f.HomeID ,
		f.AwayID ,
		f.HomeGoals ,
		f.AwayGoals ,
		d.LongCol as CompetitionName ,
		d.ID as DID ,
		c1.ID as HID ,
		c2.ID as AID ,
		a.GoalsScored ,
		a.HomeAway ,
		a.Card
	FROM
		fixture AS f,
		constitution AS c1,
		constitution AS c2,
		division AS d,
		appearance AS a,
		player AS p
	WHERE
		c1.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND c2.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND p.ID = <cfqueryparam value = #PI# cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND c1.ID = HomeID 
		AND c2.ID = AwayID 
		AND d.ID = c1.DivisionID 
		AND a.FixtureID = f.ID 
		AND p.ID = a.PlayerID
	GROUP BY
		d.LongCol
	ORDER BY
		CompCount DESC, CompetitionName
</CFQUERY>
