<!--- called from TransferTeamToMisc.cfm --->

<cfquery name="QUpdtMisc06" datasource="#request.DSN#" >
	UPDATE
		fixture 
	SET
		AwayID = <cfqueryparam value = #QGetIDMisc06.NewID# 
				cfsqltype="CF_SQL_INTEGER" maxlength="8">
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND HomeID = <cfqueryparam value = #Form.CID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND AwayID = #ListGetAt(AwayIDList,x)#
</cfquery>