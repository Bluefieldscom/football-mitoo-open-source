<!--- called by LUList.cfm and UpdateMatchBans.cfm  --->
<cfquery name="QAnyApps" datasource="#request.DSN#">
	SELECT
		COUNT(ID) as AppearanceCount
	FROM
		appearance 
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND fixtureid=#fixtureid#
</cfquery>
