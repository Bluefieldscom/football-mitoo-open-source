<cfinclude template="QgetLeagueYearFromDates.cfm">

<cfquery name="QAllRegister_query" datasource="#variables.dsn#">
	SELECT 
		ID AS mitoo_register_id, 
		TeamID AS mitoo_team_id,
		PlayerID AS mitoo_player_id,
		IF(ISNULL(FirstDay),"",FirstDay) AS gr_register_first_day,
		IF(ISNULL(LastDay),"",LastDay) AS gr_register_last_day
	FROM 
		register 

	<cfif arguments.limit NEQ "" >
	LIMIT #arguments.limit#
	</cfif>
</cfquery>
<cfset i=1>
<cfloop query="QAllRegister_query">
	<cfscript>
		QAllRegister[#i#] = StructNew();
		QAllRegister[#i#].mitoo_register_id 	= #mitoo_register_id#;
		QAllRegister[#i#].mitoo_team_id 		= #mitoo_team_id#;
		QAllRegister[#i#].mitoo_player_id 		= #mitoo_player_id#;	
		QAllRegister[#i#].gr_register_first_day = #gr_register_first_day#;
		QAllRegister[#i#].gr_register_last_day 	= #gr_register_last_day#;
			
		i++;
	</cfscript>
</cfloop>