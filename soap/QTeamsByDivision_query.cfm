<!--- called from getTeamsByDivision method of webServices.cfc --->

<cfinclude template="QgetLeagueYearFromDates.cfm">

<cfquery name="QTeamsByDivision_query" datasource="#variables.dsn#">
	SELECT 
		t.ID AS mitoo_team_id, CONCAT(t.longcol," ", IF(ISNULL(o.longcol),"",o.longcol)) AS gr_team_name
	FROM 
		team AS t
	JOIN 
		constitution AS c ON t.ID = c.TeamID
	JOIN
		ordinal AS o ON o.ID = c.ordinalID
	WHERE 
		c.DivisionID = #arguments.divisionID#
	AND 
		t.mediumcol IS NOT NULL
	ORDER BY gr_team_name
</cfquery>
<cfset i=1>
<cfloop query="QTeamsByDivision_query">
	<cfscript>
		QTeamsByDivisionArray[#i#] = StructNew();
		QTeamsByDivisionArray[#i#].mitoo_team_id = #mitoo_team_id#;
		QTeamsByDivisionArray[#i#].gr_team_name = #gr_team_name#;
		i++;
	</cfscript>
</cfloop>
