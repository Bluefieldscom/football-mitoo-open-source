<!--- called by getRefereesByLeague in webServices.cfc --->

<cfinclude template="QgetLeagueYearFromDates.cfm">

<cfquery name="QRefsByLeague_query" datasource="fm2008">
	SELECT 
		id AS RefID, 
		longcol AS fullname
	FROM 
		referee 
	WHERE leaguecode='#arguments.leagueCode#'
</cfquery>

<cfset i=1>
<cfloop query="QRefsByLeague_query">
	<cfscript>
		QRefsByLeague[#i#] = StructNew();
		QRefsByLeague[#i#].id = #RefID#;
		QRefsByLeague[#i#].referee_first_name = GetToken(#fullname#,2,',');
		QRefsByLeague[#i#].referee_surname = GetToken(#fullname#,1,',');
		QRefsByLeague[#i#].mitoo_league_prefix = #arguments.leagueCode#;
		i++;
	</cfscript>
</cfloop>
