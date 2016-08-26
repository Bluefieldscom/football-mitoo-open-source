<!--- called from TransferTeamToMisc.cfm --->

<cfquery name="QMisc01" datasource="#request.DSN#" >
	UPDATE
		constitution 
	SET
		DivisionID = <cfqueryparam value = #request.MiscID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = <cfqueryparam value = #Form.CID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
