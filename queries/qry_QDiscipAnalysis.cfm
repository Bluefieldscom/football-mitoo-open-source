<!--- called by DiscipAnalysis.cfm --->

<cfquery name="QDiscipAnalysis0" datasource="#request.DSN#" >
	SELECT
		CONCAT(t.LongCol, ' ', IF(o.LongCol IS NULL, '', o.LongCol)) as TeamName,
		t.ID as TID,
		o.ID as OID,
		a.Card as points,
		IF(a.card=1 OR a.card=4, 1, 0) as yellowcards,
		IF(a.card=3 OR a.card=4, 1, 0) as redcards
	FROM
		appearance a ,
		team t ,
		ordinal o,
		fixture f ,
		constitution c ,
		player p ,
		register r
	WHERE
		a.LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND a.Card > 0
		AND a.PlayerID = p.ID
		AND r.PlayerID = p.ID
		AND (f.FixtureDate BETWEEN 
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
		END )
		AND a.FixtureID = f.ID
		AND (a.HomeAway = 'H' AND f.HomeID = c.ID)
		AND c.TeamID = t.ID
		AND c.OrdinalID = o.ID
UNION ALL
	SELECT
		CONCAT(t.LongCol, ' ', IF(o.LongCol IS NULL, '', o.LongCol)) as TeamName,
		t.ID as TID,
		o.ID as OID,
		a.Card as points,
		IF(a.card=1 OR a.card=4, 1, 0) as yellowcards,
		IF(a.card=3 OR a.card=4, 1, 0) as redcards
	FROM
		appearance a ,
		team t ,
		ordinal o,
		fixture f ,
		constitution c ,
		player p ,
		register r
	WHERE
		a.LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND a.Card > 0
		AND a.PlayerID = p.ID
		AND r.PlayerID = p.ID
		AND (f.FixtureDate BETWEEN 
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
		END )
		AND a.FixtureID = f.ID
		AND (a.HomeAway = 'A' AND f.AwayID = c.ID)
		AND c.TeamID = t.ID
		AND c.OrdinalID = o.ID

</cfquery>

<cfquery name="QDiscipAnalysis" dbtype="query">
	SELECT 	
		TeamName, 
		TID,
		OID, 
		SUM(points) AS points,
		SUM(yellowcards) AS yellowcards,
		SUM(redcards) AS redcards
	FROM
		qdiscipanalysis0
	GROUP BY
		TeamName, TID, OID
	ORDER BY
		Points DESC, TeamName
</cfquery>
