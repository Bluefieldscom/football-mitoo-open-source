<!--- called by ......... --->

<cfquery NAME="QRefereeCards" datasource="#request.DSN#">
	SELECT
		p.id as PlayerID, 
		p.shortcol as RegNo,  
		p.surname as Surname,
		p.forename as Forename, 
		r.firstday as regfrom, 
		r.lastday as regto,
		t.longcol as ClubName, 
		a.Card as CardValue,
		d.LongCol as CompetitionName,
		d.mediumcol as SortOrder,
		CASE
		WHEN LENGTH(TRIM(refs.forename)) = 0 AND LENGTH(TRIM(refs.surname)) = 0
		THEN refs.LongCol
		ELSE CONCAT(refs.forename, " ", refs.surname)
		END
		as RefereeName
	FROM
		player AS p, 
		register AS r, 
		team AS t, 
		appearance AS a,
		fixture AS f,
		division AS d ,
		constitution AS c,
		referee AS refs
	WHERE
		a.card > 0
		AND a.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND p.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND r.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND t.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND f.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND f.fixturedate = '#ThisDate#'
		AND f.ID = a.FixtureID
		AND a.PlayerID = p.ID
		AND r.PlayerID = p.ID
		AND t.ID = r.TeamID
		AND f.HomeID = c.ID
		AND c.DivisionID = d.ID
		AND f.RefereeID = refs.ID
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
		SortOrder, ClubName, surname, forename;
</cfquery>		
