<!--- called by DiscipAnalysis.cfm --->

<cfquery name="QDiscipAnalysisP" datasource="#request.DSN#" >
	SELECT
		CONCAT(p.Surname, " ", p.Forename) as PlayerName,
		p.ID as PID  ,
		COALESCE(SUM(a.Card),0) as Points ,
		COUNT(p.ID) as GamesPlayed ,
		CONCAT(t.LongCol, ' ', IF(o.LongCol IS NULL, '', o.LongCol)) as TeamName
	FROM
		appearance a ,
		team t ,
		ordinal o,
		fixture f ,
		constitution c ,
		player p ,
		register r ,
		division d
	WHERE
		a.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND t.ID = <cfqueryparam value = #URL.TeamID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND o.ID = <cfqueryparam value = #URL.OrdinalID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND d.ID NOT IN (SELECT ID FROM division WHERE LeagueCode=a.LeagueCode AND left(notes,2)='KO')
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
		AND ((a.HomeAway = 'H' AND f.HomeID = c.ID) OR (a.HomeAway = 'A' AND f.AwayID = c.ID))
		AND c.TeamID = t.ID
		AND c.OrdinalID = o.ID
		AND c.DivisionID = d.ID
	GROUP BY
		PlayerName, PID 
	HAVING
		Points > 0
	ORDER BY
		Points DESC, PlayerName 

		
</cfquery>
