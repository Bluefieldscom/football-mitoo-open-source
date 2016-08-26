<!--- called from SuspendPlayer.cfm --->

<cfquery name="QGetNewSuspension" datasource="#request.DSN#" >
	SELECT 
		ID 
	FROM 
		suspension 
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' 
			cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND FirstDay IS NULL 
		AND LastDay IS NULL
</cfquery>
