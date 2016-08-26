<!--- called by AppearanceAnalysis.cfm --->

<cfquery name="QClubName" datasource="#request.DSN#" >
	SELECT
		LongCol as ClubName
	FROM
		team
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND ID = <cfqueryparam value = #URL.TeamID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
