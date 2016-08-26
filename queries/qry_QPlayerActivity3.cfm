<!--- called by PlayersHist.cfm --->

<CFQUERY NAME="QPlayerActivity3" datasource="#request.DSN#">
	SELECT
		COUNT(Activity) as ACount
	FROM
		appearance
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND PlayerID = <cfqueryparam value = #PI# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND Activity = 3
</CFQUERY>
