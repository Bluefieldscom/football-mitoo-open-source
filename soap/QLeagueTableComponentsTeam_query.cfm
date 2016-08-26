<!--- called from getFormByDivisionIDAndDate in webServices.cfc --->

<cfinclude template="QgetLeagueYearFromDates.cfm">

<cfquery name="QLeagueTableComponentsTeam_query" datasource="#variables.dsn#">
	SELECT
		c.ID as CIdentity,
		c.TeamID as TeamID,
		
		(SELECT LongCol FROM team WHERE ID = c.TeamID) as ClubName,
		(SELECT LongCol FROM ordinal WHERE ID = c.OrdinalID) as OrdinalName,
		(SELECT ID FROM ordinal WHERE ID = c.OrdinalID) as OrdinalID,
			
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#arguments.startDate#' AND '#arguments.endDate#') AND f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result IS NULL) as CountHomeGamesPlayed,
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#arguments.startDate#' AND '#arguments.endDate#') AND f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result IS NULL) as CountAwayGamesPlayed,
	
	
		(SELECT COALESCE(SUM(f.HomeGoals),0) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#arguments.startDate#' AND '#arguments.endDate#') AND f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result IS NULL) as SumHomeGoalsFor,
		(SELECT COALESCE(SUM(f.AwayGoals),0) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#arguments.startDate#' AND '#arguments.endDate#') AND f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result IS NULL) as SumAwayGoalsFor,
		(SELECT COALESCE(SUM(f.HomeGoals),0) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#arguments.startDate#' AND '#arguments.endDate#') AND f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result IS NULL) as SumHomeGoalsAgainst,
		(SELECT COALESCE(SUM(f.AwayGoals),0) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#arguments.startDate#' AND '#arguments.endDate#') AND f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result IS NULL) as SumAwayGoalsAgainst,
			
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#arguments.startDate#' AND '#arguments.endDate#') AND f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals > f.AwayGoals) as CountHomeWins,
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#arguments.startDate#' AND '#arguments.endDate#') AND f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals < f.AwayGoals) as CountAwayWins,
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#arguments.startDate#' AND '#arguments.endDate#') AND f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals = f.AwayGoals) as CountHomeDraws,
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#arguments.startDate#' AND '#arguments.endDate#') AND f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals = f.AwayGoals) as CountAwayDraws,				
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#arguments.startDate#' AND '#arguments.endDate#') AND f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals < f.AwayGoals) as CountHomeDefeats,
		(SELECT COUNT(f.ID) FROM fixture AS f WHERE  (FixtureDate BETWEEN '#arguments.startDate#' AND '#arguments.endDate#') AND f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals > f.AwayGoals) as CountAwayDefeats
	FROM
		constitution AS c
	WHERE
		c.ID = '#arguments.mitoo_constitution_id#'

	<cfif arguments.limit NEQ "" >
	LIMIT #arguments.limit#
	</cfif>
</cfquery>

<cfset i=1>
<cfloop query="QLeagueTableComponentsTeam_query">
	<cfscript>
		QLeagueTableComponents[#i#] = StructNew();
		QLeagueTableComponents[#i#].mitoo_team_id 			= #TeamID#;
		QLeagueTableComponents[#i#].mitoo_constitution_id 	= #CIdentity#;
		QLeagueTableComponents[#i#].gr_team_name 			= #ClubName#;
		QLeagueTableComponents[#i#].gr_ordinal_name 		= #OrdinalName#;
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

