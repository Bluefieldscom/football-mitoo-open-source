<!--- called from getTeamAllConsFixtureDates method of webServices2.cfc --->
<!---
<cfset arguments.team_id = '8586'>
<cfset arguments.start_date = '2010-10-21'>
<cfset arguments.end_date = '2010-11-30'>
<cfset arguments.limit = 60>
<cfset arguments.order = 'ASC'>
<cfset arguments.league_code = 'ISTH'>
<cfset arguments.division_id_list = '235,4182,4181,4175,4190,5620'>
<cfinclude template="QgetLeagueYearFromDates3.cfm">
--->
<!--- create constitution_list --->
<cfquery name="Qgetteams_query" datasource="#variables.dsn#">
	SELECT id FROM fm#getLeagueYear.leagueCodeYear#.constitution WHERE teamID IN 
	(
		SELECT teamID FROM fm#getLeagueYear.leagueCodeYear#.constitution WHERE id = 
		(SELECT #getLeagueYear.leagueCodeYear#id FROM zmast.lk_constitution WHERE id = '#arguments.team_id#')
	)
</cfquery>
<cfdump var="#QgetTeams_query#">
<cfset constit_list = ValueList(Qgetteams_query.id)>

<cfif ListLen(constit_list) IS 0>
	<cfscript>
		QTeamFixtureDatess[1] = StructNew();
	</cfscript>
	<!--- return to calling page with empty array --->
	<cfreturn>
</cfif>

<cfquery name="QAllConsFixtureDates_query" datasource="#variables.dsn#">
	SELECT 
		DATE_FORMAT(f.FixtureDate, '%Y-%m-%d') AS FixtureDate
	FROM
		fm#getLeagueYear.leagueCodeYear#.fixture f 
		INNER JOIN fm#getLeagueYear.leagueCodeYear#.constitution c1 ON c1.ID = f.HomeID
		INNER JOIN fm#getLeagueYear.leagueCodeYear#.team t1 ON t1.ID=c1.TeamID
		INNER JOIN fm#getLeagueYear.leagueCodeYear#.constitution c2 ON c2.ID = f.AwayID
		INNER JOIN fm#getLeagueYear.leagueCodeYear#.team t2 ON t2.ID=c2.TeamID
		INNER JOIN fm#getLeagueYear.leagueCodeYear#.division d1 ON c1.DivisionID = d1.ID

		LEFT JOIN zmast.lk_constitution zlkc1 ON c1.ID = zlkc1.#getLeagueYear.leagueCodeYear#id
		LEFT JOIN zmast.lk_constitution zlkc2 ON c2.ID = zlkc2.#getLeagueYear.leagueCodeYear#id
		
		LEFT JOIN zmast.lk_division zlkd ON d1.id = zlkd.#getLeagueYear.leagueCodeYear#id
	WHERE
		<cfif ListLen(arguments.division_id_list) NEQ 0> 
			zlkd.id IN (#arguments.division_id_list#)
			AND
		</cfif>
		d1.leaguecode = '#arguments.league_code#'
		AND
		(c1.ID IN (#constit_list#) OR c2.ID IN (#constit_list#))
		AND
		f.FixtureDate BETWEEN '#arguments.start_date#' AND '#arguments.end_date#'

  AND (d1.notes NOT REGEXP 'hidedivision' OR ISNULL(d1.notes))
	ORDER BY
		f.FixtureDate #arguments.order#
	<cfif arguments.limit NEQ "" >
		LIMIT #arguments.limit#
	</cfif>
</cfquery>

<cfif IsDefined("QAllConsFixtureDates_query") AND QAllConsFixtureDates_query.recordCount GT 0>
	<cfset i=1>
	<cfloop query="QAllConsFixtureDates_query">
			<cfscript>
					QTeamFixtureDates[#i#] 				= StructNew();
					QTeamFixtureDates[#i#].fixture_date = #FixtureDate#;
					i++;
			</cfscript>
	</cfloop>
	<cfif i IS 1>
		<cfscript>
		QTeamFixtureDates[#i#] = StructNew();
		i++;
		</cfscript>
	</cfif>
<cfelse>
	<cfset i=1>
	<cfscript>
		QTeamFixtureDates[#i#] = StructNew();
		i++;
	</cfscript>
</cfif>

<cfdump var="#QTeamFixtureDates#">
