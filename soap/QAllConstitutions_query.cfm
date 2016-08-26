<cfinclude template="QgetLeagueYearFromDates.cfm">

<cfquery name="QAllConstitutions_query" datasource="#variables.dsn#">
	SELECT 	
		id as mitoo_constitution_id, 
		DivisionID as mitoo_division_id,
		TeamID as mitoo_team_id,
		OrdinalID as mitoo_ordinal_id
	FROM 
		constitution
		
</cfquery>
<cfset i=1>
<cfloop query="QAllConstitutions_query">
	<cfscript>
		QAllConstitutions[#i#] = StructNew();
		QAllConstitutions[#i#].mitoo_constitution_id 	= #mitoo_constitution_id#;
		QAllConstitutions[#i#].mitoo_division_id 		= #mitoo_division_id#;
		QAllConstitutions[#i#].mitoo_team_id 			= #mitoo_team_id#;
		QAllConstitutions[#i#].mitoo_ordinal_id 		= #mitoo_ordinal_id#;
		i++;
	</cfscript>
</cfloop>