<!--- called by LeagueLeadingGoalscorers.cfm --->

<cfquery name="QCurrentTeam" datasource="#request.DSN#">
	SELECT
		t.LongCol as TeamName,
		o.LongCol as OrdinalName
 	FROM
		fixture f,
		appearance a,
		division d,
		constitution c,
		team t,
		ordinal o
	WHERE
		d.ID = #DivisionID#
		AND f.fixturedate = #QGoalsScored.MostRecentDatePlayed#
		AND a.playerID = #PlayerID#
		AND a.FixtureID = f.ID
		AND ((c.ID = f.HomeID and a.HomeAway = 'H') OR (c.ID = f.AwayID and a.HomeAway = 'A'))
		AND	t.ID = c.TeamID
		AND o.ID = c.OrdinalID
		AND c.DivisionID = d.ID
</cfquery>
