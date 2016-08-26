<!--- called by AppearancesQuery.cfm --->

<cfquery name="QTeam01" datasource="#request.DSN#" >		
	SELECT 
		ID 
	FROM 
		team 
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND (LEFT(Notes,7) = 'NoScore' 
		OR ShortCol = 'GUEST' 
		OR LongCol IS NULL)
</cfquery>
