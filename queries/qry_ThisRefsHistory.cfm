<!--- called by ThisRefsHistory.cfm --->

<cfquery name="QThisRefsHistory" datasource="#request.DSN#">
SELECT 
	'H' as venue, 
	r.id as RID,
	CASE
	WHEN r.longcol IS NULL
	THEN ' '
	WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0 
	THEN r.LongCol 
	ELSE CONCAT(r.Forename, " ", r.Surname) 
	END as RefsName,
	f.fixturedate,
	d.shortcol as CompCode,
  	CASE WHEN o.longcol IS NULL THEN t.longcol ELSE CONCAT(t.longcol, ' ', o.longcol) END as TeamName
FROM 
	fixture f, 
	referee r, 
	constitution c, 
	team t, 
	ordinal o, 
	division d
WHERE  
	c.teamid=#ThisRefsHist.TeamID# 
	AND c.ordinalid=#ThisRefsHist.OrdinalID# 
 <!--- AND d.id not in (SELECT id FROM division WHERE LeagueCode='#request.filter#' AND notes LIKE '%EXTERNAL%') --->
	AND f.refereeid = r.id 
	AND f.homeid = c.id 
	AND c.teamid = t.id 
	AND c.ordinalid = o.id 
	AND c.divisionid = d.id
UNION ALL
SELECT 
	'A' as venue, 
	r.id as RID,
	CASE
	WHEN r.longcol IS NULL
	THEN ' '
	WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0 
	THEN r.LongCol 
	ELSE CONCAT(r.Forename, " ", r.Surname) 
	END as RefsName,
	f.fixturedate, 
	 d.shortcol as CompCode,
	CASE WHEN o.longcol IS NULL THEN t.longcol ELSE CONCAT(t.longcol, ' ', o.longcol) END as TeamName
FROM 
	fixture f,
	referee r,
	constitution c, 
	team t, 
	ordinal o,
	division d
WHERE 
c.teamid=#ThisRefsHist.TeamID# 
	AND c.ordinalid=#ThisRefsHist.OrdinalID# 
 <!--- AND d.id not in (SELECT id FROM division WHERE LeagueCode='#request.filter#' AND notes LIKE '%EXTERNAL%') --->
	AND f.refereeid = r.id 
	AND f.awayid = c.id 
	AND c.teamid = t.id 
	AND c.ordinalid = o.id 
	AND c.divisionid = d.id
ORDER BY fixturedate;
</cfquery>
