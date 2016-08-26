<!--- called by Unsched.cfm --->
<cfquery name="QVenueSequence3" datasource="#request.DSN#"> 
SELECT
	f.FixtureDate,
	f.Result,
	f.HomeGoals,
	f.AwayGoals,
	'H' AS venue,
	t.LongCol as TeamName,
	o.LongCol as OrdinalName,
	d.ShortCol as CompetitionCode
FROM
	fixture f,
	constitution c,
	team t,
	ordinal o,
	division d
WHERE
	f.HomeID IN (#IDList#)
	AND FixtureDate < #EndDate#
	AND FixtureDate > #CreateODBCDate(request.CurrentDate)#
	AND c.LeagueCode = f.LeagueCode
	AND t.LeagueCode = f.LeagueCode
	AND o.LeagueCode = f.LeagueCode
	AND c.DivisionID = d.ID
	AND f.AwayID = c.ID
	AND c.TeamID = t.ID
	AND c.OrdinalID = o.ID
UNION ALL
SELECT
	f.FixtureDate,
	f.Result,
	f.HomeGoals,
	f.AwayGoals,
	'A' AS venue,
	t.LongCol as TeamName,
	o.LongCol as OrdinalName,
	d.ShortCol as CompetitionCode
FROM
	fixture f,
	constitution c,
	team t,
	ordinal o,
	division d
WHERE
	f.AwayID IN (#IDList#)
	AND FixtureDate < #EndDate#
	AND FixtureDate > #CreateODBCDate(request.CurrentDate)#
	AND c.LeagueCode = f.LeagueCode
	AND t.LeagueCode = f.LeagueCode
	AND o.LeagueCode = f.LeagueCode
	AND c.DivisionID = d.ID
	AND f.HomeID = c.ID
	AND c.TeamID = t.ID
	AND c.OrdinalID = o.ID
ORDER BY
	FixtureDate
</cfquery>
