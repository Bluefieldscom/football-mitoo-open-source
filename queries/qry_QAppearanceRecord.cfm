<!--- called by AppearanceRecord.cfm --->

<cfquery name="QAppearanceRecord" datasource="#request.DSN#" >
	SELECT
		f.fixturedate,
		s.actualshirtnumber as SNumber,
		CONCAT(Left(p.forename,1),'. ',p.surname) as PlayerName,
		o.longcol as Ord,
		d.ShortCol as CompName,
		a.Activity as Activity
	FROM
		shirtnumber s,
		appearance a ,
		fixture f,
		constitution c,
		team t,
		ordinal o,
		player p,
		division d
	WHERE
		s.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND t.ID = #url.TeamID#
		AND s.appearanceid=a.id
		AND a.fixtureid=f.id
		AND f.homeid=c.id and HomeAway='H'
		AND c.teamid = t.id
		AND c.DivisionID = d.id
		AND c.ordinalid = o.id
		AND a.playerid=p.id
UNION ALL
	SELECT
		f.fixturedate,
		s.actualshirtnumber as SNumber,
		CONCAT(Left(p.forename,1),'. ',p.surname) as PlayerName,
		o.longcol as Ord,
		d.ShortCol as CompName,
		a.Activity as Activity
	FROM
		shirtnumber s,
		appearance a ,
		fixture f,
		constitution c,
		team t,
		ordinal o,
		player p,
		division d
	WHERE
		s.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND t.ID = #url.TeamID#
		AND s.appearanceid=a.id
		AND a.fixtureid=f.id
		AND f.awayid=c.id and HomeAway='A'
		AND c.teamid = t.id
		AND c.DivisionID = d.id
		AND c.ordinalid = o.id
		AND a.playerid=p.id
	ORDER BY
		Ord,fixturedate, SNumber
</cfquery>

<cfquery name="QAppearanceRecordMax" dbtype="query">
	SELECT
		MAX(SNumber) as MaxSNo
	FROM
		QAppearanceRecord
</cfquery>
		
