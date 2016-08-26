<!--- called from getDivisionFixtures of webServices2.cfc --->
<!---
<cfset arguments.league_code = 'CHIS'>
<cfset arguments.division_id = '2310'>
<cfset arguments.start_date = '2009-09-01'>
<cfset arguments.end_date   = '2009-09-30'>
<cfset arguments.limit     = '20'>
<cfset arguments.order = 'DESC'>

<cfinclude template="QgetLeagueYearFromDates3.cfm">
<cfif inSeason IS 0>
	<cfscript> QFixtures[1] = StructNew(); </cfscript>
	<cfreturn QFixtures>
</cfif>	
--->



<cfset HideGoals           = "No">
<cfset HideGoalDiff        = "No"> 
<cfset HideDivision        = "No">
<cfset HideFixture         = "No">

<cfinclude template="QKnockOut_query2.cfm">

<!--- HideDivision will suppress everything for this Division 
	  here we suppress goals only --->
<cfif Find("HideDivision", QKnockOut.Notes )>
	<cfset HideDivision = "Yes">
	<!-- message -->
</cfif>
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
		t1.longcol AS temp_home,
		t2.longcol AS temp_away,
		ko.longcol AS knockout_desc,
		f.fixturenotes,
		zlkd.id AS umbrella_id,
		d1.longcol AS divisionname
	FROM
		fm#getLeagueYear.leagueCodeYear#.fixture f 
		
		INNER JOIN fm#getLeagueYear.leagueCodeYear#.koround ko ON ko.id=f.KORoundID
		
		INNER JOIN fm#getLeagueYear.leagueCodeYear#.constitution c1 ON c1.ID = f.HomeID
		INNER JOIN fm#getLeagueYear.leagueCodeYear#.constitution c2 ON c2.ID = f.AwayID
		INNER JOIN fm#getLeagueYear.leagueCodeYear#.division d1 ON c1.DivisionID = d1.ID
		
		INNER JOIN fm#getLeagueYear.leagueCodeYear#.team t1 ON c1.TeamID = t1.ID
		INNER JOIN fm#getLeagueYear.leagueCodeYear#.team t2 ON c2.TeamID = t2.ID
		
		LEFT JOIN fm#getLeagueYear.leagueCodeYear#.pitchavailable pa ON pa.ID = f.pitchAvailableID
		LEFT JOIN fm#getLeagueYear.leagueCodeYear#.venue v on v.ID = pa.VenueID
	
		LEFT JOIN zmast.lk_constitution zlkc1 ON c1.ID = zlkc1.#getLeagueYear.leagueCodeYear#id
		LEFT JOIN zmast.lk_constitution zlkc2 ON c2.ID = zlkc2.#getLeagueYear.leagueCodeYear#id
	
		LEFT JOIN zmast.lk_division zlkd ON zlkd.id = '#arguments.division_id#'
	
	WHERE
		f.FixtureDate BETWEEN '#arguments.start_date#' AND '#arguments.end_date#'
	AND 
		d1.ID = zlkd.#getLeagueYear.leagueCodeYear#id
	
	ORDER BY
		f.FixtureDate #arguments.order#, temp_home ASC
	<cfif arguments.limit NEQ "" >
	LIMIT #arguments.limit#
	</cfif>
</cfquery>

<cfif IsDefined("QFixtures_query") AND QFixtures_query.recordCount GT 0>
	<cfset i=1>
	<cfset thisFixtureDate = ''>
	<cfloop query="QFixtures_query">
		<cfif FixtureDate NEQ thisFixtureDate>
			<cfset HideFixture = "No">
			<cfinclude template="QEventText_query2.cfm">
			<cfif (QEventText.recordCount IS 1) AND (FindNoCase("hide_fixtures",QEventText.EventText))>
				<cfset HideFixture = "Yes">
			</cfif>
		</cfif>		
		<cfif HideFixture IS "No">
			<cfscript>
					QFixtures[#i#] 						= StructNew();
					QFixtures[#i#].fixture_id 			= #fixture_id#;
					QFixtures[#i#].umbrella_id			= #umbrella_id#;			
					QFixtures[#i#].fixture_date 		= #FixtureDate#;
					QFixtures[#i#].fixture_venue_name 	= #VenueName#;
					if((HideDivision IS "Yes" OR HideGoals IS "Yes") AND #Homegoals# != 'NULL' AND #Awaygoals# != 'NULL' ) 
						{
						QFixtures[#i#].fixture_result		= 'Played';
						QFixtures[#i#].fixture_home_goals	= '*';
						QFixtures[#i#].fixture_away_goals	= '*';		
						}else{
						QFixtures[#i#].fixture_result		= #Result#;
						QFixtures[#i#].fixture_home_goals	= #HomeGoals#;
						QFixtures[#i#].fixture_away_goals	= #AwayGoals#;
						}		
					QFixtures[#i#].fixture_home_id 		= #home_id#;
					QFixtures[#i#].temp_home 			= #temp_home#;
					QFixtures[#i#].fixture_away_id 		= #away_id#;
					QFixtures[#i#].temp_away 			= #temp_away#;
					QFixtures[#i#].knockout_desc		= #knockout_desc#;
					QFixtures[#i#].fixture_notes		= #fixturenotes#;
					QFixtures[#i#].division_name		= #divisionname#;				
					i++;
			</cfscript>
		</cfif>
		<cfset thisFixtureDate = #FixtureDate#>
	</cfloop>
	<cfif i IS 1>
		<cfscript>
		QFixtures[#i#] = StructNew();
		i++;
	</cfscript>
	</cfif>
<cfelse>
	<cfset i=1>
	<!-- add message in here somewhere -->
	<cfscript>
		QFixtures[#i#] = StructNew();
		i++;
	</cfscript>
</cfif>

<!---<cfdump var="#QFixtures#">--->