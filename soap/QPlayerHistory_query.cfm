<cfinclude template="QgetLeagueYearFromDates.cfm">

<cfquery name="QgetPlayerHistory" datasource="#variables.dsn#" result="QgetPlayerHistory_result">
	SELECT
		f.FixtureDate ,
		f.ID as FID ,
		
		f.Result ,
		f.HomeID ,
		f.AwayID ,
		f.HomeGoals ,
		f.AwayGoals ,
		t1.LongCol as HomeTeam ,
		t2.LongCol as AwayTeam ,
		t1.ID as HomeTeamID,
		t2.ID as AwayTeamID,
		o1.LongCol as HomeOrdinal ,
		o2.LongCol as AwayOrdinal ,
		d.LongCol as divisionname,
		d.shortcol as divisionprefix,
		c1.ID as HID ,
		c2.ID as AID ,
		a.GoalsScored ,
		a.HomeAway ,
		a.Card as cards,
		a.StarPlayer as starplayer
	FROM
		fixture AS f,
	
		constitution AS c1,
		constitution AS c2,
		team AS t1,
		team AS t2,
		ordinal AS o1,
		ordinal AS o2,
		division AS d,
		appearance AS a,
		player AS p
	WHERE
		c1.LeagueCode = '#arguments.leaguecode#'
		AND c2.LeagueCode = '#arguments.leaguecode#'
		AND p.ID = #arguments.player_id#
		AND c1.ID = HomeID 
		AND c2.ID = AwayID 
		AND t1.ID = c1.TeamID 
		AND t2.ID = c2.TeamID 
		AND o1.ID = c1.OrdinalID 
		AND o2.ID = c2.OrdinalID 
	
		AND d.ID = c1.DivisionID 
		AND a.FixtureID = f.ID 
		AND p.ID = a.PlayerID
	ORDER BY
		FixtureDate
</cfquery>



<cfset i=1>
<cfloop query="QgetPlayerHistory">
	<cfscript>
		QPlayerHistory[#i#] = StructNew();
		QPlayerHistory[#i#].mitoo_league_prefix     = #arguments.leaguecode#;
		QPlayerHistory[#i#].division_prefix 		= #divisionprefix#;
		QPlayerHistory[#i#].division_name 			= #divisionname#;		
		QPlayerHistory[#i#].home_team_name 			= #hometeam#;
		QPlayerHistory[#i#].home_team_ordinal 		= #homeOrdinal#;
		QPlayerHistory[#i#].away_team_name 			= #awayteam#;
		QPlayerHistory[#i#].away_team_ordinal 		= #awayOrdinal#;		
		QPlayerHistory[#i#].home_team_id 			= #HomeTeamID#;
		QPlayerHistory[#i#].away_team_id 			= #AwayTeamID#;		
		QPlayerHistory[#i#].fixture_home_goals		= #Homegoals#;
		QPlayerHistory[#i#].fixture_away_goals 		= #Awaygoals#;		
		QPlayerHistory[#i#].fixture_date 			= #FixtureDate#;
		QPlayerHistory[#i#].fixture_id 				= #FID#;
		QPlayerHistory[#i#].player_goals_scored 	= #goalsScored#;
		QPlayerHistory[#i#].player_home_away 		= #HomeAway#;
		QPlayerHistory[#i#].fixture_result			= #Result#;
		QPlayerHistory[#i#].fixture_cards			= #cards#;
		QPlayerHistory[#i#].fixture_starplayer		= #starplayer#;
		i++;
	</cfscript>
</cfloop>
