<!--- called by RestoreBackFromMisc.cfm --->

<cfquery name="QPossibleID" datasource="#request.DSN#" >
	SELECT  
		ID as PossibleID 
	FROM 
		Constitution 
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND DivisionID = <cfqueryparam value = #request.MiscID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
