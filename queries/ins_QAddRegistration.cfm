<!--- called from RegisterPlayer.cfm --->

<cfquery name="QAddRegistration" datasource="#request.DSN#" >
	INSERT INTO
		register
		(PlayerID, LeagueCode) 
	VALUES
		( <cfqueryparam value = #URL.PI# 
			cfsqltype="CF_SQL_INTEGER" maxlength="8">, 
		<cfqueryparam value = '#request.filter#' 
			cfsqltype="CF_SQL_VARCHAR" maxlength="5"> )
</cfquery>
