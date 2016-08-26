<!--- called by PitchAvailableList.cfm --->

<CFQUERY NAME="QPitchAvailable" datasource="#request.DSN#">
	SELECT
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
		<cfif ThisPA IS "Venue">
				AND h.VenueID = <cfqueryparam value = #ThisVenueID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		<cfelseif ThisPA IS "Team">
				AND h.TeamID = <cfqueryparam value = #ThisTeamID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
				AND h.OrdinalID = <cfqueryparam value = #ThisOrdinalID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
		<cfelse>
		Error in qry_QPitchAvailable.cfm<cfabort>
		</cfif>
		AND h.TeamID = t.ID 
		AND h.OrdinalID = o.ID 
		AND h.VenueID = v.ID 
		AND h.PitchNoID = pn.ID
		AND h.PitchStatusID = ps.ID

		
	<cfif ThisPA IS "Team">	
UNION
	SELECT
		t.LongCol as TeamName , 
		o.LongCol as OrdinalName ,
		'*UNKNOWN*' as VenueName ,
		'-' as PitchName ,
		'-' as PitchStatus ,
		0 as HID ,
		#ThisTeamID#  as HTID ,
		#ThisOrdinalID# as HOID ,
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
		AND c.OrdinalID = <cfqueryparam value = #ThisOrdinalID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND f.HomeID = c.ID
		AND t.ID = c.TeamID
		AND o.ID = c.OrdinalID
</cfif>


		
	ORDER BY
	<cfif ThisPA IS "Venue">
		<cfif StructKeyExists(url, "SortSeq" ) AND URL.SortSeq IS "Date">
			BookingDate, PitchName, TeamName, OrdinalName
		<cfelseif StructKeyExists(url, "SortSeq" ) AND URL.SortSeq IS "Pitch">
			PitchName, BookingDate, TeamName, OrdinalName
		<cfelseif StructKeyExists(url, "SortSeq" ) AND URL.SortSeq IS "Team">
			TeamName, OrdinalName, BookingDate, PitchName
		<cfelseif StructKeyExists(url, "SortSeq" ) AND URL.SortSeq IS "Status">
			PitchStatus, BookingDate, PitchName, TeamName, OrdinalName
		<cfelse>
			BookingDate, PitchName, TeamName, OrdinalName
		</cfif>
	<cfelseif ThisPA IS "Team">
		<cfif StructKeyExists(url, "SortSeq" ) AND URL.SortSeq IS "Date">
			BookingDate, VenueName, PitchName
		<cfelseif StructKeyExists(url, "SortSeq" ) AND URL.SortSeq IS "Pitch">
			PitchName, BookingDate, VenueName
		<cfelseif StructKeyExists(url, "SortSeq" ) AND URL.SortSeq IS "Venue">
			VenueName, BookingDate, PitchName
		<cfelseif StructKeyExists(url, "SortSeq" ) AND URL.SortSeq IS "Status">
			PitchStatus, BookingDate, VenueName, PitchName,
		<cfelse>
			BookingDate, VenueName, PitchName
		</cfif>
	<cfelse>
	Error in qry_QPitchAvailable.cfm<cfabort>
	</cfif>
	
	
	
</CFQUERY>


