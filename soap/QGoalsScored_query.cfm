

<cfquery name="QGoalsScoredUnion_query" datasource="#variables.dsn#">
	SELECT
		f.FixtureDate,
		a.PlayerID,
		p.Surname, p.Forename,
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
		a.LeagueCode = <cfqueryparam value = '#arguments.leagueCode#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND c.DivisionID = <cfqueryparam value = #arguments.division_id# cfsqltype="CF_SQL_INTEGER">
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
		a.LeagueCode = <cfqueryparam value = '#arguments.leagueCode#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND c.DivisionID = <cfqueryparam value = #arguments.division_id# cfsqltype="CF_SQL_INTEGER">
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

<cfquery name="QGoalsScored_query" dbtype="query" maxrows="20">
	SELECT
		TeamName,
		OrdinalName,
		MAX(FixtureDate) as MostRecentDatePlayed,
		PlayerID,
		Surname, Forename, 
		COUNT(PlayerID) as GamesPlayed,
		SUM(GoalsScored) as Goals
	FROM
		QGoalsScoredUnion_query
	GROUP BY
		TeamName, OrdinalName, PlayerID, Surname, Forename
	HAVING
		SUM(GoalsScored) > 0 
	ORDER BY
		Goals DESC, Surname, Forename
</cfquery>

<cfset i=1>
<cfloop query="QGoalsScored_query">
	<cfinclude template="QCurrentTeam_query.cfm">
	<cfscript>
		QLeagueLeadingGoalScorers[#i#]							= StructNew();
		QLeagueLeadingGoalScorers[#i#].team_name				= #QCurrentTeam.teamName#;
		QLeagueLeadingGoalScorers[#i#].ordinal_name				= #QCurrentTeam.ordinalName#;
		QLeagueLeadingGoalScorers[#i#].most_recent_date_played	= DateFormat(#mostRecentDatePlayed#,'yyyy-mm-dd');
		QLeagueLeadingGoalScorers[#i#].player_id				= #playerid#;
		QLeagueLeadingGoalScorers[#i#].player_surname			= #surname#;
		QLeagueLeadingGoalScorers[#i#].player_first_name		= #forename#;
		QLeagueLeadingGoalScorers[#i#].games_played				= #gamesPlayed#;
		QLeagueLeadingGoalScorers[#i#].goals					= #goals#;
		i++;
	</cfscript>
</cfloop>
