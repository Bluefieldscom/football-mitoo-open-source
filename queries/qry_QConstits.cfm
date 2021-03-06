<!--- Called by TeamHistAll.cfm --->

<cfquery name="QConstits" datasource="#request.DSN#">
	SELECT
		ID
	FROM
		constitution
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND TeamID = <cfqueryparam value = #QChosenID.TeamID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND OrdinalID = <cfqueryparam value = #QChosenID.OrdinalID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
