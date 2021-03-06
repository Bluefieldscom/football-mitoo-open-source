<!--- called by LUList.cfm --->
<cfquery name="QPlayerDuplicateWarning2" datasource="#request.DSN#" >
	SELECT 
		RegNo1,
		RegNo2,
		Concat(RegNo1, ' ', RegNo2)
	FROM 
		playerduplicatewarnings 
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND Reason = 2
		AND Concat(RegNo1, ' ', RegNo2) NOT IN (SELECT Concat(RegNo1, ' ', RegNo2) FROM playerduplicatenowarnings WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> AND Reason = 2 ) 
</cfquery>
