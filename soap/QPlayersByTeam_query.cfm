<!--- called from getPlayersByTeam method of webServices.cfc --->

<cfinclude template="QgetLeagueYearFromDates.cfm">

<cfquery name="QPlayersByTeam_query" datasource="#variables.dsn#">
	SELECT 
		p.ID AS mitoo_player_id, p.forename AS gr_player_firstname, p.surname AS gr_player_lastname
	FROM 
		player p
	JOIN 
		register AS r ON p.ID = r.PlayerID
	WHERE 
		r.TeamID = #arguments.teamID#
		AND p.surname != 'OwnGoal'
	ORDER BY gr_player_lastname
</cfquery>
<cfset i=1>
<cfloop query="QPlayersByTeam_query">
	<cfscript>
		QPlayersByTeamArray[#i#] = StructNew();
		QPlayersByTeamArray[#i#].mitoo_player_id = #mitoo_player_id#;
		QPlayersByTeamArray[#i#].gr_player_firstname = #gr_player_firstname#;
		QPlayersByTeamArray[#i#].gr_player_lastname = #gr_player_lastname#;				
		i++;
	</cfscript>
</cfloop>
