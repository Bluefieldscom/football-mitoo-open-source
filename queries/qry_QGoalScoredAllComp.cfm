<!--- called from TeamAllCompGoalScorers.cfm --->

<cfquery name="QGoalsScored" datasource="#request.DSN#">
	SELECT
		a.PlayerID as PlayerID ,
		p.LongCol as PlayerName ,
		COUNT(p.LongCol) as GamesPlayed ,
		COALESCE(SUM(a.GoalsScored),0) as Goals
	FROM
		appearance AS a ,
		player AS p ,
		fixture AS f
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND a.FixtureID = f.ID 
		AND (
			(f.HomeID IN (#ChosenConstits#) AND a.HomeAway = 'H') 
			OR 
			(f.AwayID IN (#ChosenConstits#) AND a.HomeAway = 'A')
			) 
		AND p.ID = a.PlayerID 
	GROUP BY
		PlayerID, PlayerName, p.ShortCol <!--- a.PlayerID, p.LongCol, p.ShortCol --->
	HAVING
		Goals > 0 <!--- SUM(a.GoalsScored) > 0 --->
	ORDER BY
		Goals DESC,	PlayerName <!--- SUM(a.GoalsScored) DESC, p.LongCol --->
</cfquery>
