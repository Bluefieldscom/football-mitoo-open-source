<!--- Called by Toolbar_1.cfm --->

<cfquery name="GetAllDates" datasource="#request.DSN#">
SELECT FixtureDate as HDate, Month(FixtureDate) as CalMonth, Year(FixtureDate) as CalYear FROM fixture WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
UNION ALL
SELECT EventDate as HDate, Month(EventDate) as CalMonth, Year(EventDate) as CalYear FROM event WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
</cfquery>

<CFQUERY NAME="GetFixtureDates"  dbtype="query">
	SELECT
		DISTINCT HDate as FixtureDate,
		CalMonth,
		CalYear
	FROM
		GetAllDates
	ORDER BY
		HDate
</CFQUERY>
