<!--- called from MoveToMisc.cfm --->

<cfquery name="QGetIDMisc003" datasource="#request.DSN#" >
	SELECT 
		ID as NewID 
	FROM 
		constitution
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND DivisionID = <cfqueryparam value = #request.MiscID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND TeamID = <cfqueryparam value = #QMisc003.TeamID#	cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND OrdinalID = <cfqueryparam value = #QMisc003.OrdinalID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>