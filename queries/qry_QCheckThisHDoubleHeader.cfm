<!--- called by MtchDay.cfm --->
<cfquery name="QCheckThisHDoubleHeader" datasource="#request.DSN#">
	SELECT 
		f.ID
	FROM
		fixture f, 
		constitution c
	WHERE
		f.fixturedate='#ThisDate#' 
		AND f.leaguecode = <cfqueryparam value='#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND f.HomeID = c.ID
		AND c.teamid=#PlayingMoreThanOnceToday.TID#
		AND c.ordinalid=#PlayingMoreThanOnceToday.OID#
</cfquery>
