<!--- called from RegisterPlayer.cfm --->

<cftry>

	<cfquery name="QDeleteRegistration" datasource="#request.DSN#" >
		DELETE FROM
			register 
		WHERE
			LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND ID = <cfqueryparam value = #Form.RID# 
							cfsqltype="CF_SQL_INTEGER" maxlength="8">
	</cfquery>
	
	<cfcatch type="database">
		<cfmodule template="../dberrorpage.cfm" source="Registration"><cfabort>
	</cfcatch>
	
</cftry>	
