<cfquery name="QRegPlayers3" datasource="#request.DSN#" >
	SELECT
		COUNT(*) as LapsedPendingCount ,
		t.longcol as ClubName,
		t.ID as TID
	FROM
		(player AS p LEFT OUTER JOIN register AS r 
			ON p.ID = r.PlayerID) 
			LEFT OUTER JOIN team AS t 
				ON r.TeamID = t.ID 
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND NOT (r.PlayerID IS NOT NULL AND r.TeamID  IS NULL)
		AND p.shortcol <> 0 <!--- ignore Own Goal --->
		AND r.TeamID IS NOT NULL
AND NOT (CURRENT_DATE  BETWEEN 
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
			END)
	AND (CURRENT_DATE >
			CASE
			WHEN r.FirstDay IS NULL
			THEN '1900-01-01'
			ELSE r.FirstDay
			END)	
	GROUP BY
		ClubName <!--- t.LongCol --->
	ORDER BY
		ClubName <!--- t.LongCol --->
		
</cfquery>
