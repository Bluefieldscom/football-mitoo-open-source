<!--- called by AdministrationReportsMenu.cfm --->

	<cfif StructKeyExists(url,"Full")>
		<cfif url.Full IS "Yes">
			<!--- full update history --->
			<cfset TheInterval = "400 DAY">
		</cfif>
	<cfelse>
			<!--- 10 day update history --->
			<cfset TheInterval = "10 DAY">
	</cfif>

<cfquery name="QUpdateHistory" datasource="#request.DSN#">	
	SELECT 
		SortOrder, 
		TableName, 
		ID1, 
		ID2, 
		Date1, 
		FieldName, 
		BeforeValue, 
		AfterValue, 
		LeagueCode, 
		SecurityLevel, 
		TStamp,
		Date(TStamp) as TheDate, 
		Time(TStamp) as TheTime
	FROM 
		updatelog 
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND TStamp BETWEEN DATE_SUB(NOW(), INTERVAL #TheInterval#) AND NOW()
	ORDER BY
		SecurityLevel, SortOrder, TStamp, ID1, ID2 
		
</cfquery>

