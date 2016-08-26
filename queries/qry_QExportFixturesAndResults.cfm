<!--- Called by ExportFixturesAndResultsXLS.cfm --->

<CFQUERY NAME="QExportFixturesAndResults" datasource="#request.DSN#">
	SELECT
		FixtureDate,
		d.Longcol as DivisionName,
		CASE
		WHEN o1.longcol IS NULL THEN t1.longcol
		ELSE CONCAT(t1.longcol, ' ', o1.longcol)
		END
			as HomeTeamName,
		f.HomeGoals as HomeScore,
		f.AwayGoals as AwayScore,
		CASE
		WHEN o2.longcol IS NULL THEN t2.longcol
		ELSE CONCAT(t2.longcol, ' ', o2.longcol)
		END
			as AwayTeamName,
		f.FixtureNotes
	FROM
		fixture f,
		constitution c1,
		constitution c2,
		division d,
		team t1,
		team t2,
		ordinal o1,
		ordinal o2
	WHERE
		f.leaguecode='#request.filter#'
		AND f.HomeID = c1.ID
		AND f.AwayID = c2.ID
		AND c1.TeamID = t1.ID
		AND c2.TeamID = t2.ID
		AND c1.OrdinalID = o1.ID
		AND c2.OrdinalID = o2.ID
		AND c1.DivisionID = d.ID
	ORDER BY
		FixtureDate, d.Longcol,t1.longcol
</CFQUERY>	
