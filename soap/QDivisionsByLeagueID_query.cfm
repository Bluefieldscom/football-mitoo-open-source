<!--- called from getDivisionsByID method of webServices.cfc --->

<cfinclude template="QgetLeagueYearFromDates.cfm">

<cfif variables.dsn NEQ 'fm'>

	<cfquery name="QDivisionsByLeagueID_query" datasource="#variables.dsn#">
		SELECT 	
				id as mitoo_division_id, 
				longcol as gr_division_name,
				notes as gr_division_knockout 
		FROM 
				division d
		WHERE 
				d.LeagueCode = '#arguments.LeagueCode#'
	</cfquery>
	<cfset i=1>
	<cfloop query="QDivisionsByLeagueID_query">
		<cfscript>
			QDivisionsByLeagueIDArray[#i#] = StructNew();
			QDivisionsByLeagueIDArray[#i#].mitoo_division_id = #mitoo_division_id#;
			QDivisionsByLeagueIDArray[#i#].gr_division_name = #gr_division_name#;
			QDivisionsByLeagueIDArray[#i#].gr_division_knockout = #gr_division_knockout#;
			i++;
		</cfscript>
	</cfloop>
	
</cfif>
