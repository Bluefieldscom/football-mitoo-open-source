<!--- called from getFormByDivisionIDAndDate in webServices.cfc --->

<cfinclude template="QgetLeagueYearFromDates2.cfm">

<cfquery name="QLeagueTableComponentsTeam_query" datasource="#variables.dsn#">
	SELECT
		zlkc1.id as team_id,
		
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#arguments.start_date#' AND '#arguments.end_date#') AND f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result IS NULL) as CountHomeGamesPlayed,
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#arguments.start_date#' AND '#arguments.end_date#') AND f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result IS NULL) as CountAwayGamesPlayed,
	
	
		(SELECT COALESCE(SUM(f.HomeGoals),0) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#arguments.start_date#' AND '#arguments.end_date#') AND f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result IS NULL) as SumHomeGoalsFor,
		(SELECT COALESCE(SUM(f.AwayGoals),0) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#arguments.start_date#' AND '#arguments.end_date#') AND f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result IS NULL) as SumAwayGoalsFor,
		(SELECT COALESCE(SUM(f.HomeGoals),0) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#arguments.start_date#' AND '#arguments.end_date#') AND f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result IS NULL) as SumHomeGoalsAgainst,
		(SELECT COALESCE(SUM(f.AwayGoals),0) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#arguments.start_date#' AND '#arguments.end_date#') AND f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result IS NULL) as SumAwayGoalsAgainst,
			
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#arguments.start_date#' AND '#arguments.end_date#') AND f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals > f.AwayGoals) as CountHomeWins,
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#arguments.start_date#' AND '#arguments.end_date#') AND f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals < f.AwayGoals) as CountAwayWins,
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#arguments.start_date#' AND '#arguments.end_date#') AND f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals = f.AwayGoals) as CountHomeDraws,
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#arguments.start_date#' AND '#arguments.end_date#') AND f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals = f.AwayGoals) as CountAwayDraws,				
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#arguments.start_date#' AND '#arguments.end_date#') AND f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals < f.AwayGoals) as CountHomeDefeats,
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#arguments.start_date#' AND '#arguments.end_date#') AND f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals > f.AwayGoals) as CountAwayDefeats

	FROM
		fm#getLeagueYear.leagueCodeYear#.constitution AS c
		INNER JOIN zmast.lk_constitution zlkc1 ON zlkc1.id = '#arguments.team_id#'
	WHERE
		c.ID = zlkc1.#getLeagueYear.leagueCodeYear#id

	<cfif arguments.limit NEQ "" >
	LIMIT #arguments.limit#
	</cfif>
</cfquery>

<cfset i=1>
<cfloop query="QLeagueTableComponentsTeam_query">
	<cfscript>
		QLeagueTableComponents[#i#] = StructNew();
		QLeagueTableComponents[#i#].team_id 				= #team_id#;
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

