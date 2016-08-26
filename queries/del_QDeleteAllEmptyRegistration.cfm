<!--- called from RegisterPlayer.cfm --->

<cftry>

	<cfquery name="QDeleteAllEmptyRegistration" datasource="#request.DSN#" >
		DELETE FROM register 
		WHERE 
			LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND TeamID IS NULL
			<!---
			AND FirstDay IS NULL 
			AND LastDay IS NULL
			--->
	</cfquery>
	
	<cfcatch type="database">
		<cfmodule template="../dberrorpage.cfm" source="Registration"><cfabort>
	</cfcatch>
	
</cftry>	
