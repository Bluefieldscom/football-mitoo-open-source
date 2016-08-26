<!--- called by MtchDay.cfm --->
<!--- see if any team is playing more than one game today to provide a warning --->





<cfquery name="PlayingMoreThanOnceToday" datasource="#request.DSN#">
	SELECT
		count(TeamName) as NoOfTimes,
		TeamName
	FROM
(SELECT 
	CASE
	WHEN o.LongCol IS NULL
	THEN t.LongCol
	ELSE CONCAT(t.LongCol, " ", o.LongCol)
	END
	as TeamName
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
	<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) ><!--- don't count TEMP fixtures if not logged in --->
	AND	f.ID NOT IN (SELECT ID FROM fixture WHERE LeagueCode=f.leaguecode AND Result='T')
	</cfif>
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
	as TeamName
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
	<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) ><!--- don't count TEMP fixtures if not logged in --->
	AND	f.ID NOT IN (SELECT ID FROM fixture WHERE LeagueCode=f.leaguecode AND Result='T')
	</cfif>
	AND c.id=f.awayid
	AND c.teamid=t.id
	AND c.ordinalid=o.id
	AND c.divisionid=d.ID
ORDER BY
	TeamName) as QAlias
	GROUP BY
		TeamName
	HAVING
		NoOfTimes > 1 
</cfquery>

<!---
<cfquery name="PlayingMoreThanOnceToday" dbtype="query">
	SELECT
		count(TeamName) as NoOfTimes,
		TeamName,
		TID,
		OID
	FROM
		QPlayingToday2
	GROUP BY
		TeamName,TID,OID
	HAVING
		NoOfTimes > 1
</cfquery>
--->

