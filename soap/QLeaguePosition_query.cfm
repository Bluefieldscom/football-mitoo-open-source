<!--- called from getLeaguePositionByConstitutionId method of webServices.cfc --->

<cfinclude template="QgetLeagueYearFromDates.cfm">

<cfquery name="QLeaguePosition_query" datasource="#variables.dsn#">
	SELECT
		l.ConstitutionID,
		l.TeamID as mitoo_team_id,
		l.PointsAdjustment,
		l.Name,
		l.Special,
		l.HomeGamesPlayed,
		l.HomeGamesWon,
		l.HomeGamesDrawn,
		l.HomeGamesLost,
		l.HomeGoalsFor,
		l.HomeGoalsAgainst,
		l.HomePoints,
		l.HomePointsAdjust,
		l.AwayGamesPlayed,
		l.AwayGamesWon,
		l.AwayGamesDrawn,
		l.AwayGamesLost,
		l.AwayGoalsFor,
		l.AwayGoalsAgainst,
		l.AwayPoints,
		l.AwayPointsAdjust,
		o.LongCol as gr_ordinal_name,
		l.Rank AS Position
	FROM
		leaguetable AS l
	INNER JOIN constitution AS c ON c.ID=l.ConstitutionID
	INNER JOIN ordinal AS o ON o.ID=c.OrdinalID
	WHERE
		l.DivisionID = #arguments.mitoo_division_id#
	AND 
		l.ConstitutionID = #arguments.mitoo_constitution_id#
	ORDER BY
		l.Rank 
	LIMIT 1

	
</cfquery>
<cfset i=1>
<cfloop query="QLeaguePosition_query">
	<cfscript>
		QLeaguePosition[#i#] = StructNew();
		QLeaguePosition[#i#].mitoo_constitution_id		 		= #ConstitutionID#;
		QLeaguePosition[#i#].mitoo_team_id 						= #mitoo_team_id#;
		QLeaguePosition[#i#].league_table_position				= #Position#;
		QLeaguePosition[#i#].league_table_points_adjust 		= #PointsAdjustment#;
		QLeaguePosition[#i#].gr_team_name 						= #Name#;
		QLeaguePosition[#i#].gr_ordinal_name 					= #gr_ordinal_name#;
		QLeaguePosition[#i#].league_table_home_games_played 	= #HomeGamesPlayed#;
		QLeaguePosition[#i#].league_table_home_games_won 		= #HomeGamesWon#;
		QLeaguePosition[#i#].league_table_home_games_lost	 	= #HomeGamesLost#;
		QLeaguePosition[#i#].league_table_home_games_drawn 		= #HomeGamesDrawn#;
		QLeaguePosition[#i#].league_table_home_goals_for	 	= #HomeGoalsFor#;
		QLeaguePosition[#i#].league_table_home_goals_against 	= #HomeGoalsAgainst#;
		QLeaguePosition[#i#].league_table_home_points		 	= #HomePoints#;
		QLeaguePosition[#i#].league_table_home_points_adjust 	= #HomePointsAdjust#;
		
		QLeaguePosition[#i#].league_table_away_games_played 	= #AwayGamesPlayed#;
		QLeaguePosition[#i#].league_table_away_games_won 		= #AwayGamesWon#;
		QLeaguePosition[#i#].league_table_away_games_lost	 	= #AwayGamesLost#;
		QLeaguePosition[#i#].league_table_away_games_drawn 		= #AwayGamesDrawn#;
		QLeaguePosition[#i#].league_table_away_goals_for	 	= #AwayGoalsFor#;
		QLeaguePosition[#i#].league_table_away_goals_against 	= #AwayGoalsAgainst#;
		QLeaguePosition[#i#].league_table_away_points		 	= #AwayPoints#;
		QLeaguePosition[#i#].league_table_away_points_adjust 	= #AwayPointsAdjust#;
		i++;
	</cfscript>
</cfloop>
