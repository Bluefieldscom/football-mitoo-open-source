<!--- called by PlayedWhileUnregistered.cfm --->

<cfquery NAME="PlayedWhileUnregistered" datasource="#request.DSN#">
SELECT
	f.fixturedate ,
	a.homeaway ,
	CONCAT(surname, ', ', forename, ' [', p.ShortCol, ']' ) as PlayerDescription ,
	p.ShortCol as PlayerRegNo ,
	t1.LongCol as HomeTeam,
	t2.LongCol as AwayTeam ,
	o1.LongCol as HomeOrdinal ,
	o2.LongCol as AwayOrdinal
FROM 
	appearance a,
	fixture f,
	player p,
	constitution c1,
	constitution c2 ,
	team t1 ,
	team t2 ,
	ordinal o1 ,
	ordinal o2
WHERE 
	a.leaguecode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
	AND p.shortcol <> 0
	AND p.id NOT IN 
	(SELECT
		playerid
	FROM
		register r
	WHERE
		r.playerid=a.playerid
		AND ((a.HomeAway= 'H' AND r.TeamID=c1.TeamID) OR (a.HomeAway= 'A' AND r.TeamID=c2.TeamID)) 
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
			END )
	AND a.fixtureid = f.id
	AND a.playerid = p.id
	AND f.HomeID = c1.ID
	AND f.AwayID = c2.ID
	AND c1.TeamID = t1.ID
	AND c2.TeamID = t2.ID
	AND c1.OrdinalID = o1.ID
	AND c2.OrdinalID = o2.ID
	ORDER BY
		 PlayerDescription , f.fixturedate ;
</cfquery>