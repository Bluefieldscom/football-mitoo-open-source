<!--- called from SuspendPlayer.cfm --->

<cftry>

	<cfquery name="QDeleteSuspension" datasource="#request.DSN#" >
		DELETE FROM
			suspension 
		WHERE
			LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND ID = <cfqueryparam value = #Form.SID# 
							cfsqltype="CF_SQL_INTEGER" maxlength="8">
	</cfquery>
	
	<cfcatch type="database">
		<cfmodule template="../dberrorpage.cfm" source="Suspension"><cfabort>
	</cfcatch>
	
</cftry>	
