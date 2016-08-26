<!--- called by InclAdjustNewLeagueTableRows.cfm --->

<cfquery name="QAdjustRows100" datasource="#request.DSN#">
	SELECT <!--- Julian, always remember to have this lonely SELECT because you will get lots of SQL errors if it is missing!!!!  --->
		ID as ConstitutionID,
		(SELECT Rank FROM leaguetable WHERE DivisionID = #ThisDivisionID# AND ConstitutionID = c.ID) as Rank,
		(SELECT LongCol FROM team AS t WHERE t.ID = c.TeamID) as TeamName,
		(SELECT LongCol FROM ordinal AS o WHERE o.ID = c.OrdinalID) as OrdinalName,
		(SELECT COALESCE(SUM(f.HomeGoals),0) FROM fixture AS f WHERE f.HomeID = c.ID AND f.AwayID IN (#CIDList#) AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL ) as SumHomeGoalsFor,
		(SELECT COALESCE(SUM(f.AwayGoals),0) FROM fixture AS f WHERE f.HomeID = c.ID AND f.AwayID IN (#CIDList#) AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL ) as SumHomeGoalsAgainst,
		(SELECT COALESCE(SUM(f.AwayGoals),0) FROM fixture AS f WHERE f.AwayID = c.ID AND f.HomeID IN (#CIDList#) AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL ) as SumAwayGoalsFor,
		(SELECT COALESCE(SUM(f.HomeGoals),0) FROM fixture AS f WHERE f.AwayID = c.ID AND f.HomeID IN (#CIDList#) AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL ) as SumAwayGoalsAgainst
	FROM
		constitution AS c
	WHERE
		c.LeagueCode = '#request.filter#'
		AND c.ID IN (#CIDList#) 
</cfquery>
