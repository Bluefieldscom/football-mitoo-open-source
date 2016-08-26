<!--- called from SeeGoalScorers.cfm --->

<cfquery name="QGoalsScored" datasource="#request.DSN#" >
	SELECT
		a.PlayerID as PlayerID ,
		p.Surname,
		p.forename,
		p.shortcol,
		t.LongCol as TeamName,
		COUNT(p.ID) as GamesPlayed,
		COALESCE(SUM(a.GoalsScored),0) as Goals,
		SUM(IF(a.Activity=1,1,0)) as Apps1,
		SUM(IF(a.Activity=2,1,0)) as Apps2,
		SUM(IF(a.Activity=3,1,0)) as Apps3
	FROM
		appearance AS a ,
		player AS p ,
		register AS r ,
		team AS t ,
		fixture f
	WHERE
		t.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND CURRENT_DATE
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
		AND p.ID = a.PlayerID 
		AND p.ID = r.PlayerID 
		AND t.ID = r.TeamID
		AND a.FixtureID = f.ID
	GROUP BY
		PlayerID 
	HAVING
		Goals > 0
	ORDER BY
		Goals DESC, Surname, Forename 
</cfquery>
