<!--- called from TransferTeamToMisc.cfm --->

<cfquery name="QGetIDMisc06" datasource="#request.DSN#" >
	SELECT 
		ID as NewID 
	FROM 
		constitution
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND DivisionID = <cfqueryparam value = #request.MiscID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND TeamID = <cfqueryparam value = #QMisc05.TeamID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND OrdinalID = <cfqueryparam value = #QMisc05.OrdinalID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
