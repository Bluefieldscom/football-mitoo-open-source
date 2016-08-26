<cfquery name="UpdtFixture" datasource="#request.DSN#" >
UPDATE
	fixture
SET
	PitchAvailableID = #ThisPA_ID#
WHERE 
	LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND ID = <cfqueryparam value = #FID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>

