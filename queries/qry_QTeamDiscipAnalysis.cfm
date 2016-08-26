<!--- called by TeamDiscipAnalysis.cfm --->

<cfquery name="QTeamDiscipAnalysis0" datasource="#request.DSN#" >
	SELECT
		t.LongCol as TeamName,
		p.ID as PID,
		1 as GAppd,
		a.Card as points
	FROM
		appearance a ,
		team t ,
		ordinal o,
		fixture f ,
		constitution c ,
		player p ,
		register r
	WHERE
		a.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND t.ID = #url.TeamID#
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
		t.LongCol as TeamName,
		p.ID as PID,
		1 as GAppd,
		a.Card as points
	FROM
		appearance a ,
		team t ,
		ordinal o,
		fixture f ,
		constitution c ,
		player p ,
		register r
	WHERE
		a.LeagueCode = <cfqueryparam value = '#request.filter#'	cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND t.ID = #url.TeamID#
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

<cfquery name="QTeamDiscipAnalysis" dbtype="query">
	SELECT
		TeamName,
		PID,
		SUM(GAppd) as GamesAppeared ,
		SUM(points) AS points
	FROM
		qteamdiscipanalysis0
	GROUP BY
		TeamName, PID
	ORDER BY
		Points DESC
</cfquery>
