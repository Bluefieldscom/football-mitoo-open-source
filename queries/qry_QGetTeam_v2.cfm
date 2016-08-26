<!--- called from ToolBar2.cfm --->

<cfquery name="QGetTeam" datasource="#request.DSN#">
	SELECT 
		LongCol as ClubName 
	FROM 
		team 
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID     = <cfqueryparam value = #TeamID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
