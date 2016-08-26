<!--- called by InclUpdtFixture.cfm --->

<cfquery name="QTeamIDOrdinalID" datasource="#request.DSN#">
	SELECT
		TeamID,
		OrdinalID
	FROM
		constitution
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND id = #form.HomeID#
</cfquery>
<cfif QTeamIDOrdinalID.RecordCount IS 1>
	<cfquery name="QPitchAvailableForNewDate" datasource="#request.DSN#">
		SELECT
			ID
		FROM
			pitchavailable
		WHERE
			LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND TeamID = #QTeamIDOrdinalID.TeamID#
			AND OrdinalID = #QTeamIDOrdinalID.OrdinalID#
			AND BookingDate = '#DateFormat(MatchDate,"YYYY-MM-DD")#'
	</cfquery>
	<cfoutput>#QTeamIDOrdinalID.TeamID#  #QTeamIDOrdinalID.OrdinalID#</cfoutput>
	<cfif QPitchAvailableForNewDate.RecordCount IS 1>
		<!--- pitch availability - no need to do anything else --->
	<cfelseif QPitchAvailableForNewDate.RecordCount IS 0>
		<!--- no pitch availability so use pitch availability from old date --->
		<cfquery name="InsertPitchAvailable" datasource="#request.DSN#">
			INSERT INTO pitchavailable
				(TeamID, OrdinalID, VenueID, PitchNoID, PitchStatusID, BookingDate, LeagueCode)
			SELECT
				TeamID, OrdinalID, VenueID, PitchNoID, PitchStatusID, '#DateFormat(MatchDate,"YYYY-MM-DD")#', LeagueCode
			FROM
				pitchavailable
			WHERE
				id = #form.PitchAvailableID#
		</cfquery>
	<cfelse>
			<!--- multiple pitch availability - no need to do anything else --->
	</cfif>
</cfif>
