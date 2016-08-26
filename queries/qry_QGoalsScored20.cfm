<!--- called by TopTwenty.cfm --->


<!--- top twenty goalscorers in all competitions --->
<cfquery name="QGoalsScored" datasource="#request.DSN#">
	SELECT 
		a.PlayerID as PlayerID ,
		p.Surname, p.Forename ,
		t.LongCol as TeamName ,
		COUNT(a.PlayerID) as GamesPlayed ,
		COALESCE(SUM(a.GoalsScored),0) as Goals
	FROM
		appearance a
		INNER JOIN player p ON p.ID = a.PlayerID
		INNER JOIN register r ON r.PlayerID = p.ID
		INNER JOIN team t ON t.ID = r.TeamID
	WHERE
		t.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype = "CF_SQL_VARCHAR" maxlength = "5">
		AND	(CURRENT_DATE BETWEEN 
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
						
	GROUP BY
		PlayerID, Surname, Forename, TeamName 
	HAVING
		Goals > 0 
	ORDER BY
		Goals DESC, Surname, Forename
	LIMIT 20
</cfquery>


<!--- top twenty star players in all competitions --->
<cfquery name="QStarPlayerAwards" datasource="#request.DSN#">
	SELECT 
		a.PlayerID as PlayerID ,
		p.Surname, p.Forename ,
		t.LongCol as TeamName ,
		COUNT(a.PlayerID) as TotalStars
	FROM
		appearance a
		INNER JOIN player p ON p.ID = a.PlayerID
		INNER JOIN register r ON r.PlayerID = p.ID
		INNER JOIN team t ON t.ID = r.TeamID
	WHERE
		t.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype = "CF_SQL_VARCHAR" maxlength = "5">
		AND a.StarPlayer = 1
		AND	(CURRENT_DATE BETWEEN 
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
	GROUP BY
		PlayerID, Surname, Forename, TeamName 
	ORDER BY
		TotalStars DESC, Surname, Forename
	LIMIT 20
</cfquery>
