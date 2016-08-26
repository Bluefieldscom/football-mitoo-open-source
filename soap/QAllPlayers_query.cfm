<cfinclude template="QgetLeagueYearFromDates.cfm">

<cfquery name="QAllPlayers_query" datasource="#variables.dsn#">
	SELECT 
		p.ID AS mitoo_player_id, 
		p.forename AS gr_player_firstname, 
		p.surname AS gr_player_lastname,
		IF(ISNULL(p.mediumCol),"",p.mediumCol) AS gr_player_dob
	FROM 
		player p
		
	INNER JOIN register AS r on r.PlayerID=p.ID
	
	WHERE 
		p.surname != 'OwnGoal'
	ORDER BY 
		gr_player_lastname
	<cfif arguments.limit NEQ "" >
	LIMIT #arguments.limit#
	</cfif>
</cfquery>
<cfset i=1>
<cfloop query="QAllPlayers_query">
	<cfscript>
		QAllPlayers[#i#] = StructNew();
		QAllPlayers[#i#].mitoo_player_id 		= #mitoo_player_id#;
		QAllPlayers[#i#].gr_mitoo_player_firstname 	= #gr_player_firstname#;
		QAllPlayers[#i#].gr_mitoo_player_lastname 	= #gr_player_lastname#;	
		QAllPlayers[#i#].gr_mitoo_player_dob 			= #gr_player_dob#;				
		i++;
	</cfscript>
</cfloop>