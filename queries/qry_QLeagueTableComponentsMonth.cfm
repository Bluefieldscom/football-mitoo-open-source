<cfparam name="request.DSN" default="fm2005">
<cfparam name="request.filter" default="MDX">
<cfparam name="DivisionID" default="3017">
<cfquery name="QLeagueTableComponents" datasource="#request.DSN#">
SELECT
		c.ID as CIdentity,
		c.TeamID as TeamID,
		
		#PointsForWin# as PointsForWin,
		#PointsForDraw# as PointsForDraw,
		#PointsForLoss# as PointsForLoss,
		
		(SELECT LongCol FROM team WHERE ID = c.TeamID) as ClubName,
		(SELECT LongCol FROM ordinal WHERE ID = c.OrdinalID) as OrdinalName,
		(SELECT ID FROM ordinal WHERE ID = c.OrdinalID) as OrdinalID,
		
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#DateMinimum#' AND '#DateMaximum#') AND f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result IS NULL) as CountHomeGamesPlayed,
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#DateMinimum#' AND '#DateMaximum#') AND f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result IS NULL) as CountAwayGamesPlayed,


		(SELECT COALESCE(SUM(f.HomeGoals),0) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#DateMinimum#' AND '#DateMaximum#') AND f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result IS NULL) as SumHomeGoalsFor,
		(SELECT COALESCE(SUM(f.AwayGoals),0) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#DateMinimum#' AND '#DateMaximum#') AND f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result IS NULL) as SumAwayGoalsFor,
		(SELECT COALESCE(SUM(f.HomeGoals),0) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#DateMinimum#' AND '#DateMaximum#') AND f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result IS NULL) as SumHomeGoalsAgainst,
		(SELECT COALESCE(SUM(f.AwayGoals),0) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#DateMinimum#' AND '#DateMaximum#') AND f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result IS NULL) as SumAwayGoalsAgainst,
		
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#DateMinimum#' AND '#DateMaximum#') AND f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals > f.AwayGoals) as CountHomeWins,
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#DateMinimum#' AND '#DateMaximum#') AND f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals < f.AwayGoals) as CountAwayWins,
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#DateMinimum#' AND '#DateMaximum#') AND f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals = f.AwayGoals) as CountHomeDraws,
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#DateMinimum#' AND '#DateMaximum#') AND f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals = f.AwayGoals) as CountAwayDraws,				
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#DateMinimum#' AND '#DateMaximum#') AND f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals < f.AwayGoals) as CountHomeDefeats,
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#DateMinimum#' AND '#DateMaximum#') AND f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals > f.AwayGoals) as CountAwayDefeats
	FROM
		constitution AS c
	WHERE
		c.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND c.DivisionID = <cfqueryparam value = #DivisionID# 
							cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>

