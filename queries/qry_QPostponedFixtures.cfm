<!--- Called by MtchDay.cfm --->

<!--- Fixtures Postponed on a specified Match Day --->

<cfquery name="QPostponedFixtures" datasource="#request.DSN#">
SELECT 
	ID
FROM
	fixture 
WHERE
	LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
	AND FixtureDate = '#DateFormat(MDate, 'YYYY-MM-DD')#'
	AND Result = 'P'
</cfquery>

