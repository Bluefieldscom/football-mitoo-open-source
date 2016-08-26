<!--- called by AdministrationReportsMenu.cfm --->
<!--- 10 day update history --->
<cfset TheInterval = "10 DAY">
<cfquery name="QUpdateHistoryCount" datasource="#request.DSN#">	
	SELECT 
		Count(*) as IntervalCount
	FROM 
		updatelog 
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND TStamp BETWEEN DATE_SUB(NOW(), INTERVAL #TheInterval#) AND NOW()
</cfquery>

