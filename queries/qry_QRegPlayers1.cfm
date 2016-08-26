<cfquery name="QRegPlayers1" datasource="#request.DSN#" >
	SELECT
		COUNT(p.ID) as PlayerCount ,
		t.longcol as ClubName ,
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
	GROUP BY
		ClubName <!--- t.LongCol --->
	ORDER BY
		ClubName <!--- t.LongCol --->
</cfquery>
