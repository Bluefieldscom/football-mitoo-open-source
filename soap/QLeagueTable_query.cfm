<!--- called from getLeagueTableByDivisionId method of webServices.cfc --->
<cfinclude template="QgetLeagueYearFromDates.cfm">

<cfquery name="QLeagueTable_query" datasource="#variables.dsn#">
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
		o.LongCol as gr_ordinal_name
	FROM
		leaguetable AS l
	INNER JOIN constitution AS c ON c.ID=l.ConstitutionID
	INNER JOIN ordinal AS o ON o.ID=c.OrdinalID
	WHERE
		l.DivisionID = #arguments.mitoo_division_id#
	ORDER BY
		l.Rank
</cfquery>

<cfif QLeagueTable_query.recordCount GT 0>
<cfset i=1>
	<cfscript>
		variables.startlimit = GetToken(#arguments.limit#,1,",");
		if (variables.startlimit EQ '0')
			variables.startlimit = 1;
		variables.endlimit = GetToken(#arguments.limit#,2,",");
		if (variables.endlimit EQ '0')
			variables.endlimit = 1;
		i++; //initiated before query in leagueTab.cfm
	</cfscript>
	
	<cfloop query="QLeagueTable_query" startRow = "#variables.startlimit#" endRow = "#variables.endlimit#">
		<cfscript>
			QLeagueTable[#i#] = StructNew();
			QLeagueTable[#i#].mitoo_constitution_id		 		= #ConstitutionID#;
			QLeagueTable[#i#].mitoo_team_id 					= #mitoo_team_id#;
			QLeagueTable[#i#].league_table_points_adjust 		= #PointsAdjustment#;
			QLeagueTable[#i#].gr_team_name 						= #Name#;
			QLeagueTable[#i#].gr_ordinal_name 					= #gr_ordinal_name#;
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

<cfelse>
	<cfset i=1>
	<cfscript>
		QLeagueTable[#i#] = StructNew();
		i++;
	</cfscript>


</cfif>
