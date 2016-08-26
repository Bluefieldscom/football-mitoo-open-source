<cfquery name="QAllLeagues_query" datasource="ZMAST">
	SELECT 	
		id as mitoo_league_id, 
		leaguename as gr_league_name, 
		leaguecodeprefix as mitoo_league_prefix,
		countieslist as mitoo_counties_list,
		defaultyouthleague as mitoo_youth_league
	FROM 
		(SELECT * FROM leagueinfo ORDER BY DEFAULTLEAGUECODE DESC) as temp
	GROUP BY 
			LeagueCodePrefix
</cfquery>
<cfset i=1>
<cfloop query="QAllLeagues_query">
	<cfscript>
		QAllLeagues[#i#] = StructNew();
		QAllLeagues[#i#].mitoo_league_id = #mitoo_league_id#;
		QAllLeagues[#i#].gr_league_name = #gr_league_name#;
		QAllLeagues[#i#].mitoo_league_prefix = #mitoo_league_prefix#;
		QAllLeagues[#i#].mitoo_counties_list = #mitoo_counties_list#;
		QAllLeagues[#i#].mitoo_youth_league = #mitoo_youth_league#;
		i++;
	</cfscript>
</cfloop>