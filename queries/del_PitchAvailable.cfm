<!--- called by PitchAvailableList.cfm --->
<cftry>

	<CFQUERY NAME="DelPitchAvailable" datasource="#request.DSN#">
		DELETE FROM
			pitchavailable
		WHERE
			LeagueCode = <cfqueryparam value='#request.filter#'	cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND ID = #DeleteID#
	</CFQUERY>

	<cfcatch type="database">
		<cfmodule template="../dberrorpage.cfm" source="PitchAvailable"><cfabort>
	</cfcatch>
	
</cftry>
	