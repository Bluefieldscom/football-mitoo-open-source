<!--- called by LUList.cfm --->
<cfquery name="QCheck1" datasource="#request.DSN#" >
	SELECT shortcol as RegNo FROM player WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> AND ID=#QPairings.PID1#
</cfquery>

<cfquery name="QCheck2" datasource="#request.DSN#" >
	SELECT shortcol as RegNo FROM player WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> AND ID=#QPairings.PID2#
</cfquery>

<cfquery name="QNoWarning2" datasource="#request.DSN#" >
	SELECT 
		ID 
	FROM 
		playerduplicatenowarnings 
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND RegNo1 = #QCheck1.RegNo# 
		AND RegNo2 = #QCheck2.RegNo# 
		AND Reason = 2
</cfquery>
