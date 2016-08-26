<!--- called by PlayersHist.cfm --->

<CFQUERY NAME="QPlayerGoals" datasource="#request.DSN#">
	SELECT
		COALESCE(SUM(GoalsScored),0) as TotalGoalsScored
	FROM
		appearance
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND PlayerID = <cfqueryparam value = #PI# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
</CFQUERY>
