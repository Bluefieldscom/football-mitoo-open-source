<cfquery name="QSatisfyFixtures" datasource="#request.DSN#" >
	SELECT  
		f.fixturedate, 
		CASE
		WHEN o1.LongCol IS NULL THEN t1.LongCol
		ELSE CONCAT(t1.LongCol, ' ', o1.LongCol)
		END
		as HomeTeamName,
		CASE
		WHEN o2.LongCol IS NULL THEN t2.LongCol
		ELSE CONCAT(t2.LongCol, ' ', o2.LongCol)
		END
		as AwayTeamName,
		f.Result,
		f.HomeGoals,
		f.AwayGoals,
		f.ID as FixtureID,
		d.Longcol as CompetitionName,
		k.Longcol as KORoundDescription,
		CASE
		WHEN (t1.ID = #QMatchbanHeader.TeamID# AND o1.ID = #QMatchbanHeader.OrdinalID# AND c1.MatchBanFlag = 1) OR (t2.ID = #QMatchbanHeader.TeamID# AND o2.ID = #QMatchbanHeader.OrdinalID# AND c2.MatchBanFlag = 1)
		THEN 1
		ELSE 0
		END
		as DoesNotCountTowardsMatchBasedSuspensions
	FROM 
		fixture f,
		constitution c1,
		constitution c2,
		team t1,
		team t2,
		ordinal o1,
		ordinal o2,
		division d,
		KORound k
	WHERE
		((t1.ID = #QMatchbanHeader.TeamID# AND o1.ID = #QMatchbanHeader.OrdinalID#) OR (t2.ID = #QMatchbanHeader.TeamID# AND o2.ID = #QMatchbanHeader.OrdinalID#))
		AND f.leaguecode= <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND f.fixturedate >= '#DateFormat(PlayerList.FirstDayOfSuspension,"YYYY-MM-DD")#'
		AND f.fixturedate > '#DateFormat(OldestFixtureDate,"YYYY-MM-DD")#'
		AND f.HomeID = c1.ID
		AND c1.TeamID = t1.ID
		AND c1.OrdinalID = o1.ID
		AND f.AwayID = c2.ID
		AND c2.TeamID = t2.ID
		AND c2.OrdinalID = o2.ID
		AND c1.DivisionID = d.ID
		AND f.KORoundID=k.ID
	ORDER BY
		f.fixturedate
</cfquery>
