<!--- called from SeeGoalScorers.cfm --->

<cfquery name="QGoalsScored" datasource="#request.DSN#" >
	SELECT
		a.PlayerID as PlayerID ,
		p.Surname,
		p.forename,
		p.shortcol,
		COUNT(p.ID) as GamesPlayed,
		COALESCE(SUM(a.GoalsScored),0) as Goals,
		SUM(IF(a.Activity=1,1,0)) as Apps1,
		SUM(IF(a.Activity=2,1,0)) as Apps2,
		SUM(IF(a.Activity=3,1,0)) as Apps3,
		(SELECT t.longcol  FROM register r, team t WHERE r.playerid=a.PlayerID AND r.teamid=t.id AND
				MAX(f.fixturedate) BETWEEN 
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
		as LastAppearedFor,
		(SELECT t.longcol  FROM register r, team t WHERE r.playerid=a.PlayerID AND r.teamid=t.id AND
				Now() BETWEEN 
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
		as CurrentlyRegisteredTo
	FROM
		appearance a ,
		player  p ,
		division d,
		constitution c ,
		fixture f
	WHERE
		<cfif ListFind("Yellow",request.SecurityLevel) >d.notes NOT LIKE '%HideDivision%' AND</cfif>	
		 p.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND c.DivisionID = d.id
		AND p.shortcol <> 0 
		AND p.ID = a.PlayerID 
		AND a.FixtureID = f.ID
		AND f.HomeID=c.id
	GROUP BY
		PlayerID 
	HAVING
		Goals > 0 
	ORDER BY
		Goals DESC, Surname, Forename 
</cfquery>
