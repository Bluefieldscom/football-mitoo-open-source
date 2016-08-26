<!--- called from Toolbar_1.cfm --->

<cfquery name="QMatchbanHeaderCount" datasource="#request.DSN#" >
	SELECT  
		count(*) as cnt
	FROM 
		matchbanheader
	WHERE
		leaguecode= <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
</cfquery>
