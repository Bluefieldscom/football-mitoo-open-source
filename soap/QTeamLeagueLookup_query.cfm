<!--- called from getFixturesByDivisionIDAndDate method of webServices.cfc --->

<cfinclude template="QgetLeagueYearFromDates2.cfm">


<cfquery name="QFixtures_query" datasource="#variables.dsn#">
	
	SELECT 
		zlkc.id as mitoo_lookup_id
	FROM
		fm#getLeagueYear.leagueCodeYear#.constitution c
	INNER JOIN
		zmast.lk_constitution zlkc ON zlkc.#getLeagueYear.leagueCodeYear#id=c.id 
	WHERE
		c.teamid ='#arguments.team_id#'
	AND
		c.leaguecode = '#arguments.league_code#'
	LIMIT 1;

</cfquery>

<cfloop query="QFixtures_query">
	<cfscript>
		QTeam[1] 					= StructNew();
		QTeam[1].mitoo_lookup_id 	= #mitoo_lookup_id#;
	</cfscript>
</cfloop>
