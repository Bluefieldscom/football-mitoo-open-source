<!--- Called by MissingAppearances.cfm --->

<cfquery name="QAwayAppearances" datasource="#request.DSN#" >
	SELECT 
		DISTINCT f.ID as FID,
		COUNT(a.ID) as CountID,
		f.AwayTeamSheetOK
	FROM
		fixture f LEFT JOIN appearance a ON f.ID = a.FixtureID
	WHERE
		a.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype = "CF_SQL_VARCHAR" maxlength = "5">
		AND a.HomeAway = 'A' 
	GROUP BY
		FID
	HAVING
		CountID > 6
</cfquery>
