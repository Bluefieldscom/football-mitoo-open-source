<!--- called from getTeamsByDivision method of webServices.cfc --->

<cfinclude template="QgetLeagueYearFromDates.cfm">

<cfquery name="QTeamDetailsByTeamId_query" datasource="#variables.dsn#">
	SELECT 
		*
	FROM 
		teamdetails
	WHERE 
		TeamID='#arguments.mitoo_team_id#'
		
	<cfif arguments.mitoo_ordinal_id NEQ "" >
	AND
		OrdinalID='#arguments.mitoo_ordinal_id#'
	</cfif>
	
	LIMIT 1
</cfquery>
<cfset i=1>
<cfloop query="QTeamDetailsByTeamId_query">
	<cfscript>
		QTeamsDetailsArray[#i#] = StructNew();

		i++;
	</cfscript>
</cfloop>
