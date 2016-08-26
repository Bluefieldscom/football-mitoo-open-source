<!--- called by Unsched.cfm --->
<CFQUERY NAME="QAbandonedMatches" datasource="#request.DSN#"> 
		SELECT 
			f.id, 
			f.HomeID,
			f.AwayID,
			f.FixtureDate,
			CASE
			WHEN o1.longcol IS NULL THEN t1.longcol
			ELSE CONCAT(t1.longcol, ' ', o1.longcol)
			END
				as HomeTeamName,
			CASE
			WHEN o2.longcol IS NULL THEN t2.longcol
			ELSE CONCAT(t2.longcol, ' ', o2.longcol)
			END
				as AwayTeamName,
			f.FixtureNotes
		FROM 
			fixture f, 
			division d, 
			constitution c1, 
			team t1, 
			ordinal o1,
			constitution c2, 
			team t2, 
			ordinal o2
		WHERE 
			f.LeagueCode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND c1.DivisionID = <cfqueryparam value = #DivisionID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
			AND c2.DivisionID = <cfqueryparam value = #DivisionID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
			AND f.Result = 'Q' 
			AND f.HomeID = c1.ID 
			AND c1.DivisionID = d.ID 
			AND c1.TeamID = t1.ID 
			AND c1.OrdinalID = o1.ID
			AND f.AwayID = c2.ID 
			AND c2.DivisionID = d.ID 
			AND c2.TeamID = t2.ID 
			AND c2.OrdinalID = o2.ID
		ORDER BY
			FixtureDate, HomeTeamName, AwayTeamName
</cfquery>
