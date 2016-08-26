<!--- called by TeamsNotPlayingToday.cfm --->

<CFQUERY NAME="NotPlayingToday04" datasource="#request.DSN#" >
		SELECT
			ID as CID
		FROM
			constitution as Constitution
		WHERE
			LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND TeamID = <cfqueryparam value = #AwayTeamTID# 
							cfsqltype="CF_SQL_INTEGER" maxlength="8">
			AND OrdinalID = <cfqueryparam value = #AwayTeamOID# 
							cfsqltype="CF_SQL_INTEGER" maxlength="8">
</CFQUERY>
