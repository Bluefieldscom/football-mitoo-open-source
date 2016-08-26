<!--- called by CardAnalysis.cfm --->

<cfquery name="QCardAnalysisP" datasource="#request.DSN#" >
	SELECT
		CONCAT(p.Surname, " ", p.Forename) as PlayerName ,
		p.ID as PID ,
		COALESCE(SUM(a.Card),0) as Points ,
		COUNT(p.ID) as GamesPlayed 
	FROM
		register AS r ,
		team AS t ,
		appearance AS a ,
		fixture f,
		player AS p
	WHERE
		t.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND t.ID = <cfqueryparam value = #URL.TeamID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND p.ID = a.PlayerID 
		AND p.ID = r.PlayerID 
		AND t.ID = r.TeamID
		AND a.FixtureID = f.ID
		AND f.FixtureDate BETWEEN 
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
	GROUP BY
		PID <!--- p.Longcol, p.ID --->
	HAVING
		Points > 0 <!--- SUM(a.Card) > 0 --->
	ORDER BY
		Points DESC, PlayerName <!--- SUM(a.Card) DESC, p.Longcol --->
</cfquery>
