<!--- called by CardAnalysis.cfm --->

<cfquery name="QCardHist" datasource="#request.DSN#" >
	SELECT
		'Red' as CardType,
		a.PlayerID,
		p.Surname as PlayerSurname,
		p.Forename as PlayerForename,
		p.ShortCol as PlayerNo ,
		CASE
		WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0
		THEN r.LongCol
		ELSE CONCAT(r.Forename, " ", r.Surname)
		END
		as RefsName ,
		f.FixtureDate as FixtureDate
	FROM
		appearance AS a,
		player AS p ,
		fixture AS f ,
		referee AS r
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND a.PlayerID = #ListGetAt(PlayerIDList,x)#	
		AND Card = 3 
		AND p.ID = a.PlayerID 
		AND f.ID = a.FixtureID 
		AND r.ID = f.RefereeID
	UNION ALL
	SELECT
		'Yellow' as CardType,
		a.PlayerID,
		p.Surname as PlayerSurname,
		p.Forename as PlayerForename,
		p.ShortCol as PlayerNo ,
		CASE
		WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0
		THEN r.LongCol
		ELSE CONCAT(r.Forename, " ", r.Surname)
		END
		as RefsName ,
		f.FixtureDate as FixtureDate
	FROM
		appearance AS a,
		player AS p ,
		fixture AS f ,
		referee AS r
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND a.PlayerID = #ListGetAt(PlayerIDList,x)#	
		AND Card = 1 
		AND p.ID = a.PlayerID 
		AND f.ID = a.FixtureID 
		AND r.ID = f.RefereeID
	UNION ALL
	SELECT
		'Orange' as CardType,
		a.PlayerID,
		p.Surname as PlayerSurname,
		p.Forename as PlayerForename,
		p.ShortCol as PlayerNo ,
		CASE
		WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0
		THEN r.LongCol
		ELSE CONCAT(r.Forename, " ", r.Surname)
		END
		as RefsName ,
		f.FixtureDate as FixtureDate
	FROM
		appearance AS a,
		player AS p ,
		fixture AS f ,
		referee AS r
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND a.PlayerID = #ListGetAt(PlayerIDList,x)#	
		AND Card = 4 
		AND p.ID = a.PlayerID 
		AND f.ID = a.FixtureID 
		AND r.ID = f.RefereeID
	ORDER BY FixtureDate
</cfquery>
