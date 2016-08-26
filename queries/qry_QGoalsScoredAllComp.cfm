<!--- called from TeamAllGoalScorers.cfm --->

<cfquery name="QGoalsScored0" datasource="#request.DSN#">
	SELECT
		a.PlayerID as PlayerID,
		p.shortcol as RegNo,
		a.GoalsScored as GoalsScored,
		CASE
			WHEN p.shortcol=0 THEN 'OwnGoal'
			ELSE p.Surname
		END
		as PlayerSurname ,
		CASE
			WHEN p.shortcol=0 THEN '-'
			WHEN p.Forename = '' THEN '-'
			ELSE p.Forename
		END
		as PlayerForename,
		
		
		CASE
			WHEN a.Activity = 1 THEN 1
			ELSE 0
		END
		as Started,
		CASE
			WHEN a.Activity = 2 THEN 1
			ELSE 0
		END
		as SubPlayed,
		CASE
			WHEN a.Activity = 3 THEN 1
			ELSE 0
		END
		as SubNotPlayed
		
		
	FROM
		appearance AS a ,
		player AS p ,
		fixture AS f
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND a.FixtureID = f.ID 
		AND a.HomeAway = 'H'
		AND f.HomeID IN (#ChosenConstits#)
		AND p.ID = a.PlayerID
UNION ALL
	SELECT
		a.PlayerID as PlayerID,
		p.shortcol as RegNo,
		a.GoalsScored as GoalsScored,
		CASE
			WHEN p.shortcol=0 THEN 'OwnGoal'
			ELSE p.Surname
		END
		as PlayerSurname ,
		CASE
			WHEN p.shortcol=0 THEN '-'
			WHEN p.Forename = '' THEN '-'
			ELSE p.Forename
		END
		as PlayerForename,
		
		CASE
			WHEN a.Activity = 1 THEN 1
			ELSE 0
		END
		as Started,
		CASE
			WHEN a.Activity = 2 THEN 1
			ELSE 0
		END
		as SubPlayed,
		CASE
			WHEN a.Activity = 3 THEN 1
			ELSE 0
		END
		as SubNotPlayed
		
	FROM
		appearance AS a ,
		player AS p ,
		fixture AS f
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND a.FixtureID = f.ID 
		AND a.HomeAway = 'A'
		AND f.AwayID IN (#ChosenConstits#)
		AND p.ID = a.PlayerID
</cfquery>
<cfquery name="QGoalsScored" dbtype="query">
	SELECT 
		PlayerID,	
		PlayerSurname,
		PlayerForename,
		SUM(Started) as GamesStarted ,
		SUM(SubPlayed) as GamesSubPlayed ,
		SUM(SubNotPlayed) as GamesSubNotPlayed ,
		SUM(GoalsScored) as Goals
	FROM
		QGoalsScored0
	GROUP BY
		PlayerID, PlayerSurname, PlayerForename
	HAVING
		Goals > 0
	ORDER BY
		Goals DESC, PlayerSurname, PlayerForename, RegNo
</cfquery>
<cfquery name="QNoGoalsScored" dbtype="query">
	SELECT 
		PlayerID,	
		PlayerSurname,
		PlayerForename,
		SUM(Started) as GamesStarted ,
		SUM(SubPlayed) as GamesSubPlayed ,
		SUM(SubNotPlayed) as GamesSubNotPlayed ,
		SUM(GoalsScored) as Goals
	FROM
		QGoalsScored0
	GROUP BY
		PlayerID, PlayerSurname, PlayerForename
	HAVING
		Goals = 0
	ORDER BY
		PlayerSurname, PlayerForename, RegNo
</cfquery>