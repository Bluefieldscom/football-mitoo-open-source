<cfquery name="QPIValid" datasource="#request.DSN#" >
	select
		ID 
	FROM 
		register 
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND PlayerID = <cfqueryparam value = #PI# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND TeamID = #request.DropDownTeamID#		
</cfquery>
