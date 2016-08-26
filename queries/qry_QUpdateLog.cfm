<!--- called by News.cfm --->
<cfquery name="QUpdateLog" datasource="#request.DSN#">	
	SELECT 
		TableName, 
		TStamp, 
		ID, 
		FieldName, 
		BeforeValue, 
		AfterValue, 
		LeagueCode
	FROM 
		updatelog 
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	ORDER BY
		TableName, TStamp
</cfquery>
