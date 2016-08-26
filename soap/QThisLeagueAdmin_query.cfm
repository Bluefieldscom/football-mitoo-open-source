

<cfquery name="QThisLeagueAdmin_query" datasource="zmast" >
	SELECT 
		leaguecodeprefix 
	FROM 
		identity 
	WHERE 
		pwd='#arguments.password#'
</cfquery>

<cfset i=1>
<cfloop query="QThisLeagueAdmin_query">
	<cfscript>
		QLeagues[#i#] = StructNew();
		QLeagues[#i#].mitoo_league_prefix 	= #leaguecodeprefix#;
		i++;
	</cfscript>
</cfloop>