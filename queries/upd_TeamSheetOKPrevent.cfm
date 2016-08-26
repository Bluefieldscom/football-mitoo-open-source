<cfquery name="UpdTeamSheetOKPrevent" datasource="#request.DSN#" >
	UPDATE
		fixture
	SET 
		HomeTeamSheetOK = 1,
		AwayTeamSheetOK = 1
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND FixtureDate = '#ThisDate#'
</cfquery>
