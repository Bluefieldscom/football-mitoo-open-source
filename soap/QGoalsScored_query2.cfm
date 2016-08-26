<!---
<cfset arguments.league_code = 'ISTH'>
<cfset arguments.division_id = 235>
<cfset arguments.start_date = '2010-08-01'>
<cfset arguments.end_date   = '2011-04-01'>
<cfset arguments.limit     = 10>
<cfset arguments.order = 'DESC'>

<cfinclude template="QgetLeagueYearFromDates3.cfm">
<cfif inSeason IS 0>
	<cfscript> QFixtures[1] = StructNew(); </cfscript>
	<cfreturn QFixtures>
</cfif>	 
--->

<cfif NOT IsDefined('arguments.division_id')>
	<cfset arguments.division_id = ''>
</cfif>

<cfquery name="QGoalsScoredUnion_query" datasource="#variables.dsn#">
	SELECT
		DATE_FORMAT(f.FixtureDate, '%Y-%m-%d') AS FixtureDate,
		a.PlayerID,
		p.Surname, p.Forename,
		t.LongCol as TeamName,
		o.LongCol as OrdinalName, 
		a.GoalsScored 		
	FROM
		fm#getLeagueYear.leagueCodeYear#.team t
		JOIN fm#getLeagueYear.leagueCodeYear#.register r ON t.ID = r.TeamID
		JOIN fm#getLeagueYear.leagueCodeYear#.player p ON p.ID = r.PlayerID
		JOIN fm#getLeagueYear.leagueCodeYear#.appearance a ON (a.PlayerID = p.ID AND a.HomeAway = 'H')
		JOIN fm#getLeagueYear.leagueCodeYear#.fixture f ON f.ID = a.FixtureID
		JOIN fm#getLeagueYear.leagueCodeYear#.constitution c ON c.ID = f.HomeID
	JOIN fm#getLeagueYear.leagueCodeYear#.division d1 ON c.DivisionID = d1.ID
		JOIN fm#getLeagueYear.leagueCodeYear#.ordinal o ON o.ID = c.OrdinalID
		<cfif ListLen(arguments.division_id) NEQ 0> 
			JOIN zmast.lk_division zlkd ON zlkd.id = #arguments.division_id#
		</cfif>
	WHERE
		<cfif ListLen(arguments.division_id) NEQ 0>
			c.DivisionID = zlkd.#getLeagueYear.leagueCodeYear#id AND 
		</cfif>
		a.leaguecode = '#arguments.league_code#'
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
		DATE_FORMAT(f.FixtureDate, '%Y-%m-%d') AS FixtureDate,
		a.PlayerID,
		p.Surname, p.Forename,
		t.LongCol as TeamName,
		o.LongCol as OrdinalName, 
		a.GoalsScored
	FROM
		fm#getLeagueYear.leagueCodeYear#.team t
		JOIN fm#getLeagueYear.leagueCodeYear#.register r ON t.ID = r.TeamID
		JOIN fm#getLeagueYear.leagueCodeYear#.player p ON p.ID = r.PlayerID
		JOIN fm#getLeagueYear.leagueCodeYear#.appearance a ON (a.PlayerID = p.ID AND a.HomeAway = 'A')
		JOIN fm#getLeagueYear.leagueCodeYear#.fixture f ON f.ID = a.FixtureID
		JOIN fm#getLeagueYear.leagueCodeYear#.constitution c ON c.ID = f.AwayID
	JOIN fm#getLeagueYear.leagueCodeYear#.division d1 ON c.DivisionID = d1.ID
		JOIN fm#getLeagueYear.leagueCodeYear#.ordinal o ON o.ID = c.OrdinalID
		<cfif ListLen(arguments.division_id) NEQ 0> 
			JOIN zmast.lk_division zlkd ON zlkd.id = #arguments.division_id#
		</cfif>
	WHERE
		<cfif ListLen(arguments.division_id) NEQ 0>
			c.DivisionID = zlkd.#getLeagueYear.leagueCodeYear#id AND 
		</cfif>
		a.leaguecode = '#arguments.league_code#'
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
<!--- <cfdump var="#QGoalsScoredUnion_query#"><cfabort> --->
<!--- <cfoutput>#QGoalsScoredUnion_query.recordcount#</cfoutput> --->
<cfquery name="QGoalsScored_query" dbtype="query" maxrows="10">
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

<!---<cfdump var="#QGoalsScored_query#"><cfabort>--->

<cfif IsDefined("QGoalsScored_query") AND QGoalsScored_query.recordCount GT 0>
	<cfset i=1>
	<cfloop query="QGoalsScored_query">
		<cfinclude template="QCurrentTeam_query.cfm">
		<cfscript>
			QLeagueLeadingGoalScorers[#i#]							= StructNew();
			QLeagueLeadingGoalScorers[#i#].team_name				= #TeamName#;
			QLeagueLeadingGoalScorers[#i#].ordinal_name				= #OrdinalName#;
			QLeagueLeadingGoalScorers[#i#].most_recent_date_played	= DateFormat(#mostRecentDatePlayed#,'yyyy-mm-dd');
			QLeagueLeadingGoalScorers[#i#].player_id				= #playerid#;
			QLeagueLeadingGoalScorers[#i#].player_last_name			= #surname#;
			QLeagueLeadingGoalScorers[#i#].player_first_name		= #forename#;
			QLeagueLeadingGoalScorers[#i#].played					= #gamesPlayed#;
			QLeagueLeadingGoalScorers[#i#].goals					= #goals#;
			QLeagueLeadingGoalScorers[#i#].division					= #QCurrentTeam.divisionID#;
			QLeagueLeadingGoalScorers[#i#].division_name			= #QCurrentTeam.divisionname#;
			QLeagueLeadingGoalScorers[#i#].team_id					= #QCurrentTeam.TeamID#;
			i++;
		</cfscript>
	</cfloop>
	<cfif i IS 1>
		<cfscript>
		QLeagueLeadingGoalScorers[#i#] = StructNew();
		i++;
	</cfscript>
	</cfif>
<cfelse>
	<cfset i=1>
	<!-- add message in here somewhere -->
	<cfscript>
		QLeagueLeadingGoalScorers[#i#] = StructNew();
		i++;
	</cfscript>
</cfif>	

<!---<cfdump var="#QLeagueLeadingGoalScorers#">--->