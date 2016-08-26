<!--- called from getPlayersByTeamID method of webServices.cfc --->

<cfinclude template="QgetLeagueYearFromDates.cfm">

<cfquery name="QPlayersByTeamID_query" datasource="#variables.dsn#">
	SELECT 
		p.id AS player_id, 
		r.teamid AS team_id,
		p.forename AS player_first_name, 
		p.surname AS player_surname, 
		<!---IF(p.mediumCol IS NULL, "", DATE_FORMAT(p.mediumCol,'%Y-%m-%d')) AS player_date_of_birth--->
		IF(ISNULL(p.mediumCol),"",DATE_FORMAT(p.mediumCol,'%Y-%m-%d')) AS player_date_of_birth 
	FROM 
		player p
	JOIN 
		register AS r ON p.ID = r.PlayerID
	WHERE 
		r.leagueCode = '#arguments.leaguecode#'
		AND r.teamID = #arguments.team_id#
		AND p.surname != 'OwnGoal'
		AND 
		((r.LastDay IS NULL AND '#arguments.fixture_date#' > r.FirstDay) 
		OR 
		(r.FirstDay IS NULL AND '#arguments.fixture_date#' < r.LastDay)
		OR 
		(r.LastDay IS NOT NULL AND '#arguments.fixture_date#' BETWEEN r.FirstDay AND r.LastDay)
		OR
		(r.LastDay IS NULL AND r.FirstDay IS NULL))
	ORDER BY player_surname
</cfquery>


<cfset i=1>
<cfloop query="QPlayersByTeamID_query">
	<cfscript>
		QPlayersByTeamIDArray[#i#] = StructNew();
		QPlayersByTeamIDArray[#i#].player_id = #player_id#;
		QPlayersByTeamIDArray[#i#].team_id = #team_id#;		
		QPlayersByTeamIDArray[#i#].player_first_name = #player_first_name#;
		QPlayersByTeamIDArray[#i#].player_surname = #player_surname#;				
		QPlayersByTeamIDArray[#i#].player_date_of_birth = #player_date_of_birth#;				
		i++;
	</cfscript>
</cfloop>