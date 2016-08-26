<!--- called from getFixtureByFixtureID method and getAllFixtureInfoByIdAndLeagueCode method of webServices.cfc --->
<!---
<cfset arguments.fixture_id = 93213><cfset arguments.leaguecode='MDX'>
<cfset arguments.startDate	= "#dateformat(Now(),'YYYY-mm-dd')#">
<cfset arguments.endDate 	= "#dateformat(Now(),'YYYY-mm-dd')#">
--->
<cfinclude template="QgetLeagueYearFromDates.cfm">

<cfquery name="QFixture_query" datasource="#variables.dsn#">
	SELECT
		t1.longcol as id ,
		t1.longcol as HomeTeam ,
		t2.longcol as AwayTeam ,
		<!--- 
		t1.shortcol as HomeGuest ,
		t2.shortcol as AwayGuest ,
		--->
		t1.ID as HomeTeamID,
		t2.ID as AwayTeamID,
		f.HomeID as HomeConstitutionID,
		f.AwayID as AwayConstitutionID,
		<!--- 
		o1.ID as HomeOrdinalID ,
		o2.ID as AwayOrdinalID ,
		--->
		o1.longcol as HomeOrdinal ,
		o2.longcol as AwayOrdinal ,
		f.HomeTeamNotes,
		f.AwayTeamNotes,
		<!---
		k.longcol as RoundName ,
		--->
		d1.longcol as DivName1 ,
		d1.ID as DID ,
		<!---
		f.HomeID as FHomeID,
		f.AwayID as FAwayID,
		f.MatchNumber as MatchNumber ,	
		--->
		CASE
			WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0
				THEN r.LongCol
			ELSE CONCAT(LEFT(r.Forename,1), ". ", r.Surname)
		END
		as RefsName ,
		CASE
			WHEN LENGTH(TRIM(r1.Forename)) = 0 AND LENGTH(TRIM(r1.Surname)) = 0
				THEN r1.LongCol
			ELSE CONCAT(LEFT(r1.Forename,1), ". ", r1.Surname)
		END
		as AsstRef1Name,
		CASE
			WHEN LENGTH(TRIM(r2.Forename)) = 0 AND LENGTH(TRIM(r2.Surname)) = 0
				THEN r2.LongCol
			ELSE CONCAT(LEFT(r2.Forename,1), ". ", r2.Surname)
		END
		as AsstRef2Name,
		DATE_FORMAT(f.FixtureDate, '%Y-%m-%d') as FixtureDate ,
		
		f.Attendance as Attendance ,
		<!---
		f.Result,
		--->
		IF(f.Result IN('H','A','D') AND f.HomeGoals=0 AND f.AwayGoals=0, NULL,f.HomeGoals) as Homegoals,
		IF(f.Result IN('H','A','D') AND f.HomeGoals=0 AND f.AwayGoals=0, NULL,f.AwayGoals) as Awaygoals,
		f.HomePointsAdjust ,
		f.AwayPointsAdjust ,
		f.ID as FID,
		f.LeagueCode as LeagueCode,
		<!---,
			d1.MediumCol as SortOrder
		--->
		f.pitchAvailableID,
		v.LongCol as VenueName,
		m.notes as Report,
		'#getLeagueYear.leagueName#' AS leaguename
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
		LEFT JOIN referee r ON r.ID = f.RefereeID
		LEFT JOIN referee r1 ON r1.ID = f.AsstRef1ID
		LEFT JOIN referee r2 ON r2.ID = f.AsstRef2ID
		LEFT JOIN matchreport m ON m.shortcol = f.ID
	WHERE
		f.id = #arguments.fixture_id#

</cfquery>

<cfset i=1>
<cfloop query="QFixture_query">
	<cfscript>
		QFixture[#i#] 						= StructNew();
		QFixture[#i#].ID 					= #FID#;
		QFixture[#i#].mitoo_division_id 	= #DID#;
		QFixture[#i#].mitoo_division_name 	= #DivName1#;
		QFixture[#i#].mitoo_league_prefix 	= #LeagueCode#;
		
	//	QFixture[#i#].fixture_result = #Result#;
		
		QFixture[#i#].fixture_home_name 			= #HomeTeam#;
		QFixture[#i#].fixture_home_id 				= #HomeTeamId#;
		QFixture[#i#].fixture_home_goals 			= #Homegoals#;
		QFixture[#i#].fixture_home_ordinal 			= #HomeOrdinal#;
		QFixture[#i#].fixture_home_team_notes 		= #HomeTeamNotes#;
		QFixture[#i#].fixture_home_constitution		= #HomeConstitutionID#;
		
		QFixture[#i#].fixture_away_name 			= #AwayTeam#;
		QFixture[#i#].fixture_away_id 				= #AwayTeamId#;
		QFixture[#i#].fixture_away_goals 			= #Awaygoals#;
		QFixture[#i#].fixture_away_ordinal 			= #AwayOrdinal#;
		QFixture[#i#].fixture_away_team_notes 		= #AwayTeamNotes#;
		QFixture[#i#].fixture_away_constitution		= #AwayConstitutionID#;
				
		QFixture[#i#].fixture_date 			= #FixtureDate#;
		QFixture[#i#].league_name 			= #leagueName#;
		QFixture[#i#].venue_name 			= #venueName#;
		QFixture[#i#].match_report 			= #report#;
		QFixture[#i#].referee_name 			= #refsName#;
		QFixture[#i#].referee_asst1_name 	= #asstRef1Name#;
		QFixture[#i#].referee_asst2_name 	= #asstRef2Name#;
		QFixture[#i#].attendance 			= #Attendance#;
		
		
		i++;
	</cfscript>
</cfloop>

<!---<cfdump var="#QFixture#">--->
