<!--- called by InclCheckFreeDay --->
<cfquery name="QGetFreeDayA" datasource="#request.DSN#" >
	SELECT
		ID
	FROM
		teamfreedate
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND FreeDate = #fixturedate#
		AND TeamID = #AwayTeamID# 
		AND OrdinalID = #AwayOrdinalID#
</cfquery>
