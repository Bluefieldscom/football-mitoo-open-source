<cfquery name="UpdHomeTeamSheetOK2" datasource="#request.DSN#" >
	UPDATE
		fixture
	SET 
		HomeTeamSheetOK = 1
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = <cfqueryparam value = #FID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
</cfquery>
