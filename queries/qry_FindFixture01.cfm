<cfquery name="FindFixture01" datasource="#request.DSN#" >
	SELECT
		ID
	FROM
		fixture
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND PitchAvailableID = <cfqueryparam value = #ID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
