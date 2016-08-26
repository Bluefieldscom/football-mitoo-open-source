<!--- called from getLeagueFixtureDates of webServices2.cfc --->
<!---
<cfset arguments.league_code = 'RYMYL'>
<cfset arguments.division_id_list = '6751,6753,6754'>
<cfset arguments.start_date = '2010-09-17'>
<cfset arguments.end_date = '2010-09-30'>
<cfset arguments.limit = 60>
<cfset arguments.order = 'ASC'>

<cfinclude template="QgetLeagueYearFromDates3.cfm">
--->

<cfquery name="QLeagueFixtureDates_query" datasource="#variables.dsn#">
	SELECT DISTINCT 
		DATE_FORMAT(f.FixtureDate,'%Y-%m-%d') AS FixtureDate
	FROM
		fm#getLeagueYear.leagueCodeYear#.fixture f 
		INNER JOIN fm#getLeagueYear.leagueCodeYear#.constitution c1 ON c1.ID = f.HomeID
		INNER JOIN fm#getLeagueYear.leagueCodeYear#.division d1 ON c1.DivisionID = d1.ID
		LEFT JOIN zmast.lk_division zlkd ON d1.ID = zlkd.#getLeagueYear.leagueCodeYear#id
	WHERE
		f.leaguecode = '#arguments.league_code#'	
		AND
		f.FixtureDate BETWEEN '#arguments.start_date#' AND '#arguments.end_date#'
		<cfif arguments.division_id_list NEQ "">
			AND
			zlkd.id IN (#arguments.division_id_list#) 
		</cfif>	 
AND (d1.notes NOT REGEXP 'hidedivision' OR ISNULL(d1.notes))
	ORDER BY
		f.FixtureDate #arguments.order#	
	<cfif arguments.limit NEQ "" >
		LIMIT #arguments.limit#
	</cfif>	

</cfquery>
<!--- <cfdump var="#QLeagueFixtureDates_query#"> --->
<cfif IsDefined("QLeagueFixtureDates_query") AND QLeagueFixtureDates_query.recordCount GT 0>
	<cfset i=1>
	<cfloop query="QLeagueFixtureDates_query">
			<cfscript>
					QFixtureDates[#i#] 						= StructNew();
					QFixtureDates[#i#].fixture_date 		= #FixtureDate#;
					i++;
			</cfscript>
	</cfloop>
	<cfif i IS 1>
		<cfscript>
		QFixtureDates[#i#] = StructNew();
		i++;
		</cfscript>
	</cfif>
<cfelse>
	<cfset i=1>
	<cfscript>
		QFixtureDates[#i#] = StructNew();
		i++;
	</cfscript>
</cfif>
<!--- <cfdump var="#QFixtureDates#"> --->