<!--- called by LeagueTab.cfm --->

<cfquery name="QGoalsScoredUnion" datasource="#request.DSN#">
	SELECT
		f.FixtureDate,
		a.PlayerID,
		p.Surname, p.Forename,
		<!--- CONCAT(p.surname, " ",p.forename) as PlayerName, --->
		t.LongCol as TeamName,
		o.LongCol as OrdinalName, 
		a.GoalsScored
	FROM
		team t
		JOIN register r ON t.ID = r.TeamID
		JOIN player p ON p.ID = r.PlayerID
		JOIN appearance a ON a.PlayerID = p.ID AND a.HomeAway = 'H'
		JOIN fixture f ON f.ID = a.FixtureID
		JOIN constitution c ON c.ID = f.HomeID
		JOIN ordinal o ON o.ID = c.OrdinalID
	WHERE
		a.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND c.DivisionID = <cfqueryparam value = #DivisionID# cfsqltype="CF_SQL_INTEGER">
		AND	(CURRENT_DATE BETWEEN 
				CASE
				WHEN r.FirstDay IS NULL
				THEN '1900-01-01'
				ELSE r.FirstDay
				END
			 AND 
				CASE
				WHEN r.LastDay IS NULL
				THEN '2999-12-31'
				ELSE r.LastDay
				END )
	UNION ALL
	SELECT 
		f.FixtureDate,
		a.PlayerID,
		p.Surname, p.Forename,
		<!--- CONCAT(p.surname, " ",p.forename) as PlayerName, --->
		t.LongCol as TeamName,
		o.LongCol as OrdinalName, 
		a.GoalsScored
	FROM
		team t
		JOIN register r ON t.ID = r.TeamID
		JOIN player p ON p.ID = r.PlayerID
		JOIN appearance a ON a.PlayerID = p.ID AND a.HomeAway = 'A'
		JOIN fixture f ON f.ID = a.FixtureID
		JOIN constitution c ON c.ID = f.AwayID
		JOIN ordinal o ON o.ID = c.OrdinalID
	WHERE
		a.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND c.DivisionID = <cfqueryparam value = #DivisionID# cfsqltype="CF_SQL_INTEGER">
		AND	(CURRENT_DATE BETWEEN 
				CASE
				WHEN r.FirstDay IS NULL
				THEN '1900-01-01'
				ELSE r.FirstDay
				END
			 AND 
				CASE
				WHEN r.LastDay IS NULL
				THEN '2999-12-31'
				ELSE r.LastDay
				END )
</cfquery>

<cfquery name="QGoalsScored" dbtype="query" maxrows="20">
	SELECT
		TeamName,
		OrdinalName,
		MAX(FixtureDate) as MostRecentDatePlayed,
		PlayerID,
		Surname, Forename, <!--- PlayerName, --->
		COUNT(PlayerID) as GamesPlayed,
		SUM(GoalsScored) as Goals
	FROM
		QGoalsScoredUnion
	GROUP BY
		<!--- PlayerID, PlayerName, TeamName, OrdinalName --->
		TeamName, OrdinalName, PlayerID, Surname, Forename
	HAVING
		SUM(GoalsScored) > 0 
	ORDER BY
		Goals DESC, Surname, Forename <!--- Playername --->
</cfquery>

