<!--- called by MtchDay.cfm --->

<!--- get all teams playing today 
<cfquery name="QPlayingToday2" datasource="#request.DSN#">
SELECT 
	CASE
	WHEN o.LongCol IS NULL
	THEN t.LongCol
	ELSE CONCAT(t.LongCol, " ", o.LongCol)
	END
	as TeamName,
	t.ID as TID,
	o.ID as OID
FROM
	fixture f, 
	constitution c, 
	team t, 
	ordinal o,
	division d
WHERE
	f.fixturedate='#ThisDate#' 
	AND f.leaguecode = <cfqueryparam value='#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND	d.ID NOT IN (SELECT ID FROM division WHERE LeagueCode=f.leaguecode AND Notes LIKE '%MultipleMatches%')
	AND c.id=f.homeid
	AND c.teamid=t.id
	AND c.ordinalid=o.id
	AND c.divisionid=d.ID
UNION ALL
SELECT 
	CASE
	WHEN o.LongCol IS NULL
	THEN t.LongCol
	ELSE CONCAT(t.LongCol, " ", o.LongCol)
	END
	as TeamName,
	t.ID as TID,
	o.ID as OID
FROM
	fixture f, 
	constitution c, 
	team t, 
	ordinal o,
	division d
WHERE
	f.fixturedate='#ThisDate#' 
	AND f.leaguecode = <cfqueryparam value='#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND	d.ID NOT IN (SELECT ID FROM division WHERE LeagueCode=f.leaguecode AND Notes LIKE '%MultipleMatches%')
	AND c.id=f.awayid
	AND c.teamid=t.id
	AND c.ordinalid=o.id
	AND c.divisionid=d.ID
ORDER BY
	TeamName
</cfquery>
--->
