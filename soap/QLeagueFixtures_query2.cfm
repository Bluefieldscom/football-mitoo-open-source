<!--- called from getLeagueFixtures of webServices2.cfc --->
<!---
<cfset arguments.league_code = 'RYMYL'>
<cfset arguments.division_id_list = ''>
<cfset arguments.start_date = '2010-09-17'>
<cfset arguments.end_date = '2010-)9-30'>
<cfset arguments.limit = 60>
<cfset arguments.order = 'ASC'>

<cfinclude template="QgetLeagueYearFromDates3.cfm">
--->

<cfset HideGoals           = "No">
<cfset HideGoalDiff        = "No"> 
<cfset HideDivision        = "No">
<cfset HideFixture         = "No">

<cfinclude template="QLeagueKnockOut_query2.cfm">
<!---<cfdump var="#QLeagueKnockOut#">--->
<cfif QLeagueKnockout.recordCount GT 0>
	<cfset lkdid_list = ValueList(QLeagueKnockOut.ID)>
	<cfset notes_list = QuotedValueList(QLeagueKnockOut.Notes)>
<cfelse>
	<cfset lkdid_list = ''>
	<cfset notes_list = ''>
</cfif>

<cfquery name="QLeagueFixtures_query" datasource="#variables.dsn#">

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
		IF(ISNULL(f.KOTime),'',f.KOTime) AS KOTime,
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
	
		LEFT JOIN zmast.lk_division zlkd ON d1.ID = zlkd.#getLeagueYear.leagueCodeYear#id
	
	WHERE
		<cfif ListLen(arguments.division_id_list) NEQ 0> 
			zlkd.id IN (#arguments.division_id_list#)
			AND
		</cfif>
		f.FixtureDate BETWEEN '#arguments.start_date#' AND '#arguments.end_date#'
		AND 
		d1.leaguecode = '#arguments.league_code#'

  AND (d1.notes NOT REGEXP 'hidedivision' OR ISNULL(d1.notes))
	ORDER BY
		<!---umbrella_id, f.FixtureDate #arguments.order#, temp_home ASC--->
		f.FixtureDate #arguments.order#, umbrella_id, temp_home ASC
	<cfif arguments.limit NEQ "" >
	LIMIT #arguments.limit#
	</cfif>	
</cfquery>
<!---<cfdump var="#QLeagueFixtures_query#">	--->
<cfif IsDefined("QLeagueFixtures_query") AND QLeagueFixtures_query.recordCount GT 0>
	<cfset i=1>
	<cfset thisFixtureDate = ''>
	<cfloop query="QLeagueFixtures_query">
		<cfif FixtureDate NEQ thisFixtureDate>
			<cfset HideFixture = "No">
			<!---<cfinclude template="QLeagueEventText_query2.cfm">--->
			<cfinclude template="QLeagueEventText_query3.cfm">
			<!---<cfdump var="#QLeagueEventText#">--->
			<cfif (QLeagueEventText.recordCount IS 1) AND (FindNoCase("hide_fixtures",QLeagueEventText.EventText))>
				<cfset HideFixture = "Yes">
			</cfif>
		</cfif>			
		<cfif ListLen(lkdid_list) GT 0>
			<cfset list_location = ListFind(lkdid_list, #umbrella_id#)>
			<cfif list_location GT 0>
				<!-- HideDivision will suppress everything for this Division --->
				<cfif FindNoCase(ListGetAt(notes_list, #list_location#), "HideDivision")>
					<cfset HideDivision = "Yes">
				</cfif>
				<!--- HideGoals will suppress Goals For, Goals Against and Goal Difference columns --->
				<cfif FindNoCase(ListGetAt(notes_list, #list_location#), "HideGoals")>
					<cfset HideGoals = "Yes">	
				</cfif>
				<!--- HideGoalDiff will suppress Goal Difference columns --->
				<cfif FindNoCase(ListGetAt(notes_list, #list_location#), "HideGoalDiff")>
					<cfset HideGoalDiff = "Yes">	
				</cfif>
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
					if (KOTime == '')
						QFixtures[#i#].KOTime			= '00:00:00';
					else
						QFixtures[#i#].KOTime			= #TimeFormat(KOTime,"h.mm tt")#;
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