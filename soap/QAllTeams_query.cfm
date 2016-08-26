<cfinclude template="QgetLeagueYearFromDates.cfm">

<cfquery name="QAllTeams_query" datasource="#variables.dsn#">
	SELECT 	
		id as mitoo_team_id, 
		TRIM(t.longcol) AS gr_team_name,
		shortcol AS guest
	FROM 
		team AS t

	ORDER BY gr_team_name
	
</cfquery>
<cfset i=1>
<cfloop query="QAllTeams_query">
	<cfscript>
		QAllTeams[#i#] = StructNew();
		QAllTeams[#i#].mitoo_team_id 	= #mitoo_team_id#;
		QAllTeams[#i#].gr_team_name 	= #gr_team_name#;
		QAllTeams[#i#].gr_team_guest 	= #guest#;
		i++;
	</cfscript>
</cfloop>