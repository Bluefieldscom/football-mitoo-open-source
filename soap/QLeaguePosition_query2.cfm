<!--- called from getTeamTablePosition method of webServices2.cfc --->

<cfinclude template="QgetLeagueYearFromDates2.cfm">

<cfset HideGoals           = "No">
<cfset HideGoalDiff        = "No"> 
<cfset HideDivision        = "No">
<cfset SuppressTable       = "No">
<cfset SuppressLeagueTable = "No">
<cfset ThisIsKO            = "No">

<cfquery name="QFindDivFromTeamID" datasource="#variables.dsn#">
	SELECT lkd.id AS divisionid
	FROM 
		zmast.lk_constitution lkc 
		JOIN fm#getLeagueYear.leagueCodeYear#.constitution c 
			ON lkc.#getLeagueYear.leagueCodeYear#id = c.id
		JOIN fm#getLeagueYear.leagueCodeYear#.division d 
			ON d.id = c.divisionid
		JOIN zmast.lk_division lkd 
			ON lkd.#getLeagueYear.leagueCodeYear#id = d.id
	WHERE 
		lkc.id = <cfqueryparam value = #arguments.team_id# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>

<cfif QFindDivFromTeamID.RecordCount GT 0>

	<cfset arguments.division_id = QFindDivFromTeamID.divisionid>
	<cfinclude template="QKnockOut_query2.cfm">
	
	<cfif Left(QKnockOut.Notes,2) IS "KO" >
		<!--Cannot produce a result grid for Knockout competitions-->
		<cfset ThisIsKO = "Yes">
	</cfif>
	<!--- messages should be added --->
	<!--- HideGoals will suppress Goals For, Goals Against and Goal Difference columns --->
	<cfif Find( "HideGoals", QKnockOut.Notes )>
		<cfset HideGoals = "Yes">
		<!-- message -->
	</cfif>
	<!--- HideGoalDiff will suppress Goal Difference columns --->
	<cfif Find( "HideGoalDiff", QKnockOut.Notes )>
		<cfset HideGoalDiff = "Yes">
		<!-- message -->
	</cfif>
	<!--- HideDivision will suppress everything for this Division --->
	<cfif Find( "HideDivision", QKnockOut.Notes )>
		<cfset HideDivision = "Yes">
		<!-- message -->
	</cfif>
	<cfif Find( "SuppressTable", QKnockOut.Notes )>
		<cfset SuppressTable = "Yes">
		<!-- message -->
	</cfif>
	<cfif QKnockOut.CompetitionDescription IS "Miscellaneous" OR QKnockOut.CompetitionDescription IS "Friendly" >
		<cfset SuppressLeagueTable = "Yes">
		<!-- message -->
	</cfif>
</cfif>

<cfif SuppressTable IS "No" AND SuppressLeagueTable IS "No" AND HideDivision IS "No" AND ThisIsKO IS "No">
	<cfquery name="QLeaguePosition_query" datasource="#variables.dsn#">
	 SELECT
			zmlkc.ID AS team_id,
			l.PointsAdjustment,
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
			l.Rank AS POSITION
		FROM
			fm#getLeagueYear.leagueCodeYear#.leaguetable 				AS l
			LEFT JOIN fm#getLeagueYear.leagueCodeYear#.constitution 	AS c ON c.ID = l.ConstitutionID
			INNER JOIN zmast.lk_constitution	AS zmlkc ON zmlkc.#getLeagueYear.leagueCodeYear#id = c.ID
		WHERE
			zmlkc.id = #arguments.team_id# 
	
	</cfquery>

</cfif>

<cfif IsDefined("QLeaguePosition_query") AND QLeaguePosition_query.recordCount GT 0>
	<cfset i=1>
	<cfloop query="QLeaguePosition_query">
		<cfscript>
			QLeaguePosition[#i#] = StructNew();
			QLeaguePosition[#i#].team_id		 					= #team_id#;
			QLeaguePosition[#i#].league_table_position				= #Position#;
			QLeaguePosition[#i#].league_table_points_adjust 		= #PointsAdjustment#;
			QLeaguePosition[#i#].league_table_home_games_played 	= #HomeGamesPlayed#;
			QLeaguePosition[#i#].league_table_home_games_won 		= #HomeGamesWon#;
			QLeaguePosition[#i#].league_table_home_games_lost	 	= #HomeGamesLost#;
			QLeaguePosition[#i#].league_table_home_games_drawn 		= #HomeGamesDrawn#;
			if (HideGoals IS "Yes") {
				QLeaguePosition[#i#].league_table_home_goals_for	 	= "*";
				QLeaguePosition[#i#].league_table_home_goals_against 	= "*";
			} else {
				QLeaguePosition[#i#].league_table_home_goals_for	 	= #HomeGoalsFor#;
				QLeaguePosition[#i#].league_table_home_goals_against 	= #HomeGoalsAgainst#;
			}
			QLeaguePosition[#i#].league_table_home_points		 	= #HomePoints#;
			QLeaguePosition[#i#].league_table_home_points_adjust 	= #HomePointsAdjust#;
			
			QLeaguePosition[#i#].league_table_away_games_played 	= #AwayGamesPlayed#;
			QLeaguePosition[#i#].league_table_away_games_won 		= #AwayGamesWon#;
			QLeaguePosition[#i#].league_table_away_games_lost	 	= #AwayGamesLost#;
			QLeaguePosition[#i#].league_table_away_games_drawn 		= #AwayGamesDrawn#;
			if (HideGoals IS "Yes") {
				QLeaguePosition[#i#].league_table_away_goals_for	 	= "*";
				QLeaguePosition[#i#].league_table_away_goals_against 	= "*";
			} else {
				QLeaguePosition[#i#].league_table_away_goals_for	 	= #AwayGoalsFor#;
				QLeaguePosition[#i#].league_table_away_goals_against 	= #AwayGoalsAgainst#;
			}
			QLeaguePosition[#i#].league_table_away_points		 	= #AwayPoints#;
			QLeaguePosition[#i#].league_table_away_points_adjust 	= #AwayPointsAdjust#;
			i++;
		</cfscript>
	</cfloop>
<cfelse>
	<cfset i=1>
	<!-- add message in here somewhere -->
	<cfscript>
		QLeaguePosition[#i#] = StructNew();
		i++;
	</cfscript>
</cfif>