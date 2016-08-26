<!--- called by GatherTeamsUnderClubProcess2.cfm --->

<cfquery name="QClubName2" datasource="fm#Year#" >
	SELECT
		LongCol as ClubName
	FROM
		team
	WHERE
		LeagueCode = <cfqueryparam value = '#url.LgCode#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND ID = <cfqueryparam value = #url.fmTeamID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
