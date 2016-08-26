<!--- called from TransferTeamToMisc.cfm --->

<cfquery name="QUpdtMisc03" datasource="#request.DSN#" >
	UPDATE
		fixture 
	SET
		HomeID = <cfqueryparam value = #QGetIDMisc03.NewID# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8">
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND AwayID = <cfqueryparam value = #Form.CID# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND HomeID = #ListGetAt(HomeIDList,x)#
</cfquery>
