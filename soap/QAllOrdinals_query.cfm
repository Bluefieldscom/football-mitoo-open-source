<cfinclude template="QgetLeagueYearFromDates.cfm">

<cfquery name="QAllOrdinals_query" datasource="#variables.dsn#">
	SELECT 	
		id as mitoo_ordinal_id, 
		LongCol as gr_ordinal_name
	FROM 
		ordinal
	
</cfquery>
<cfset i=1>
<cfloop query="QAllOrdinals_query">
	<cfscript>
		QAllOrdinals[#i#] = StructNew();
		QAllOrdinals[#i#].mitoo_ordinal_id 	= #mitoo_ordinal_id#;
		QAllOrdinals[#i#].gr_ordinal_name 	= #gr_ordinal_name#;
		i++;
	</cfscript>
</cfloop>