<!--- called from InclBatchUpdate1.cfm --->

<cfquery name="QAddRegistration" datasource="#request.DSN#" >
	INSERT INTO
		register
		(TeamID, PlayerID, FirstDay, RegType, LeagueCode) 
	VALUES
		( #BTeamID#, #PlayerID#, '#FirstDay#', '#RegType#', <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> )
</cfquery>
