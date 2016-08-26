<!--- Called by PenaltyDeciders.cfm --->

<cfquery name="QPenaltyDeciders" datasource="#request.DSN#">
	SELECT
		f.ID as FID,
		f.HomeID,
		f.AwayID,
		f.FixtureNotes,
		f.HomeGoals,
		f.AwayGoals,
		f.Result,
		f.FixtureDate,
		c1.DivisionID,
		t1.LongCol AS HomeTeam,
		t2.LongCol AS AwayTeam,
		o1.LongCol AS HomeOrdinal,
		o2.LongCol AS AwayOrdinal,
		f.FixtureDate,
		d.LongCol AS CompetitionName
	FROM
		fixture AS f,
		constitution AS c1,
		constitution AS c2,
		team AS t1,
		team AS t2,
		ordinal AS o1,
		ordinal AS o2,
		division AS d
	WHERE
		c1.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND LEFT(d.Notes,2) = 'KO' 
		AND f.FixtureNotes LIKE '%PEN%'
		AND NOT f.FixtureNotes LIKE '%SUSPEN%'
		AND c1.LeagueCode = c2.LeagueCode
		AND c1.ID = f.HomeID
		AND c2.ID = f.AwayID
		AND c1.DivisionID = d.ID
		AND c1.TeamID = t1.ID
		AND c2.TeamID = t2.ID
		AND c1.OrdinalID = o1.ID
		AND c2.OrdinalID = o2.ID
	ORDER BY
		FixtureDate
</cfquery>
