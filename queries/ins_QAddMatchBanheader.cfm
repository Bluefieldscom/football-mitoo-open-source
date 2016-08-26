<!--- called from SuspendPlayer.cfm --->
<cfquery name="QAddMatchBanheader" datasource="#request.DSN#" >
	INSERT INTO
		matchbanheader
		(SuspensionID, 
		TeamID, 
		OrdinalID, 
		LeagueCode
		) 
	VALUES
		( #ThisSuspensionID#,
		 #ThisTeamID#,
		 #ThisOrdinalID#,
		<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		
		)
</cfquery>
<cfquery name="QUpdSuspensionNotes" datasource="#request.DSN#" >
	UPDATE suspension SET SuspensionNotes='#ThisNotes#' 
	WHERE 
	LeagueCode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND ID = #ThisSuspensionID#
</cfquery>
