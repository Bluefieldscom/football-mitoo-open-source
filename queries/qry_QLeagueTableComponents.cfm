<cfquery name="QLeagueTableComponents" datasource="#request.DSN#">
SELECT
		#ThisDivisionID# as DivisionID,
		c.ID as CIdentity,
		c.TeamID as TeamID,
		c.PointsAdjustment as PointsAdjustment,

		(SELECT LongCol FROM team WHERE ID = c.TeamID) as ClubName,
		(SELECT LongCol FROM ordinal WHERE ID = c.OrdinalID) as OrdinalName,
		(SELECT ID FROM ordinal WHERE ID = c.OrdinalID) as OrdinalID,

		(SELECT LongCol FROM division WHERE ID = #ThisDivisionID#) as CompetitionName,

		(SELECT COALESCE(SUM(f.HomeGoals),0) FROM fixture AS f WHERE f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL ) as SumHomeGoalsFor,
		(SELECT COALESCE(SUM(f.AwayGoals),0) FROM fixture AS f WHERE f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL ) as SumHomeGoalsAgainst,
		
		(SELECT COALESCE(SUM(f.AwayGoals),0) FROM fixture AS f WHERE f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL ) as SumAwayGoalsFor,
		(SELECT COALESCE(SUM(f.HomeGoals),0) FROM fixture AS f WHERE f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL ) as SumAwayGoalsAgainst,
		
		
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals > f.AwayGoals AND f.Result IS NULL) as CountHomeWinNormal,
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals < f.AwayGoals AND f.Result IS NULL) as CountAwayWinNormal,
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals = f.AwayGoals AND f.Result IS NULL) as CountHomeDrawNormal,
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals = f.AwayGoals AND f.Result IS NULL) as CountAwayDrawNormal,				
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals < f.AwayGoals AND f.Result IS NULL) as CountHomeDefeatNormal,
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals > f.AwayGoals AND f.Result IS NULL) as CountAwayDefeatNormal,
		
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE f.HomeID = c.ID AND f.HomeGoals IS NULL AND f.AwayGoals IS NULL  AND f.Result = 'H') as CountHomeWinResultAwarded,
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE f.AwayID = c.ID AND f.HomeGoals IS NULL AND f.AwayGoals IS NULL  AND f.Result = 'A') as CountAwayWinResultAwarded,
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE f.HomeID = c.ID AND f.HomeGoals IS NULL AND f.AwayGoals IS NULL  AND f.Result = 'D') as CountHomeDrawResultAwarded,
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE f.AwayID = c.ID AND f.HomeGoals IS NULL AND f.AwayGoals IS NULL  AND f.Result = 'D') as CountAwayDrawResultAwarded,
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE f.HomeID = c.ID AND f.HomeGoals IS NULL AND f.AwayGoals IS NULL  AND f.Result = 'A') as CountHomeDefeatResultAwarded,
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE f.AwayID = c.ID AND f.HomeGoals IS NULL AND f.AwayGoals IS NULL  AND f.Result = 'H') as CountAwayDefeatResultAwarded,
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE f.HomeID = c.ID AND f.HomeGoals IS NULL AND f.AwayGoals IS NULL  AND f.Result = 'W') as CountHomeVoid,
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE f.AwayID = c.ID AND f.HomeGoals IS NULL AND f.AwayGoals IS NULL  AND f.Result = 'W') as CountAwayVoid,
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result = 'U') as CountHomeWinOnPenalties,
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result = 'V') as CountAwayWinOnPenalties,
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result = 'V') as CountHomeDefeatOnPenalties,
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result = 'U') as CountAwayDefeatOnPenalties,


		(SELECT COALESCE(SUM(f.HomePointsAdjust),0) FROM fixture AS f WHERE f.HomeID = c.ID) as SumHomePointsAdjust,
		(SELECT COALESCE(SUM(f.AwayPointsAdjust),0) FROM fixture AS f WHERE f.AwayID = c.ID) as SumAwayPointsAdjust
	FROM
		constitution AS c
	WHERE
		c.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND c.DivisionID = #ThisDivisionID# 
</cfquery>

