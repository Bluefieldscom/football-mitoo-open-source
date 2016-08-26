<cfquery name="UpdTeamSheetOKAllow" datasource="#request.DSN#" >
	UPDATE
		fixture
	SET 
		HomeTeamSheetOK = 0,
		AwayTeamSheetOK = 0
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND FixtureDate = '#ThisDate#'
</cfquery>
