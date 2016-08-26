<!--- called by UpdateFreeDay.cfm --->
<cfquery name="QGetFreeDay" datasource="#request.DSN#" >
	SELECT
		ID
	FROM
		teamfreedate
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND FreeDate = '#MDate#'
		AND TeamID = #FreeTID#
		AND OrdinalID = #FreeOID#
</cfquery>
