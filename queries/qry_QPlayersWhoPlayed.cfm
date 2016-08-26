<!--- called from TeamList.cfm --->

<cfquery NAME="QPlayersWhoPlayed" datasource="#request.DSN#">
SELECT
	p.ID as PlayerID ,
	CASE
		WHEN p.shortcol = 0 THEN '        OG' 
		WHEN p.Surname = '' THEN 'xxxxxxxxxx' 
		ELSE p.Surname
	END
	as PlayerSurname,
	CASE
		WHEN p.shortcol = 0 THEN '        OG' 
		WHEN p.Forename = '' THEN 'xxxxxxxxxx' 
		ELSE p.Forename
	END
	as PlayerForename,
	p.MediumCol as PlayerDOB ,	
	p.ShortCol as PlayerRegNo ,
	a.GoalsScored as GoalsScored ,
	a.Card as Card ,
	a.StarPlayer as StarPlayer,
	a.Activity as Activity,
	CASE
		WHEN p.shortcol = 0 
		THEN (SELECT 'A')
		ELSE <!--- this subselect may return a NULL if there is no register record within the FirstDay/LastDay range --->
		(SELECT RegType FROM register r, fixture f 
		WHERE r.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND r.PlayerID = p.ID
		AND a.FixtureID = f.ID
		AND f.fixturedate
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
		) 
	END
		as RegType	
FROM
	player AS p, 
	appearance AS a
WHERE
	p.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND a.FixtureID = <cfqueryparam value = #FID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
	AND a.HomeAway = '#HA#' 
	AND a.PlayerID = p.ID
ORDER BY
	PlayerSurname, PlayerForename
</cfquery>

