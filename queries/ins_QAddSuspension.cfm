<!--- called from SuspendPlayer.cfm --->

<cfquery name="QAddSuspension" datasource="#request.DSN#" >
	INSERT INTO
		suspension
		(PlayerID, LeagueCode) 
	VALUES
		( <cfqueryparam value = #URL.PI# 
			cfsqltype="CF_SQL_INTEGER" maxlength="8">, 
		<cfqueryparam value = '#request.filter#' 
			cfsqltype="CF_SQL_VARCHAR" maxlength="5"> )
</cfquery>
