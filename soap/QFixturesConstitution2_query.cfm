<!--- called from getTeamFixtures method of webServices2.cfc --->
<!---
<cfset arguments.league_code = 'CHIS'>
<cfset arguments.team_id = '38267'>
<cfset arguments.start_date = '2009-09-01'>
<cfset arguments.end_date   = '2009-10-30'>
<cfset arguments.limit     = '20'>
<cfset arguments.order = 'DESC'>

<cfinclude template="QgetLeagueYearFromDates3.cfm">
<cfif inSeason IS 0>
	<cfscript> QFixtures[1] = StructNew(); </cfscript>
	<cfreturn QFixtures>
</cfif>	
--->

<cfquery name="QFixtures_query" datasource="#variables.dsn#">
	SELECT 
		f.ID as fixture_id,
		DATE_FORMAT(f.FixtureDate, '%Y-%m-%d') AS FixtureDate,
		f.Result,
		IF(f.Result IN('H','A','D') AND f.HomeGoals=0 AND f.AwayGoals=0, NULL,f.HomeGoals) as Homegoals,
		IF(f.Result IN('H','A','D') AND f.HomeGoals=0 AND f.AwayGoals=0, NULL,f.AwayGoals) as Awaygoals,
		v.LongCol as VenueName,
		zlkc1.ID as home_id,
		zlkc2.ID as away_id,
		t1.longcol as temp_home,
		t2.longcol as temp_away,
		ko.longcol AS knockout_desc,
		f.fixturenotes,
		zlkd.id AS umbrella_id,
		d1.longcol AS divisionname
	FROM
		fm#getLeagueYear.leagueCodeYear#.fixture f 
		
		INNER JOIN fm#getLeagueYear.leagueCodeYear#.koround ko ON ko.id=f.KORoundID
		
		INNER JOIN fm#getLeagueYear.leagueCodeYear#.constitution c1 ON c1.ID = f.HomeID
		INNER JOIN fm#getLeagueYear.leagueCodeYear#.team t1 ON t1.ID=c1.TeamID
		INNER JOIN fm#getLeagueYear.leagueCodeYear#.constitution c2 ON c2.ID = f.AwayID
		INNER JOIN fm#getLeagueYear.leagueCodeYear#.team t2 ON t2.ID=c2.TeamID
		INNER JOIN fm#getLeagueYear.leagueCodeYear#.division d1 ON c1.DivisionID = d1.ID
		<!--- new --->
		LEFT JOIN zmast.lk_division zlkd ON zlkd.#getLeagueYear.leagueCodeYear#id = d1.ID
		<!--- end new --->
		LEFT JOIN fm#getLeagueYear.leagueCodeYear#.pitchavailable pa ON pa.ID = f.pitchAvailableID
		LEFT JOIN fm#getLeagueYear.leagueCodeYear#.venue v on v.ID = pa.VenueID
	
		LEFT JOIN zmast.lk_constitution zlkc1 ON c1.ID = zlkc1.#getLeagueYear.leagueCodeYear#id
		LEFT JOIN zmast.lk_constitution zlkc2 ON c2.ID = zlkc2.#getLeagueYear.leagueCodeYear#id
	
		LEFT JOIN zmast.lk_constitution zlkc ON zlkc.id = '#arguments.team_id#'
	
	WHERE
		(c1.ID  = zlkc.#getLeagueYear.leagueCodeYear#id OR c2.ID  = zlkc.#getLeagueYear.leagueCodeYear#id )
	AND
		f.FixtureDate BETWEEN '#arguments.start_date#' AND '#arguments.end_date#'

AND d1.notes NOT REGEXP 'HideDivision'

	ORDER BY
		f.FixtureDate #arguments.order#
	<cfif arguments.limit NEQ "" >
	LIMIT #arguments.limit#
	</cfif>
	

</cfquery>
<cfset i=1>
<cfloop query="QFixtures_query">
	<cfscript>
		QFixtures[#i#] 						= StructNew();
		QFixtures[#i#].fixture_id 			= #fixture_id#;
		QFixtures[#i#].umbrella_id			= #umbrella_id#;			
		QFixtures[#i#].fixture_date 		= #FixtureDate#;
		QFixtures[#i#].fixture_venue_name 	= #VenueName#;
		
		QFixtures[#i#].fixture_result		= #Result#;
		QFixtures[#i#].fixture_home_goals	= #Homegoals#;
		QFixtures[#i#].fixture_away_goals	= #Awaygoals#;
		
		QFixtures[#i#].fixture_home_id 		= #home_id#;
		QFixtures[#i#].fixture_away_id 		= #away_id#;
		
		QFixtures[#i#].temp_home 			= #temp_home#;
		QFixtures[#i#].temp_away 			= #temp_away#;
		
		QFixtures[#i#].knockout_desc		= #knockout_desc#;
		QFixtures[#i#].fixture_notes		= #fixturenotes#;
		QFixtures[#i#].division_name		= #divisionname#;			
		
		i++;				
	</cfscript>
</cfloop>
<!---<cfdump var="#QFixtures#">--->