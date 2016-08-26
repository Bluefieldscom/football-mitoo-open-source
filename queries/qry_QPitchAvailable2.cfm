<!--- called by InclPitchAvailable01.cfm and InclPitchAvailable02.cfm --->

<cftry>		  
	<cfquery name="QPitchAvailable2" datasource="#request.DSN#">
	SELECT
		ID ,
		PitchNoID ,
		PitchStatusID ,
		TeamID ,
		OrdinalID,
		BookingDate
	FROM
		pitchavailable
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = <cfqueryparam value = #id# cfsqltype="CF_SQL_INTEGER" maxlength="8">
	</cfquery>
	<cfcatch type="Any">
		<!--- for all other errors, most likely non-numeric codes --->
		<cfmodule template="../dberrorpage.cfm" 
			source="PitchAvailable" errortype="baddata">
		<cfabort>
	</cfcatch>
</cftry>

