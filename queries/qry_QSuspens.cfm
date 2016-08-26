<!--- called by RedCardSuspens.cfm --->

<cfquery name="QSuspens" datasource="#request.DSN#" >
	SELECT
		FirstDay,
		LastDay,
		NumberOfMatches
	FROM
		suspension
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND PlayerID = <cfqueryparam value = #ThisPID#
						 cfsqltype="CF_SQL_INTEGER" maxlength="8">
	ORDER BY
		FirstDay	
</cfquery>
