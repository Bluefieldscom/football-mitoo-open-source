<!--- called by CheckPlayerAppearances.cfm --->

<cfquery name="LongLoanAppearances" datasource="#request.DSN#">
SELECT
	IF(o1.longcol IS NULL, t1.longcol, CONCAT(t1.longcol, ' ', o1.longcol)) as HomeTeam, 
	IF(o2.longcol IS NULL, t2.longcol, CONCAT(t2.longcol, ' ', o2.longcol)) as AwayTeam, 
	f.fixturedate,
	f.id as FID,
	a.HomeAway
FROM
	appearance a,
	player p,
	register r,
	fixture f,
	constitution c1,
	team t1,
	ordinal o1,
	constitution c2,
	team t2,
	ordinal o2
WHERE
	a.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND r.regtype='D'
	AND	f.fixturedate BETWEEN 
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
	AND a.playerid=p.id 
	AND r.playerid = p.id 
	AND a.fixtureid = f.id
	AND f.homeid = c1.id
	AND c1.teamid = t1.id
	AND c1.ordinalid = o1.id
	AND f.awayid = c2.id
	AND c2.teamid = t2.id
	AND c2.ordinalid = o2.id
GROUP BY
	f.id, a.homeaway
HAVING
	count(f.id) >= 3
ORDER BY
	f.id
</cfquery>
