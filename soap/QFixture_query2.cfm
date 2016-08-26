<!--- called from getFixtureByFixtureID method ?
and getFixtureInfo method of webServices2.cfc --->

<!---
<cfset arguments.fixture_id = 160432>
<cfset arguments.start_date = '2010-05-26'>
<cfset arguments.end_date = '2010-05-26'>
<cfset arguments.league_code = 'MDX'>


<cfset arguments.fixture_id = 91447>
<cfset arguments.start_date = '2009-10-18'>
<cfset arguments.end_date = '2009-10-18'>
<cfset arguments.league_code = 'HYFL'>

<cfinclude template="QgetLeagueYearFromDates3.cfm">
--->

<cfquery name="QFixture_query" datasource="#variables.dsn#">
	SELECT 
		zmlkc1.id AS HomeTeamID,
		zmlkc2.id AS AwayTeamID,
		t1.longcol AS temp_home,
		t2.longcol AS temp_away,

		f.HomeTeamNotes,
		f.AwayTeamNotes,
		f.fixturenotes,
		IF(ISNULL(f.KOTime),'',f.KOTime) AS KOTime,
			
		CASE
			WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0
				THEN r.LongCol
			ELSE CONCAT(LEFT(r.Forename,1), ". ", r.Surname)
		END
		AS RefsName ,
		CASE
			WHEN LENGTH(TRIM(r1.Forename)) = 0 AND LENGTH(TRIM(r1.Surname)) = 0
				THEN r1.LongCol
			ELSE CONCAT(LEFT(r1.Forename,1), ". ", r1.Surname)
		END
		AS AsstRef1Name,
		CASE
			WHEN LENGTH(TRIM(r2.Forename)) = 0 AND LENGTH(TRIM(r2.Surname)) = 0
				THEN r2.LongCol
			ELSE CONCAT(LEFT(r2.Forename,1), ". ", r2.Surname)
		END
		AS AsstRef2Name,
		DATE_FORMAT(f.FixtureDate, '%Y-%m-%d') AS FixtureDate ,
		
		f.Attendance AS Attendance ,
		IF(f.Result IN('H','A','D') AND f.HomeGoals=0 AND f.AwayGoals=0, NULL,f.HomeGoals) AS Homegoals,
		IF(f.Result IN('H','A','D') AND f.HomeGoals=0 AND f.AwayGoals=0, NULL,f.AwayGoals) AS Awaygoals,
		f.HomePointsAdjust ,
		f.AwayPointsAdjust ,
		f.ID AS FID,
		f.LeagueCode AS LeagueCode,
		f.pitchAvailableID,
		v.LongCol AS VenueName,
		m.notes AS Report,
		(SELECT leagueName FROM zmast.leagueinfo AS zmli WHERE zmli.LeagueCodePrefix = f.LeagueCode LIMIT 1) AS leaguename,
		f.result as fixture_result
	FROM
		fm#getLeagueYear.leagueCodeYear#.fixture f
		INNER JOIN fm#getLeagueYear.leagueCodeYear#.koround k ON k.ID = f.KORoundID
		INNER JOIN fm#getLeagueYear.leagueCodeYear#.constitution c1 ON c1.ID = f.HomeID
		INNER JOIN fm#getLeagueYear.leagueCodeYear#.constitution c2 ON c2.ID = f.AwayID
		INNER JOIN fm#getLeagueYear.leagueCodeYear#.team t1 ON c1.TeamID = t1.ID
		INNER JOIN fm#getLeagueYear.leagueCodeYear#.team t2 ON c2.TeamID = t2.ID
		INNER JOIN fm#getLeagueYear.leagueCodeYear#.ordinal o1 ON c1.OrdinalID = o1.ID
		INNER JOIN fm#getLeagueYear.leagueCodeYear#.ordinal o2 ON c2.OrdinalID = o2.ID
		INNER JOIN fm#getLeagueYear.leagueCodeYear#.division d1 ON c1.DivisionID = d1.ID
		LEFT JOIN fm#getLeagueYear.leagueCodeYear#.pitchavailable pa ON pa.ID = f.pitchAvailableID
		LEFT JOIN fm#getLeagueYear.leagueCodeYear#.venue v ON v.ID = pa.VenueID
		LEFT JOIN fm#getLeagueYear.leagueCodeYear#.referee r ON r.ID = f.RefereeID
		LEFT JOIN fm#getLeagueYear.leagueCodeYear#.referee r1 ON r1.ID = f.AsstRef1ID
		LEFT JOIN fm#getLeagueYear.leagueCodeYear#.referee r2 ON r2.ID = f.AsstRef2ID
		LEFT JOIN fm#getLeagueYear.leagueCodeYear#.matchreport m ON m.shortcol = f.ID
		
		LEFT JOIN zmast.lk_constitution	AS zmlkc1 ON zmlkc1.#getLeagueYear.leagueCodeYear#id = c1.ID
		LEFT JOIN zmast.lk_constitution	AS zmlkc2 ON zmlkc2.#getLeagueYear.leagueCodeYear#id = c2.ID

	WHERE
		f.id = #arguments.fixture_id#
