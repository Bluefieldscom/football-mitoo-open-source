<!--- called by DiscipAnalysis.cfm --->

<cfquery name="QDiscipCardHist" datasource="#request.DSN#" >
	SELECT
		'Red' as CardType,
		a.PlayerID,
		IF(p.Surname IS NULL, '-', p.Surname) as PlayerSurname,
		IF(p.Forename IS NULL, '-', p.Forename) as PlayerForename,
		p.ShortCol as PlayerNo
	FROM
		appearance AS a,
		player AS p
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND a.PlayerID = #ListGetAt(PlayerIDList,x)#
		AND a.Card = 3
		AND a.FixtureID IN (
							SELECT
								f.ID
							FROM
								appearance app ,
								constitution c,
								fixture f
							WHERE
								f.leaguecode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
								AND app.playerid = a.playerID
								AND c.TeamID = #url.TeamID#
								AND c.OrdinalID = #url.OrdinalID#
								AND app.FixtureID = f.ID
								AND ((app.HomeAway = 'H' and f.HomeID = c.ID) OR (app.HomeAway = 'A' and f.AwayID = c.ID))
							)
			AND p.ID = a.PlayerID
	UNION ALL
	SELECT
		'Yellow' as CardType,
		a.PlayerID,
		p.Surname as PlayerSurname,
		p.Forename as PlayerForename,
		p.ShortCol as PlayerNo
	FROM
		appearance AS a,
		player AS p
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND a.PlayerID = #ListGetAt(PlayerIDList,x)#
		AND a.Card = 1
		AND a.FixtureID IN (
							SELECT
								f.ID
							FROM
								appearance app ,
								constitution c,
								fixture f
							WHERE
								f.leaguecode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
								AND app.playerid = a.playerID
								AND c.TeamID = #url.TeamID#
								AND c.OrdinalID = #url.OrdinalID#
								AND app.FixtureID = f.ID
								AND ((app.HomeAway = 'H' and f.HomeID = c.ID) OR (app.HomeAway = 'A' and f.AwayID = c.ID))
							)
		AND p.ID = a.PlayerID
	UNION ALL
	SELECT
		'Orange' as CardType,
		a.PlayerID,
		p.Surname as PlayerSurname,
		p.Forename as PlayerForename,
		p.ShortCol as PlayerNo
	FROM
		appearance AS a,
		player AS p
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND a.PlayerID = #ListGetAt(PlayerIDList,x)#
		AND a.Card = 4
		AND a.FixtureID IN (
							SELECT
								f.ID
							FROM
								appearance app ,
								constitution c,
								fixture f
							WHERE
								f.leaguecode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
								AND app.playerid = a.playerID
								AND c.TeamID = #url.TeamID#
								AND c.OrdinalID = #url.OrdinalID#
								AND app.FixtureID = f.ID
								AND ((app.HomeAway = 'H' and f.HomeID = c.ID) OR (app.HomeAway = 'A' and f.AwayID = c.ID))
							)
		AND p.ID = a.PlayerID
	ORDER BY CardType
</cfquery>

