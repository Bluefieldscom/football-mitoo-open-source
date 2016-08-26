<!--- called from SuspendPlayer.cfm --->

<cfquery name="QUpdateSuspension" datasource="#request.DSN#" >
	UPDATE
		suspension 
	SET
		FirstDay = #CreateODBCDate(GetToken(form.FirstDay,2,","))#,
		LastDay = #CreateODBCDate(GetToken(form.LastDay,2,","))#,
		NumberOfMatches = #form.NumberOfMatches#,
		SuspensionNotes = '#ThisNotes#'
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = <cfqueryparam value = #Form.SID# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
