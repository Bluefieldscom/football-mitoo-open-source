<!--- called by PtchAvailable.cfm --->

<cfquery name="PtchBookedAllOK" datasource="#request.DSN#">
	SELECT
		COUNT(p.ID) as BookingsCount,
		p.ID as PitchavailableID,
		DAY(p.BookingDate) as s_day ,
		MONTH(p.BookingDate) as s_month,
		p.PitchStatusID,
		p.PitchNoID as PNID,
		p.VenueID as VID,
		p.TeamID,
		p.OrdinalID,
		v.LongCol as VenueName,
		pn.Longcol as PitchNumber,
		(SELECT count(*) FROM pitchavailable WHERE LeagueCode = <cfqueryparam value='#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5" >
		AND MONTH(BookingDate) = s_month AND DAY(BookingDate) = s_day AND VenueID=VID AND PitchNoID=PNID) as BCount
	FROM
		pitchavailable p, venue v, pitchno pn
	WHERE
		p.LeagueCode = <cfqueryparam value='#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5" >
		AND MONTH(p.BookingDate) = #ThisMonth#
		AND p.TeamID = #ThisTeamID#
		AND p.OrdinalID = #ThisOrdinalID#
		AND p.VenueID=v.ID
		AND p.PitchNoID=pn.ID
	GROUP BY
		s_day, venueid, pitchnoid
	HAVING 
		BookingsCount = 1 
		AND BCount = 1 
		AND PitchStatusID = 1
</cfquery>
