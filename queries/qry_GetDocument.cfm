<!--- Called by LUList.cfm --->

<cfquery name="GetDocument" datasource="zmast" >
	SELECT
		ID,
		LeagueCodePrefix, 
		Description, 
		FileName, 
		Extension,
		GroupName
	FROM
		leaguedocs
	WHERE
		ID = <cfqueryparam value = #ID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
