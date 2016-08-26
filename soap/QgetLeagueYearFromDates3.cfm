<!--- this flag determines if main query will be processed --->
<cfset inSeason = 1>
<!--- determine which year involved --->
<cfquery name="getLeagueYear" datasource="zmast">

	SELECT 
		MAX(leagueCodeYear) AS leagueCodeYear
	FROM 
		leagueinfo
	WHERE
		leaguecodeprefix = '#arguments.league_code#'
	AND
		HideThisSeason  = 0
	AND
	(
		('#arguments.start_date#' BETWEEN seasonStartDate AND seasonEndDate)
		OR
		('#arguments.end_date#' BETWEEN seasonStartDate AND seasonEndDate)
	)

</cfquery>

<cfif (getLeagueYear.recordCount IS 0) OR NOT IsNumeric(getLeagueYear.leagueCodeYear)>
	<!--- set flag to abort processing - cfabort cannot be used --->
	<cfset inSeason = 0>
<cfelse>
	<cfset idColumn = #getLeagueYear.leagueCodeYear#&'id'>
	<cfset variables.dsn = "fm" & getLeagueYear.leagueCodeYear>
</cfif>
