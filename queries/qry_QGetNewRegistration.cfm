<!--- called from RegisterPlayer.cfm --->

<cfquery name="QGetNewRegistration" datasource="#request.DSN#" >
	SELECT 
		ID 
	FROM 
		register 
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' 
			cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND TeamID IS NULL
		AND FirstDay IS NULL 
		AND LastDay IS NULL
</cfquery>
