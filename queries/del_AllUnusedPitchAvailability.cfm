<!--- called by PitchAvailableList.cfm --->
<cfquery name="DelAllUnusedPitchAvailability" datasource="#request.DSN#">
	DELETE FROM
		pitchavailable
	WHERE
		LeagueCode = <cfqueryparam value='#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND PitchStatusID=1
		AND BookingDate < Now()
		AND ID NOT IN (SELECT pitchavailableid FROM fixture WHERE LeagueCode = <cfqueryparam value='#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">)
</cfquery>		
