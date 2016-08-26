<cfquery name="UpdtFixture02" datasource="#request.DSN#" >
	UPDATE
		fixture
	SET
		PitchAvailableID = <cfqueryparam value = #ID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = #FindFixture02.FID#
</cfquery>
