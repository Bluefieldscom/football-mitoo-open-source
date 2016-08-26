<cfquery name="UpdtFixture" datasource="#request.DSN#" >
UPDATE
	fixture
SET
	PitchAvailableID = 0
WHERE
	LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND FixtureDate = '#ThisBookingDate#'
	AND PitchAvailableID = <cfqueryparam value = #ThisPA_ID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
