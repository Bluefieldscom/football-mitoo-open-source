<!--- called by LUList.cfm and UpdateMatchBans.cfm  --->
<cfquery name="QAppID" datasource="#request.DSN#">
	SELECT
		ID as AppearanceID
	FROM
		appearance 
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND PlayerID = #EVALUATE(STRING4)#
		AND fixtureid=#fixtureid#
</cfquery>
