<!--- called by PitchAvailableList.cfm --->

<cfif ThisPA IS "Venue">
	<CFQUERY NAME="QPitchAvailable" datasource="#request.DSN#">
		SELECT
	<!--- this gives the pitch bookings with no matching fixtures --->
			'c' as xtype,
			t.LongCol as TeamName , 
			o.LongCol as OrdinalName ,
			v.LongCol as VenueName ,
			pn.LongCol as PitchName ,
			ps.LongCol as PitchStatus ,
			h.ID as HID ,
			h.TeamID as HTID ,
			h.OrdinalID as HOID ,
			h.VenueID as HVID ,
			h.PitchNoID as PNID ,
			h.PitchStatusID as PSID,
			h.BookingDate
		FROM
			pitchavailable AS h,
			venue AS v,
			team AS t, 
			ordinal AS o,
			pitchno AS pn,
			pitchstatus AS ps
		WHERE
			h.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND h.VenueID = <cfqueryparam value = #ThisVenueID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
			AND h.TeamID = t.ID 
			AND h.OrdinalID = o.ID 
			AND h.VenueID = v.ID 
			AND h.PitchNoID = pn.ID
			AND h.PitchStatusID = ps.ID
			AND h.ID
			NOT IN 
			(SELECT f.PitchAvailableID FROM fixture f, pitchavailable h
				WHERE f.LeagueCode = '#request.filter#'  AND h.VenueID=#ThisVenueID# AND f.PitchAvailableID = h.ID)	
	UNION
	<!--- this gives the exact matching fixtures and pitch bookings --->
		SELECT
			'a' as xtype,
			t.LongCol as TeamName , 
			o.LongCol as OrdinalName ,
			v.LongCol as VenueName ,
			pn.LongCol as PitchName ,
			ps.LongCol as PitchStatus ,
			h.ID as HID ,
			h.TeamID as HTID ,
			h.OrdinalID as HOID ,
			h.VenueID as HVID ,
			h.PitchNoID as PNID ,
			h.PitchStatusID as PSID,
			h.BookingDate
		FROM
			pitchavailable AS h,
			venue AS v,
			team AS t, 
			ordinal AS o,
			pitchno AS pn,
			pitchstatus AS ps,
			fixture f
		WHERE
			h.LeagueCode =  <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND h.VenueID = <cfqueryparam value = #ThisVenueID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
			AND h.TeamID = t.ID 
			AND h.OrdinalID = o.ID 
			AND h.VenueID = v.ID 
			AND h.PitchNoID = pn.ID
			AND h.PitchStatusID = ps.ID
			AND h.ID = f.PitchAvailableID
		ORDER BY
			BookingDate, xtype, VenueName, PitchName
	</CFQUERY>

<cfelseif ThisPA IS "Team">
	<!--- firstly create a list of all the PitchAvailableIDs for matching fixtures --->
	<cfquery name="QPitchAvlbl" datasource="#request.DSN#">
		SELECT
			f.PitchAvailableID 
		FROM 
			fixture f, 
			constitution c, 
			team t, 
			ordinal o
		WHERE 
			f.LeagueCode = '#request.filter#' 
			AND c.TeamID = #ThisTeamID# 
			AND c.OrdinalID = #ThisOrdinalID#
			AND f.HomeID = c.ID	
			AND t.ID = c.TeamID	
			AND o.ID = c.OrdinalID
	</cfquery>
	
	<cfset QPitchAvlblCount = QPitchAvlbl.RecordCount>
	<cfset PitchAvlblList = ValueList(QPitchAvlbl.PitchAvailableID) >

	<CFQUERY NAME="QPitchAvailable" datasource="#request.DSN#">
	<!--- this gives the pitch bookings with no matching fixtures --->
		SELECT
			'c' as xtype,
			t.LongCol as TeamName , 
			o.LongCol as OrdinalName ,
			v.LongCol as VenueName ,
			pn.LongCol as PitchName ,
			ps.LongCol as PitchStatus ,
			h.ID as HID ,
			h.TeamID as HTID ,
			h.OrdinalID as HOID ,
			h.VenueID as HVID ,
			h.PitchNoID as PNID ,
			h.PitchStatusID as PSID,
			h.BookingDate
		FROM
			pitchavailable AS h,
			venue AS v,
			team AS t, 
			ordinal AS o,
			pitchno AS pn,
			pitchstatus AS ps
		WHERE
			h.LeagueCode =  <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND h.TeamID = <cfqueryparam value = #ThisTeamID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
			AND h.OrdinalID = <cfqueryparam value = #ThisOrdinalID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
			AND h.TeamID = t.ID 
			AND h.OrdinalID = o.ID 
			AND h.VenueID = v.ID 
			AND h.PitchNoID = pn.ID
			AND h.PitchStatusID = ps.ID
			<cfif QPitchAvlblCount IS 0>
			<cfelse>
				AND h.ID NOT IN (#PitchAvlblList#) <!--- reject for matching fixtures --->
			</cfif>	
	  UNION
	 <!--- this gives the exact matching fixtures and pitch bookings  --->
		SELECT
			'a' as xtype,
			t.LongCol as TeamName , 
			o.LongCol as OrdinalName ,
			v.LongCol as VenueName ,
			pn.LongCol as PitchName ,
			ps.LongCol as PitchStatus ,
			h.ID as HID ,
			h.TeamID as HTID ,
			h.OrdinalID as HOID ,
			h.VenueID as HVID ,
			h.PitchNoID as PNID ,
			h.PitchStatusID as PSID,
			h.BookingDate
		FROM
			pitchavailable AS h,
			venue AS v,
			team AS t, 
			ordinal AS o,
			pitchno AS pn,
			pitchstatus AS ps,
			fixture f,
			constitution c
		WHERE
			h.LeagueCode =  <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND h.TeamID =  <cfqueryparam value = #ThisTeamID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
			AND h.OrdinalID =  <cfqueryparam value = #ThisOrdinalID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
			AND f.HomeID = c.ID
			AND h.TeamID = t.ID 
			AND c.TeamID = t.ID
			AND h.OrdinalID = o.ID 
			AND c.OrdinalID = o.ID
			AND h.VenueID = v.ID 
			AND h.PitchNoID = pn.ID
			AND h.PitchStatusID = ps.ID
			AND h.ID = f.PitchAvailableID
	 UNION
	<!--- this gives the unmatched fixtures - that is the fixtures without a pitch booking.  --->
		SELECT 
			'b' as xtype,
			t.LongCol as TeamName , 
			o.LongCol as OrdinalName ,
			'[venue not specified]' as VenueName ,
			'-' as PitchName ,
			'-' as PitchStatus ,
			0 as HID ,
			0  as HTID ,
			0 as HOID ,
			0 as HVID ,
			0 as PNID ,
			0 as PSID,
			f.FixtureDate as BookingDate
		FROM 
			fixture f,
			constitution c,
			team t,
			ordinal o
		WHERE
			f.LeagueCode =  <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND f.PitchAvailableID = 0
			AND c.TeamID = <cfqueryparam value = #ThisTeamID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
			AND c.OrdinalID =  <cfqueryparam value = #ThisOrdinalID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
			AND f.HomeID = c.ID
			AND t.ID = c.TeamID
			AND o.ID = c.OrdinalID	
		ORDER BY
			BookingDate, xtype, VenueName, PitchName
	</cfquery>
<cfelse>
	Error in qry_QPitchAvailable.cfm<cfabort>
</cfif>
