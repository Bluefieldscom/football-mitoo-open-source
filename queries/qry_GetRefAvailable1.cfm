<!--- called by Calendar.cfm --->
<cftry>		  
	<cfquery name="GetRefAvailable1" datasource="#request.DSN#">
		SELECT 
			ID
		FROM
			refavailable as RefAvailable 
		WHERE
			LeagueCode = '#ThisLeagueCodePrefix#'
			AND	RefereeID = #ThisRefereeID#
			AND MatchDate = '#ThisDate#';
	</cfquery>
	<cfcatch type="Any">
		<!--- for all other errors, most likely non-numeric codes --->
		<cfmodule template="../dberrorpage.cfm" 
			source="RefAvailable" errortype="baddata">
		<cfabort>
	</cfcatch>
</cftry>
