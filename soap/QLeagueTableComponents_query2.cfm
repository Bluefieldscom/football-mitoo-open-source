<!--- called from getDivisionForm in webServices.cfc --->

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
<!-- messages should be added -->
<!-- HideGoals will suppress Goals For, Goals Against and Goal Difference columns -->
<cfif Find( "HideGoals", QKnockOut.Notes )>
	<cfset HideGoals = "Yes">
	<!-- message -->
</cfif>
<!-- HideGoalDiff will suppress Goal Difference columns -->
<cfif Find( "HideGoalDiff", QKnockOut.Notes )>
	<cfset HideGoalDiff = "Yes">
	<!-- message -->
</cfif>
<!-- HideDivision will suppress everything for this Division -->
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
	<cfquery name="QLeagueTableComponents_query" datasource="#variables.dsn#">
		SELECT
			zlkc1.id as team_id,
			t.longcol as temp_team,
				
			(SELECT COUNT(f.ID) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#arguments.start_date#' AND '#arguments.end_date#') 
				AND f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result IS NULL) as CountHomeGamesPlayed,
			(SELECT COUNT(f.ID) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#arguments.start_date#' AND '#arguments.end_date#') 
				AND f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result IS NULL) as CountAwayGamesPlayed,
		
		
			(SELECT COALESCE(SUM(f.HomeGoals),0) FROM fixture AS f 
				WHERE  (FixtureDate BETWEEN '#arguments.start_date#' AND '#arguments.end_date#') 
				AND f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result IS NULL) as SumHomeGoalsFor,
			(SELECT COALESCE(SUM(f.AwayGoals),0) FROM fixture AS f 
				WHERE  (FixtureDate BETWEEN '#arguments.start_date#' AND '#arguments.end_date#') 
				AND f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result IS NULL) as SumAwayGoalsFor,
			(SELECT COALESCE(SUM(f.HomeGoals),0) FROM fixture AS f 
				WHERE  (FixtureDate BETWEEN '#arguments.start_date#' AND '#arguments.end_date#') 
				AND f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result IS NULL) as SumHomeGoalsAgainst,
			(SELECT COALESCE(SUM(f.AwayGoals),0) FROM fixture AS f 
				WHERE  (FixtureDate BETWEEN '#arguments.start_date#' AND '#arguments.end_date#') 
				AND f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result IS NULL) as SumAwayGoalsAgainst,
				
			(SELECT COUNT(f.ID) FROM fixture AS f 
				WHERE  (FixtureDate BETWEEN '#arguments.start_date#' AND '#arguments.end_date#') AND f.HomeID = c.ID 
				AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals > f.AwayGoals) as CountHomeWins,
			(SELECT COUNT(f.ID) FROM fixture AS f 
				WHERE  (FixtureDate BETWEEN '#arguments.start_date#' AND '#arguments.end_date#') 
				AND f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals < f.AwayGoals) as CountAwayWins,
			(SELECT COUNT(f.ID) FROM fixture AS f 
				WHERE  (FixtureDate BETWEEN '#arguments.start_date#' AND '#arguments.end_date#') 
				AND f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals = f.AwayGoals) as CountHomeDraws,
			(SELECT COUNT(f.ID) FROM fixture AS f 
				WHERE  (FixtureDate BETWEEN '#arguments.start_date#' AND '#arguments.end_date#') 
				AND f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals = f.AwayGoals) as CountAwayDraws,				
			(SELECT COUNT(f.ID) FROM fixture AS f 
				WHERE  (FixtureDate BETWEEN '#arguments.start_date#' AND '#arguments.end_date#') 
				AND f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals < f.AwayGoals) as CountHomeDefeats,
			(SELECT COUNT(f.ID) FROM fixture AS f 
				WHERE  (FixtureDate BETWEEN '#arguments.start_date#' AND '#arguments.end_date#') 
				AND f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals > f.AwayGoals) as CountAwayDefeats
	
		FROM
			fm#getLeagueYear.leagueCodeYear#.constitution AS c
			INNER JOIN fm#getLeagueYear.leagueCodeYear#.team AS t ON t.id=c.teamid
			LEFT JOIN zmast.lk_constitution zlkc1 ON c.ID = zlkc1.#getLeagueYear.leagueCodeYear#id
			LEFT JOIN zmast.lk_division zlkd ON zlkd.id = '#arguments.division_id#'
			
		WHERE
			c.DivisionID = zlkd.#getLeagueYear.leagueCodeYear#id
			
		<cfif arguments.limit NEQ "" >
		LIMIT #arguments.limit#
		</cfif>
	</cfquery>
</cfif>

<cfif IsDefined("QLeagueTableComponents_query") AND QLeagueTableComponents_query.recordCount GT 0>
	<!---<cfdump var="#QLeagueTableComponents_query#">--->
	<cfset i=1>
	<cfloop query="QLeagueTableComponents_query">
		<cfscript>
		QLeagueTableComponents[#i#] = StructNew();
		QLeagueTableComponents[#i#].team_id 				= #team_id#;
		QLeagueTableComponents[#i#].temp_team				= #temp_team#;
		QLeagueTableComponents[#i#].form_home_games_played	= #CountHomeGamesPlayed#;
		QLeagueTableComponents[#i#].form_away_games_played 	= #CountAwayGamesPlayed#;
		
		QLeagueTableComponents[#i#].form_home_goals_for 	= #SumHomeGoalsFor#;
		QLeagueTableComponents[#i#].form_away_goals_for 	= #SumAwayGoalsFor#;
		QLeagueTableComponents[#i#].form_home_goals_against	= #SumHomeGoalsAgainst#;
		QLeagueTableComponents[#i#].form_away_goals_against	= #SumAwayGoalsAgainst#;
		
		QLeagueTableComponents[#i#].form_home_wins 			= #CountHomeWins#;
		QLeagueTableComponents[#i#].form_away_wins 			= #CountAwayWins#;
		QLeagueTableComponents[#i#].form_home_draws 		= #CountHomeDraws#;
		QLeagueTableComponents[#i#].form_away_draws 		= #CountAwayDraws#;
		QLeagueTableComponents[#i#].form_home_defeats 		= #CountHomeDefeats#;
		QLeagueTableComponents[#i#].form_away_defeats		= #CountAwayDefeats#;
		i++;
	</cfscript>
	</cfloop>
<cfelse>
	<cfset i=1>
	<!-- add message in here somewhere -->
	<cfscript>
		QLeagueTableComponents[#i#] = StructNew();
		i++;
	</cfscript>
</cfif>

