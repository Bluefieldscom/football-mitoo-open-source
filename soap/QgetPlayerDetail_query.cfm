<!--- called from getPlayerDetailsByPlayerID method of webServices.cfc --->

<cfinclude template="QgetLeagueYearFromDates.cfm">

<cfquery name="QPlayerDetails_query" datasource="#variables.dsn#">
	SELECT 
		p.ID AS player_id, p.forename AS player_firstname, p.surname AS player_lastname,
		p.shortCol AS player_regNo, DATE_FORMAT(p.mediumCol, '%Y-%m-%d') AS player_dob, 
		p.notes AS player_notes
	FROM 
		player p
	JOIN 
		register AS r ON p.ID = r.PlayerID
	WHERE 
		p.ID = #arguments.player_id#
		AND
		p.leaguecode = '#arguments.leaguecode#'
		AND '#arguments.startDate#' 
			BETWEEN 
			IF(ISNULL(r.FirstDay), '1900-01-01', r.FirstDay)
			AND 
			IF(ISNULL(r.LastDay), '2999-12-31', r.LastDay)
		AND p.surname != 'OwnGoal'
	ORDER BY player_lastname
</cfquery>

<cfset i=1>
<cfloop query="QPlayerDetails_query">
	<cfscript>
		QPlayerDetailArray[#i#] = StructNew();
		QPlayerDetailArray[#i#].player_id = #player_id#;
		QPlayerDetailArray[#i#].player_firstname = #player_firstname#;
		QPlayerDetailArray[#i#].player_lastname = #player_lastname#;				
		QPlayerDetailArray[#i#].player_unique_number = #player_regNo#;
		QPlayerDetailArray[#i#].player_date_of_birth = #player_dob#;
		QPlayerDetailArray[#i#].player_notes = #player_notes#;
		i++;
	</cfscript>
</cfloop>
