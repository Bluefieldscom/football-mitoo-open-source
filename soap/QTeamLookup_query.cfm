<!--- called from getFixturesByDivisionIDAndDate method of webServices.cfc --->

<cfinclude template="QgetLeagueYearFromDates2.cfm">


<cfquery name="QFixtures_query" datasource="#variables.dsn#">
	SELECT 
		zlkc.id as mitoo_lookup_id
	FROM
		zmast.lk_constitution zlkc 
	WHERE
		zlkc.#getLeagueYear.leagueCodeYear#id='#arguments.team_id#'
	LIMIT 1;

</cfquery>

<cfloop query="QFixtures_query">
	<cfscript>
		QTeam[1] 					= StructNew();
		QTeam[1].mitoo_lookup_id 	= #mitoo_lookup_id#;
		
	</cfscript>
</cfloop>
