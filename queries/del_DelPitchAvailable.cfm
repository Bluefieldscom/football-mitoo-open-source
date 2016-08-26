<!--- called by Action.cfm --->

<cftry>

	<CFQUERY NAME="DelConstit" datasource="#request.DSN#">
		DELETE FROM
			pitchavailable
		WHERE
			LeagueCode = <cfqueryparam value='#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND ID 	   = <cfqueryparam value=#Form.ID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
	</CFQUERY>

	<cfcatch type="database">
		<cfmodule template="../dberrorpage.cfm" source="PitchAvailable"><cfabort>
	</cfcatch>
	
</cftry>
	