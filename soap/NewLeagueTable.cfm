
<cfset i=1>
<cfloop query="QNewLeagueTable" startRow = "#arguments.startlimit#" endRow = "#arguments.endlimit#">
	<cfscript>
		QLeagueTable[#i#] = StructNew();
		QLeagueTable[#i#].mitoo_constitution_id		 		= #ConstitutionID#;
		QLeagueTable[#i#].mitoo_team_id 					= #TeamID#;
		QLeagueTable[#i#].league_table_points_adjust 		= #PointsAdjustment#;
		QLeagueTable[#i#].gr_team_name 						= #Name#;
		QLeagueTable[#i#].gr_ordinal_name 					= '';
		QLeagueTable[#i#].league_table_home_games_played 	= #HomeGamesPlayed#;
		QLeagueTable[#i#].league_table_home_games_won 		= #HomeGamesWon#;
		QLeagueTable[#i#].league_table_home_games_lost	 	= #HomeGamesLost#;
		QLeagueTable[#i#].league_table_home_games_drawn 	= #HomeGamesDrawn#;
		QLeagueTable[#i#].league_table_home_goals_for	 	= #HomeGoalsFor#;
		QLeagueTable[#i#].league_table_home_goals_against 	= #HomeGoalsAgainst#;
		QLeagueTable[#i#].league_table_home_points		 	= #HomePoints#;
		QLeagueTable[#i#].league_table_home_points_adjust 	= #HomePointsAdjust#;
		
		QLeagueTable[#i#].league_table_away_games_played 	= #AwayGamesPlayed#;
		QLeagueTable[#i#].league_table_away_games_won 		= #AwayGamesWon#;
		QLeagueTable[#i#].league_table_away_games_lost	 	= #AwayGamesLost#;
		QLeagueTable[#i#].league_table_away_games_drawn 	= #AwayGamesDrawn#;
		QLeagueTable[#i#].league_table_away_goals_for	 	= #AwayGoalsFor#;
		QLeagueTable[#i#].league_table_away_goals_against 	= #AwayGoalsAgainst#;
		QLeagueTable[#i#].league_table_away_points		 	= #AwayPoints#;
		QLeagueTable[#i#].league_table_away_points_adjust 	= #AwayPointsAdjust#;
		i++;
	</cfscript>
</cfloop>
<cfdump var="#QleagueTable#">

