<!--- called by TeamsNotPlayingToday.cfm --->

<CFQUERY NAME="NotPlayingToday03" datasource="#request.DSN#" >
	SELECT
		ID as CID
	FROM
		constitution as Constitution
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND TeamID = <cfqueryparam value = #HomeTeamTID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND OrdinalID = <cfqueryparam value = #HomeTeamOID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
</CFQUERY>
