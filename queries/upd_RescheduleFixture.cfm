<!--- called by MtchDay.cfm --->

<cfquery name="ReschedFixture" datasource="#request.DSN#" >
	UPDATE
		fixture
	SET
		FixtureDate = '#DateFormat(MatchDate,"YYYY-MM-DD")#'
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = <cfqueryparam value = #ThisFixtureID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
