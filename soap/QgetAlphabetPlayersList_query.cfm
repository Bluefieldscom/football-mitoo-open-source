<!--- called from getPlayersByTeam method of webServices.cfc --->

<cfinclude template="QgetLeagueYearFromDates.cfm">

<cfquery name="QAlphabetPlayersList_query" datasource="#variables.dsn#">
	SELECT 
		p.ID AS player_id, p.forename AS player_firstname, p.surname AS player_lastname
	FROM 
		player p
	JOIN 
		register AS r ON p.ID = r.PlayerID
	WHERE 
		p.leaguecode = '#arguments.leaguecode#'
		AND LEFT(p.surname,1) = '#arguments.player_initial#'
		AND '#arguments.startDate#' 
			BETWEEN 
			IF(ISNULL(r.FirstDay), '1900-01-01', r.FirstDay)
			AND 
			IF(ISNULL(r.LastDay), '2999-12-31', r.LastDay)
		AND p.surname != 'OwnGoal'
	ORDER BY player_lastname
</cfquery>

<cfset i=1>
<cfloop query="QAlphabetPlayersList_query">
	<cfscript>
		QAlphabetAllPlayerListArray[#i#] = StructNew();
		QAlphabetAllPlayerListArray[#i#].player_id = #player_id#;
		QAlphabetAllPlayerListArray[#i#].player_firstname = #player_firstname#;
		QAlphabetAllPlayerListArray[#i#].player_lastname = #player_lastname#;				
		i++;
	</cfscript>
</cfloop>
