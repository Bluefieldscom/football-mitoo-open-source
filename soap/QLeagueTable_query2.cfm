<!--- called from getDivisionTable method of webServices2.cfc --->

<!---
<cfset arguments.division_id = '2310'>
<cfset arguments.start_date = '2009-09-01'>
<cfset arguments.end_date   = '2009-09-30'>
<cfset arguments.limit     = '20'>

<cfquery name="QgetLeagueCode" datasource="zmast">
	SELECT leaguecode FROM lk_division where id = #arguments.division_id#
</cfquery>

<cfif IsDefined("QgetLeagueCode") AND QgetLeagueCode.recordCount GT 0> 
	<cfset arguments.league_code = QgetLeagueCode.leaguecode>
<cfelse>
	<cfset arguments.league_code = ''>
</cfif>
--->
<!---
<cfinclude template="QgetLeagueYearFromDates2.cfm">
--->
<!---
<cfinclude template="QgetLeagueYearFromDates3.cfm">
<cfif inSeason IS 0>
	<cfscript> QFixtures[1] = StructNew(); </cfscript>
	<cfreturn QFixtures>
</cfif>	
--->

<cfset HideGoals           = "No">
<cfset HideGoalDiff        = "No"> 
<cfset HideDivision        = "No">
<cfset SuppressTable       = "No">
<cfset SuppressLeagueTable = "No">
<cfset ThisIsKO            = "No">

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

<cfif SuppressTable IS "No" AND SuppressLeagueTable IS "No" AND HideDivision IS "No" AND ThisIsKO IS "No">
	<cfquery name="QLeagueTable_query" datasource="#variables.dsn#">
	SELECT
		zmlkc.id AS team_id,
		t.longcol AS temp_name,
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
		l.AwayPointsAdjust
	FROM
		fm#getLeagueYear.leagueCodeYear#.leaguetable 			 AS l
		INNER JOIN fm#getLeagueYear.leagueCodeYear#.constitution AS c ON c.ID=l.ConstitutionID
		INNER JOIN fm#getLeagueYear.leagueCodeYear#.team         AS t ON t.ID=c.teamid
		INNER JOIN fm#getLeagueYear.leagueCodeYear#.division 	 AS d1 ON c.DivisionID = d1.ID
	
		LEFT JOIN zmast.lk_constitution 	AS zmlkc ON zmlkc.#getLeagueYear.leagueCodeYear#id = c.ID
		LEFT JOIN zmast.lk_division 		AS zmlkd ON zmlkd.#getLeagueYear.leagueCodeYear#id = d1.ID
	WHERE
		l.DivisionID = zmlkd.#getLeagueYear.leagueCodeYear#id
		AND zmlkd.id = #arguments.division_id#
	ORDER BY
		l.Rank
	LIMIT #arguments.limit#;

	</cfquery>
</cfif>
<!---<cfoutput>#variables.dsn#</cfoutput>
<cfoutput>#inseason#</cfoutput>--->
<cfif IsDefined("QLeagueTable_query") AND QLeagueTable_query.recordCount GT 0>
<cfset i=1>
	
	<cfloop query="QLeagueTable_query">
		<cfscript>
			QLeagueTable[#i#] = StructNew();
			QLeagueTable[#i#].team_id	 						= #team_id#;
			QLeagueTable[#i#].temp_name	 						= #temp_name#;
	
			QLeagueTable[#i#].league_table_points_adjust 		= #PointsAdjustment#;
			QLeagueTable[#i#].league_table_home_games_played 	= #HomeGamesPlayed#;
			QLeagueTable[#i#].league_table_home_games_won 		= #HomeGamesWon#;
			QLeagueTable[#i#].league_table_home_games_lost	 	= #HomeGamesLost#;
			QLeagueTable[#i#].league_table_home_games_drawn 	= #HomeGamesDrawn#;
			if (HideGoals IS "Yes") {
				QLeagueTable[#i#].league_table_home_goals_for	 	= '*';
				QLeagueTable[#i#].league_table_home_goals_against 	= '*';
			}else{	
				QLeagueTable[#i#].league_table_home_goals_for	 	= #HomeGoalsFor#;
				QLeagueTable[#i#].league_table_home_goals_against 	= #HomeGoalsAgainst#;
			}
			QLeagueTable[#i#].league_table_home_points		 	= #HomePoints#;
			QLeagueTable[#i#].league_table_home_points_adjust 	= #HomePointsAdjust#;
			
			QLeagueTable[#i#].league_table_away_games_played 	= #AwayGamesPlayed#;
			QLeagueTable[#i#].league_table_away_games_won 		= #AwayGamesWon#;
			QLeagueTable[#i#].league_table_away_games_lost	 	= #AwayGamesLost#;
			QLeagueTable[#i#].league_table_away_games_drawn 	= #AwayGamesDrawn#;
			if (HideGoals IS "Yes") {
				QLeagueTable[#i#].league_table_away_goals_for	 	= '*';
				QLeagueTable[#i#].league_table_away_goals_against 	= '*';
			}else{
				QLeagueTable[#i#].league_table_away_goals_for	 	= #AwayGoalsFor#;
				QLeagueTable[#i#].league_table_away_goals_against 	= #AwayGoalsAgainst#;
			}
			QLeagueTable[#i#].league_table_away_points		 	= #AwayPoints#;
			QLeagueTable[#i#].league_table_away_points_adjust 	= #AwayPointsAdjust#;
			i++;
		</cfscript>
	</cfloop>

<cfelse>
	<cfset i=1>
	<!-- add message in here somewhere -->
	<cfscript>
		QLeagueTable[#i#] = StructNew();
		i++;
	</cfscript>


</cfif>
<!---<cfdump var="#Qleaguetable#">--->