<!--- called by PtchAvailable.cfm --->

<cfquery name="PtchBookedNOTAllOK" datasource="#request.DSN#">
	SELECT
		COUNT(ID) as BookingsCount,
		ID as PitchavailableID,
		DAY(BookingDate) as s_day ,
		MONTH(BookingDate) as s_month,
		PitchStatusID,
		PitchNoID as PNID,
		VenueID as VID,
		TeamID,
		OrdinalID,
		(SELECT count(*) FROM pitchavailable WHERE LeagueCode = <cfqueryparam value='#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5" >
		AND MONTH(BookingDate) = s_month AND DAY(BookingDate) = s_day AND VenueID=VID AND PitchNoID=PNID) as BCount
	FROM
		pitchavailable
	WHERE
		LeagueCode = <cfqueryparam value='#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5" >
		AND MONTH(BookingDate) = #ThisMonth#
		AND TeamID = #ThisTeamID#
		AND OrdinalID = #ThisOrdinalID#
	GROUP BY
		s_day, venueid, pitchnoid
	HAVING 
		BookingsCount > 1 
		OR BCount > 1 
		OR PitchStatusID > 1
</cfquery>
