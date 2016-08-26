<!--- called by InclCheckFreeDay --->
<cfquery name="QGetFreeDayH" datasource="#request.DSN#" >
	SELECT
		ID
	FROM
		teamfreedate
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND FreeDate = #fixturedate#
		AND TeamID = #HomeTeamID# 
		AND OrdinalID = #HomeOrdinalID#
</cfquery>
