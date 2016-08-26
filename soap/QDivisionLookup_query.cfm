<!--- called from getFixturesByDivisionIDAndDate method of webServices.cfc --->

<cfinclude template="QgetLeagueYearFromDates2.cfm">


<cfquery name="QFixtures_query" datasource="#variables.dsn#">
	SELECT 
		zlkd.id as mitoo_lookup_id
	FROM
		zmast.lk_division zlkd 
	WHERE
		zlkd.#getLeagueYear.leagueCodeYear#id='#arguments.division_id#'
	LIMIT 1;

</cfquery>

<cfloop query="QFixtures_query">
	<cfscript>
		QDivision[1] 						= StructNew();
		QDivision[1].mitoo_lookup_id		= #mitoo_lookup_id#;
		
	</cfscript>
</cfloop>
