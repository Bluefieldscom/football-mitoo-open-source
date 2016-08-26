<!--- called by MtchDay.cfm --->

<cfquery name="ShowFixture" datasource="#request.DSN#" >
<!--- convert a TEMP fixture to a published one --->
UPDATE
	fixture
SET
	Result = NULL
WHERE 
	LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND ID = <cfqueryparam value = #ThisFixtureID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
			AND Result = 'T'
</cfquery>
