<!--- called by MtchDay.cfm --->

<cfquery name="ShowFixture" datasource="#request.DSN#" >
<!--- convert a published fixture to a TEMP one  --->
UPDATE
	fixture
SET
	Result = 'T'
WHERE 
	LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND ID = <cfqueryparam value = #ThisFixtureID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
