<cfinclude template="QgetLeagueYearFromDates.cfm">

<cfquery NAME="QPlayerSuspensions" datasource="#variables.dsn#">
	SELECT
		p.id as PlayerID, 
		p.shortcol as RegNo,  
		p.surname as Surname,
		p.forename as Forename, 
		r.firstday as regfrom, 
		r.lastday as regto,
		t.longcol as ClubName, 
		DATE_FORMAT(s.firstday,'%Y-%m-%d') as suspended_from, 
		DATE_FORMAT(s.lastday,'%Y-%m-%d') as suspended_to,
		s.NumberOfMatches,
		s.id as SID
	FROM
		player AS p, 
		register AS r, 
		team AS t, 
		suspension AS s
	WHERE
		s.LeagueCode = <cfqueryparam value = '#arguments.leaguecode#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND p.LeagueCode = <cfqueryparam value = '#arguments.leaguecode#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND r.LeagueCode = <cfqueryparam value = '#arguments.leaguecode#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND t.LeagueCode = <cfqueryparam value = '#arguments.leaguecode#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND '#arguments.startDate#' BETWEEN s.FirstDay AND s.LastDay
		AND s.PlayerID = p.ID
		AND r.PlayerID = p.ID
		AND p.ID = #arguments.player_id#
		AND t.ID = r.TeamID 
	HAVING
	'#arguments.startDate#'
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
<cfloop query="QPlayerSuspensions">
	<cfscript>
		QSuspensionByPlayer[#i#] = StructNew();
		QSuspensionByPlayer[#i#].SID				= #SID#;
		QSuspensionByPlayer[#i#].firstDay			= #suspended_from#;
		QSuspensionByPlayer[#i#].lastDay			= #suspended_to#;				
		QSuspensionByPlayer[#i#].numberOfMatches 	= #numberOfMatches#;				
		i++;
	</cfscript>
</cfloop>