<!--- Called by LUList.cfm --->

<cfquery name="DocumentList" datasource="zmast" >
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
		LeagueCodePrefix = <cfqueryparam value ='#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
	ORDER BY
		GroupName desc, Extension, Description
</cfquery>
