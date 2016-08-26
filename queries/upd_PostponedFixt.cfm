<!--- called by InclBatchUpdate2.cfm --->

<cfquery name="PostponedFixt" datasource="#request.DSN#" >
	UPDATE
		fixture
	SET
		Result = 'P',
		HomeGoals = NULL ,
		AwayGoals = NULL
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = <cfqueryparam value = #id# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>

