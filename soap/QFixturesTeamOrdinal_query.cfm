<!--- called from getFixturesByDivisionIDAndDate method of webServices.cfc --->

<cfinclude template="QgetLeagueYearFromDates.cfm">

<cfquery name="QFixtures_query" datasource="#variables.dsn#">
	SELECT 
		t1.longcol as HomeTeam ,
		t2.longcol as AwayTeam ,

		t1.ID as HomeTeamID,
		t2.ID as AwayTeamID,

		o1.longcol as HomeOrdinal ,
		o2.longcol as AwayOrdinal ,

		d1.longcol as DivName1 ,
		d1.ID as DID ,

		f.MatchNumber as MatchNumber ,	
		f.FixtureDate as FixtureDate ,
		<!---f.Attendance , --->
		f.Result,
		IF(f.Result IN('H','A','D') AND f.HomeGoals=0 AND f.AwayGoals=0, NULL,f.HomeGoals) as Homegoals,
		IF(f.Result IN('H','A','D') AND f.HomeGoals=0 AND f.AwayGoals=0, NULL,f.AwayGoals) as Awaygoals,

		f.ID as FID,
		f.LeagueCode as LeagueCode,
		d1.MediumCol as SortOrder,
		f.pitchAvailableID,
		v.LongCol as VenueName,
		v.ID as VenueID,
		c1.ID as HomeConstitutionID,
		c2.ID as AwayConstitutionID
		
	FROM
		fixture f 
		LEFT JOIN koround k ON k.ID = f.KORoundID
		LEFT JOIN constitution c1 ON c1.ID = f.HomeID
		LEFT JOIN constitution c2 ON c2.ID = f.AwayID
		LEFT JOIN team t1 ON c1.TeamID = t1.ID
		LEFT JOIN team t2 ON c2.TeamID = t2.ID
		LEFT JOIN ordinal o1 ON c1.OrdinalID = o1.ID
		LEFT JOIN ordinal o2 ON c2.OrdinalID = o2.ID
		LEFT JOIN division d1 ON c1.DivisionID = d1.ID
		LEFT JOIN pitchavailable pa ON pa.ID = f.pitchAvailableID
		LEFT JOIN venue v on v.ID = pa.VenueID
	WHERE
		( (t1.ID  ='#arguments.mitoo_team_id#' AND o1.ID = '#arguments.mitoo_ordinal_id#') 
		
		OR (t2.ID  ='#arguments.mitoo_team_id#' AND o2.ID = '#arguments.mitoo_ordinal_id#') )
		
		AND (f.FixtureDate BETWEEN '#arguments.startDate#' AND  '#arguments.endDate#')
	
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
		QFixtures[#i#].ID 					= #FID#;
		QFixtures[#i#].mitoo_division_id 	= #DID#;
		QFixtures[#i#].mitoo_division_name 	= #DivName1#;
		QFixtures[#i#].mitoo_league_prefix 	= #LeagueCode#;
		
		QFixtures[#i#].fixture_result		= #Result#;
		
		QFixtures[#i#].fixture_home_name 	= #HomeTeam#;
		QFixtures[#i#].fixture_home_ordinal	= #HomeOrdinal#;
		QFixtures[#i#].fixture_home_id 		= #HomeTeamId#;
		QFixtures[#i#].fixture_home_goals 	= #Homegoals#;
		QFixtures[#i#].fixture_home_constitution_id 	= #HomeConstitutionID#;
		
		QFixtures[#i#].fixture_away_name 	= #AwayTeam#;
		QFixtures[#i#].fixture_away_ordinal	= #AwayOrdinal#;
		QFixtures[#i#].fixture_away_id 		= #AwayTeamId#;
		QFixtures[#i#].fixture_away_goals 	= #Awaygoals#;
		QFixtures[#i#].fixture_away_constitution_id 	= #AwayConstitutionID#;
		
		QFixtures[#i#].fixture_date 		= #FixtureDate#;
		QFixtures[#i#].fixture_venue_name 	= #VenueName#;
		QFixtures[#i#].mitoo_venue_id 		= #VenueID#;
		i++;				
	</cfscript>
</cfloop>