</cfquery>

<!---
<cfdump var = "#QFixture_query#">
--->

<cfset arguments.leagueCode = QFixture_query.LeagueCode>

<cfset i=1>
<cfloop query="QFixture_query">
	<cfscript>
		QFixture[#i#] 						= StructNew();
		QFixture[#i#].ID 					= #FID#;
		
	
		QFixture[#i#].fixture_home_team_id 			= #HomeTeamId#;
		QFixture[#i#].fixture_home_goals 			= #Homegoals#;
		QFixture[#i#].fixture_home_team_notes 		= #HomeTeamNotes#;
		
		QFixture[#i#].temp_home 					= #temp_home#;
	
		QFixture[#i#].fixture_away_team_id 			= #AwayTeamId#;
		QFixture[#i#].fixture_away_goals 			= #Awaygoals#;
		QFixture[#i#].fixture_away_team_notes 		= #AwayTeamNotes#;
		
		QFixture[#i#].temp_away 					= #temp_away#;
				
		QFixture[#i#].fixture_date 			= #FixtureDate#;
		QFixture[#i#].venue_name 			= #venueName#;
		QFixture[#i#].match_report 			= #report#;
		QFixture[#i#].referee_name 			= #refsName#;
		QFixture[#i#].referee_asst1_name 	= #asstRef1Name#;
		QFixture[#i#].referee_asst2_name 	= #asstRef2Name#;
		QFixture[#i#].attendance 			= #Attendance#;
		
		QFixture[#i#].fixture_notes			= #fixturenotes#;
		if (KOTime == '')
			QFixture[#i#].KOTime			= '00:00:00';
		else
			QFixture[#i#].KOTime			= #TimeFormat(KOTime,"h.mm tt")#;
		QFixture[#i#].fixture_result		= #fixture_result#;
		
		i++;
	</cfscript>
</cfloop>

<!---
<cfdump var="#QFixture#"><cfabort>
--->

<cfset arguments.HomeAway = 'H'>
<cfinclude template="QgetMatchPlayers_query2.cfm">
<cfset QHomeTeamDetails = Duplicate(QTeamListArray)>
<cfset temp = ArrayClear(QTeamListArray)>
<cfset arguments.HomeAway = 'A'>
<cfinclude template="QgetMatchPlayers_query2.cfm">
<cfset QAwayTeamDetails = Duplicate(QTeamListArray)>
<cfscript>
	QFixtureInfo[1]					= StructNew();
	QFixtureInfo[1].fixture_info 	= #QFixture#;
	QFixtureInfo[1].home_team 		= #QHomeTeamDetails#;
	QFixtureInfo[1].away_team 		= #QAwayTeamDetails#;
</cfscript>

