<cfinclude template="QgetLeagueYearFromDates2.cfm">

<cfquery NAME="QDivisionSuspensions" datasource="#variables.dsn#">

	SELECT
		p.id as Player_id, 
		p.surname as player_Surname,
		p.forename as player_Forename, 
		DATE_FORMAT(s.firstday,'%Y-%m-%d') as suspended_from, 
		DATE_FORMAT(s.lastday,'%Y-%m-%d') as suspended_to,
		cu.club_name as real_club_name,
		cu.club_umbrella_id,
		lc.id as team_id
	
	FROM fm#getLeagueYear.leagueCodeYear#.suspension AS s
	INNER JOIN fm#getLeagueYear.leagueCodeYear#.player p ON p.id=s.PlayerID
	INNER JOIN fm#getLeagueYear.leagueCodeYear#.register r ON r.PlayerID=s.PlayerID
	INNER JOIN fm#getLeagueYear.leagueCodeYear#.team t ON t.ID=r.TeamID
	
	INNER JOIN fm#getLeagueYear.leagueCodeYear#.constitution c ON c.TeamID=t.ID
	INNER JOIN zmast.lk_constitution lc ON lc.2009id=c.id
	INNER JOIN zmast.club_umbrella cu ON cu.club_umbrella_id=lc.club_umbrella_id
	INNER JOIN zmast.lk_division ld ON ld.id='#arguments.division_id#'
	INNER JOIN fm#getLeagueYear.leagueCodeYear#.division d1 ON d1.ID=ld.#getLeagueYear.leagueCodeYear#id
	
	WHERE s.LeagueCode = d1.LeagueCode
	AND '#arguments.start_date#' BETWEEN s.FirstDay AND s.LastDay
	
	GROUP BY p.ID
	
</cfquery>		
<cfset i=1>
<cfloop query="QDivisionSuspensions">
	<cfscript>
		QSuspensionByPlayer[#i#] = StructNew();
		QSuspensionByPlayer[#i#].player_id				= #player_id#;
		QSuspensionByPlayer[#i#].player_last_name		= #player_surname#;
		QSuspensionByPlayer[#i#].player_first_name		= #player_forename#;
		QSuspensionByPlayer[#i#].suspended_from			= #suspended_from#;
		QSuspensionByPlayer[#i#].suspended_to			= #suspended_to#;				
		QSuspensionByPlayer[#i#].club_name 				= #real_club_name#;
		QSuspensionByPlayer[#i#].club_umbrella_id 		= #club_umbrella_id#;
		QSuspensionByPlayer[#i#].team_id				= #team_id#;
		
		i++;
		
	</cfscript>
</cfloop>