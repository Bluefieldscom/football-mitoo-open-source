<!--- called by CurrentSuspensions.cfm --->

<cfquery NAME="QSuspensions" datasource="#request.DSN#">
	SELECT
		p.id as PlayerID, 
		p.shortcol as RegNo,  
		p.surname as Surname,
		p.forename as Forename, 
		r.firstday as regfrom, 
		r.lastday as regto,
		t.longcol as ClubName, 
		s.firstday as suspended_from, 
		s.lastday as suspended_to,
		s.NumberOfMatches
	FROM
		player AS p, 
		register AS r, 
		team AS t, 
		suspension AS s
	WHERE
		s.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND p.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND r.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND t.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND '#ThisDate#' BETWEEN s.FirstDay AND s.LastDay
		AND s.PlayerID = p.ID
		AND r.PlayerID = p.ID
		AND t.ID = r.TeamID 
	HAVING
	'#ThisDate#'
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
	ORDER BY
		ClubName, surname, forename, suspended_from
</cfquery>		



