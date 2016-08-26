<cfquery name="UpdtFixture01" datasource="#request.DSN#" >
	UPDATE
		fixture
	SET
		PitchAvailableID = 0
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = #FindFixture01.ID#
</cfquery>
