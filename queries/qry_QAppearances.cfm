<!--- called by AppearanceAnalysis.cfm --->

<cfquery name="QAppearances" datasource="#request.DSN#" >
	SELECT
		a.PlayerID as PlayerID ,
		CONCAT(p.Surname, " ", p.Forename) as PlayerName ,
		p.Surname as PlayerSurname,
		IF(p.Forename='', '-', p.Forename) as PlayerForename,
		p.ShortCol as PlayerNo ,
		COUNT(a.ID) as Apps ,
		COALESCE(SUM(GoalsScored),0) as Goals,
		(SELECT count(id) from appearance where playerid=a.PlayerID and activity=1) as Apps1,
		(SELECT count(id) from appearance where playerid=a.PlayerID and activity=2) as Apps2,
		(SELECT count(id) from appearance where playerid=a.PlayerID and activity=3) as Apps3
	FROM
		appearance AS a ,
		player AS p ,
		constitution AS c,
		fixture AS f
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND c.TeamID = <cfqueryparam value = #URL.TeamID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND ((c.ID = f.HomeID 
				AND a.HomeAway = 'H') 
			OR (c.ID = f.AwayID 
				AND a.HomeAway = 'A')) 
		AND f.ID = a.FixtureID 
		AND p.ID = a.PlayerID 
	GROUP BY
		PlayerID, PlayerName, PlayerNo <!--- a.PlayerID, p.LongCol, p.ShortCol --->
	ORDER BY
		PlayerName <!--- p.LongCol --->
</cfquery>
