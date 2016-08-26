<!--- called by TeamDetailsUpdate.cfm --->

<cfquery name="QTID_OID" datasource="#request.DSN#">	
	SELECT 
		ID
	FROM
		constitution
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND TeamID = <cfqueryparam value = #ThisTID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND OrdinalID = <cfqueryparam value = #ThisOID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
