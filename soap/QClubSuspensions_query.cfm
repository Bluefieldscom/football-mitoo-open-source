<cfinclude template="QgetLeagueYearFromDates2.cfm">

<cfquery NAME="QClubSuspensions" datasource="#variables.dsn#">

	SELECT
		p.id as Player_id, 
		p.surname as player_Surname,
		p.forename as player_Forename, 
		DATE_FORMAT(s.firstday,'%Y-%m-%d') as suspended_from, 
		DATE_FORMAT(s.lastday,'%Y-%m-%d') as suspended_to,
		cu.club_name as real_club_name,
		cu.club_umbrella_id,
		r.*
	
	FROM fm#getLeagueYear.leagueCodeYear#.suspension AS s
	INNER JOIN fm#getLeagueYear.leagueCodeYear#.player p ON p.id=s.PlayerID
	INNER JOIN fm#getLeagueYear.leagueCodeYear#.register r ON r.PlayerID=s.PlayerID
	INNER JOIN fm#getLeagueYear.leagueCodeYear#.team t ON t.ID=r.TeamID
	
	INNER JOIN fm#getLeagueYear.leagueCodeYear#.constitution c ON c.TeamID=t.ID
	INNER JOIN zmast.lk_constitution lc ON lc.2009id=c.id
	INNER JOIN zmast.club_umbrella cu ON cu.club_umbrella_id=lc.club_umbrella_id
	
	WHERE cu.club_umbrella_id='#club_id#'
	AND '#arguments.start_date#' BETWEEN s.FirstDay AND s.LastDay
	
	GROUP BY p.ID
	
	HAVING
	'#arguments.start_date#'
			BETWEEN
				CASE
				WHEN r.FirstDay IS NULL
				THEN '1900-01-01'
				ELSE r.FirstDay
				END
			 AND 
				CASE
				WHEN r.LastDay IS NULL
				THEN '2999-12-31'
				ELSE r.LastDay
				END 	
				
</cfquery>		
<cfset i=1>
<cfloop query="QClubSuspensions">
	<cfscript>
		QSuspensionByPlayer[#i#] = StructNew();
		QSuspensionByPlayer[#i#].player_id				= #player_id#;
		QSuspensionByPlayer[#i#].player_last_name		= #player_surname#;
		QSuspensionByPlayer[#i#].player_first_name		= #player_forename#;
		QSuspensionByPlayer[#i#].suspended_from			= #suspended_from#;
		QSuspensionByPlayer[#i#].suspended_to			= #suspended_to#;				
		QSuspensionByPlayer[#i#].club_name 				= #real_club_name#;
		QSuspensionByPlayer[#i#].club_umbrella_id 		= #club_umbrella_id#;
		
		i++;
		
	</cfscript>
</cfloop>