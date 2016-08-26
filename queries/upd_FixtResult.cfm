<!--- called by InclUpdtAwardedGame.cfm --->

<cfquery name="FixtResult" datasource="#request.DSN#" >
	UPDATE
		fixture
	SET
		Result = '#Form.Result#',
		HomeGoals = NULL ,
		AwayGoals = NULL
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = <cfqueryparam value = #id# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>

