<!--- called by InclCheckKORound --->

<CFQUERY NAME="GetKORound" datasource="#request.DSN#">
	SELECT 	
		LongCol
	FROM 	
		koround as KORound
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = <cfqueryparam value = #KORoundID# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8">
</CFQUERY>
