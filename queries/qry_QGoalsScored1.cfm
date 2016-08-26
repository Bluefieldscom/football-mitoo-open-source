<!--- called by LeagueTab.cfm --->

<cfquery name="QGoalsScored" datasource="#request.DSN#" maxrows="200">
	SELECT
		a.PlayerID as PlayerID,
		p.Surname,
		p.Forename,
		p.ShortCol as PlayerNo,
		COUNT(p.ID) as GamesPlayed,
		COALESCE(SUM(a.GoalsScored),0) as Goals,
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
		<!---
		,
		(SELECT count(id)  FROM register r where r.playerid=a.PlayerID ) as NumberOfRegistrations
		--->
	FROM
		appearance AS a,
		player AS p,
		division d,
		constitution c,
		fixture f
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#'	cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND c.DivisionID = <cfqueryparam value = #DivisionID# cfsqltype="CF_SQL_INTEGER">
		AND p.shortcol <> 0 
		AND p.ID = a.PlayerID
		AND c.DivisionID = d.ID
		AND a.fixtureid=f.id
		AND f.HomeID=c.id
	GROUP BY
		PlayerID, Surname, Forename, PlayerNo
	HAVING
		Goals > 0
	ORDER BY
		Goals DESC, Surname, Forename		
</cfquery>		
