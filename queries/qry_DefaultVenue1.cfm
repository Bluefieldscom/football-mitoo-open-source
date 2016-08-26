<!--- called by MtchDay.cfm --->

<cfquery name="QDefaultVenue1" datasource="#request.DSN#" >
	SELECT
		c.TeamID as ThisTeamID,
		c.OrdinalID as ThisOrdinalID,
		v.id as ThisVenueID, 
		pn.ID as ThisPitchNoID ,
		f.FixtureDate as ThisBookingDate,
		f.LeagueCode as ThisLeagueCode
	FROM 
		fixture f,
		teamdetails td, 
		venue v ,
		pitchno pn ,
		constitution c
	WHERE
		f.leaguecode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND f.ID = #ThisFixtureID#
		AND f.HomeID = c.ID
		AND c.TeamID = td.TeamID
		AND c.OrdinalID = td.OrdinalID
		AND td.venueid=v.id
		AND td.PitchNoID=pn.id
</cfquery>

