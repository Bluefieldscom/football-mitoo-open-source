<!--- Called by RegistListForm.cfm --->

<cfquery name="QConstitsAllSides" datasource="#request.DSN#">
	SELECT
		ID
	FROM
		constitution
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND TeamID = #request.DropDownTeamID#
</cfquery>
