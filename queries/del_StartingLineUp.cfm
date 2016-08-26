<!--- caled from UpdateStartingLineUpList.cfm --->
<cfquery datasource="#request.DSN#">
	DELETE FROM
		shirtnumber
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND AppearanceID = <cfqueryparam value = #AppID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
</cfquery>
