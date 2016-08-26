<!--- called by AppearancesQuery.cfm --->

<cfquery name="QOrdinal01" datasource="#request.DSN#" >	
	SELECT 
		ID 
	FROM 
		ordinal 
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND MediumCol = 'KO'
</cfquery>
