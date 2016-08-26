<cfset inSeason = 1>
<!--- determine which year involved --->
<cfquery name="getLeagueYear" datasource="zmast">

	SELECT 
		leagueCodeYear
	FROM 
		leagueinfo
	WHERE
		HideThisSeason  = 0
		AND (
		('#arguments.start_date#' BETWEEN seasonStartDate AND seasonEndDate)
		OR
		('#arguments.end_date#' BETWEEN seasonStartDate AND seasonEndDate)
		)
	ORDER BY leagueCodeYear ASC
	LIMIT 2,1

</cfquery>
<cfif getLeagueYear.recordCount IS 0>
	<cfset inSeason = 0>
<cfelse>
	<cfset idColumn = #getLeagueYear.leagueCodeYear#&'id'>
	<cfset variables.dsn = "fm" & getLeagueYear.leagueCodeYear>
</cfif>
