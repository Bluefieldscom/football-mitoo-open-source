<!--- called from UpdateTeamList.cfm --->

<cfquery datasource="#request.DSN#">
	UPDATE
		appearance
	SET
		Activity = <cfqueryparam value = #ActivityValue# cfsqltype="CF_SQL_INTEGER" maxlength="1">,
		GoalsScored = <cfqueryparam value = #GoalsScored# 
						cfsqltype="CF_SQL_INTEGER" maxlength="2"> ,
		Card = <cfqueryparam value = #CardValue# 
						cfsqltype="CF_SQL_INTEGER" maxlength="1"> ,
		StarPlayer = <cfqueryparam value = #StarPlayer# 
			cfsqltype="CF_SQL_INTEGER" maxlength="1">
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND FixtureID = <cfqueryparam value = #FID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND PlayerID = <cfqueryparam value = #PID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>