<!--- called by MtchDay.cfm --->

<cfquery name="ShowMatchOfficialsInFixture" datasource="#request.DSN#" >
<!--- mark a fixture row to hide its match officials  --->
UPDATE
	fixture
SET
	HideMatchOfficials = 0
WHERE 
	LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND ID = <cfqueryparam value = #ThisFixtureID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
