<cfquery name="UpdtFixture05" datasource="#request.DSN#" >
	UPDATE
		fixture
	SET
		PitchAvailableID = #GetPitchAvailableID.PA_ID#
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = #FindFixture05.FID#
</cfquery>
