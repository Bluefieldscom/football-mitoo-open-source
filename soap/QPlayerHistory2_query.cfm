<!---
<cfset arguments.player_id = 568169>
<cfset arguments.start_date  = '2010-08-01'>
<cfset arguments.end_date    = '2011-05-30'>
<cfset arguments.league_code = 'HAYS'>
<cfinclude template="QgetLeagueYearFromDates3.cfm">
--->

<!--- called by getPlayerAppearances function of webServices2.cfc --->

<cfquery name="QgetPlayerHistory" datasource="#variables.dsn#" result="QgetPlayerHistory_result">
	SELECT
		p.id as playerid,
		p.mediumCol as DOB,
		p.forename,
		p.surname,
		DATE_FORMAT(f.FixtureDate, '%Y-%m-%d') AS FixtureDate ,
		f.ID as FID ,
		f.HomeGoals ,
		f.AwayGoals ,
		t1.LongCol as home_temp ,
		t2.LongCol as away_temp ,
		zlkc1.ID as home_id,
		zlkc2.ID as away_id,
		a.GoalsScored ,
		a.HomeAway ,
		a.Card as cards,
		a.StarPlayer as starplayer
	FROM
		fm#getLeagueYear.leagueCodeYear#.appearance a
		
	INNER JOIN fm#getLeagueYear.leagueCodeYear#.fixture f ON f.id=a.fixtureid
	INNER JOIN fm#getLeagueYear.leagueCodeYear#.player p ON p.id=a.playerid
	
	INNER JOIN fm#getLeagueYear.leagueCodeYear#.constitution c1 ON c1.id=f.homeid
	INNER JOIN fm#getLeagueYear.leagueCodeYear#.team t1 ON t1.id=c1.teamid
	
	INNER JOIN fm#getLeagueYear.leagueCodeYear#.constitution c2 ON c2.id=f.awayid
	INNER JOIN fm#getLeagueYear.leagueCodeYear#.team t2 ON t2.id=c2.teamid
	
	LEFT JOIN zmast.lk_constitution zlkc1 ON c1.ID = zlkc1.#getLeagueYear.leagueCodeYear#id
	LEFT JOIN zmast.lk_constitution zlkc2 ON c2.ID = zlkc2.#getLeagueYear.leagueCodeYear#id
	
	WHERE
		p.ID = #arguments.player_id#
	ORDER BY
		f.FixtureDate
</cfquery>

<cfset i=1>
<cfloop query="QgetPlayerHistory">
	<cfscript>
		QPlayerHistory[#i#] = StructNew();
		QPlayerHistory[#i#].home_temp 				= #home_temp#;
		QPlayerHistory[#i#].away_temp 				= #away_temp#;
		QPlayerHistory[#i#].fixture_home_goals		= #Homegoals#;
		QPlayerHistory[#i#].fixture_away_goals 		= #Awaygoals#;		
		QPlayerHistory[#i#].fixture_date 			= #FixtureDate#;
		QPlayerHistory[#i#].fixture_id 				= #FID#;
		QPlayerHistory[#i#].player_goals_scored 	= #goalsScored#;
		QPlayerHistory[#i#].player_home_away 		= #HomeAway#;
		QPlayerHistory[#i#].fixture_cards			= #cards#;
		QPlayerHistory[#i#].fixture_starplayer		= #starplayer#;
		QPlayerHistory[#i#].player_forename			= #forename#;
		QPlayerHistory[#i#].player_surname			= #surname#;
		QPlayerHistory[#i#].player_dob				= #DOB#;
		QPlayerHistory[#i#].player_id				= #playerid#;
		QPlayerHistory[#i#].fixture_home_team_id	= #home_id#;
		QPlayerHistory[#i#].fixture_away_team_id	= #away_id#;
		QPlayerHistory[#i#].player_homeaway			= #HomeAway#;
		i++;
	</cfscript>
</cfloop>


