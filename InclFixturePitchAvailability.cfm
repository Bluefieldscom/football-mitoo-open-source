<!--- called by MtchDay.cfm and FixtResMonth.cfm --->

<!--- this gets the venue name and pitch status from the pitchavailable table.
The retrieved information will only be relevant if it is for the current date and current home team and current home ordinal. 
It is possible that the pitchavailable record has had its team or ordinal or date changed after the fixture was created.
 In this case, reset the PA_ID on the fixture record to zero. --->
<cfoutput>
	<cfif IsNumeric(QFixtures.PA_ID) >
		<cfset ThisID = QFixtures.PA_ID >
		<cfset ThisTeamID = QFixtures.HomeTeamID >
		<cfset ThisOrdinalID = QFixtures.HomeOrdinalID >
		<cfset ThisBookingDate = QFixtures.FixtureDate >
		<!--- try to match on five key fields 
			1. fixture.PitchAvailableID
			2. fixture.LeagueCode
			3. fixture.TeamID (Home)
			4. fixture.OrdinalID (Home)
			5. fixture.Date (Booking Date is the same as Fixture Date)
		--->
		<cfinclude template="queries/qry_FixturePitchAvailability2.cfm">
		<cfif FixturePitchAvailability2.RecordCount IS 0 >
			<!--- now try to match on just four key fields --->
			<cfinclude template="queries/qry_FixturePitchAvailability3.cfm">
			<cfif FixturePitchAvailability3.RecordCount IS 0 >
				<!--- nothing found with same date, team, ordinal, leaguecode --->
				<!--- update the fixture record (parent) PitchAvailableID - set it to zero  --->
				<cfset FID = QFixtures.FID >
				<cfset ThisPA_ID = 0 >
				<cfinclude template="queries/upd_Fixture_PitchAvailableID.cfm">  			
				<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
					<span class="pix10boldnavy"><br />[venue not specified]</span>
				</cfif>
			<cfelseif FixturePitchAvailability3.RecordCount IS 1 >
				<!--- a single record found with same date, team, ordinal, leaguecode --->
				<!--- update the fixture record's PitchAvailableID  --->
				<cfset FID = QFixtures.FID >
				<cfset ThisPA_ID = FixturePitchAvailability3.ID >
				<cfinclude template="queries/upd_Fixture_PitchAvailableID.cfm">  			
				<span class="pix10navy"><br />#FixturePitchAvailability3.VenueName#</span>
				<cfif Trim(FixturePitchAvailability3.PitchName) IS "1">
				<cfelse>
					<span class="pix10navy">(Pitch #Trim(FixturePitchAvailability3.PitchName)#)</span>
				</cfif>
				<cfif Trim(FixturePitchAvailability3.PitchStatus) IS "OK">
				<cfelse>
					<span class="pix10boldred">#FixturePitchAvailability3.PitchStatus#</span>
				</cfif>
				<cfif Len(Trim(FixturePitchAvailability3.MapURL)) GT 0><a href="#Trim(FixturePitchAvailability3.MapURL)#" target="_blank"><img src="images/icon_map.png" border="0" align="absmiddle" onmouseover="this.src='images/icon_map_hover.png';" onMouseOut="this.src='images/icon_map.png';"></a></cfif>
			<cfelse>
				<!--- multiple records found with same date, team, ordinal, leaguecode --->
				<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
				<span class="pix10boldred"><br />Choice of pitches</span>
				</cfif>
			</cfif>
		<cfelse>
			<!--- found a match on all five key fields  --->
			<!--- now try to match on just four key fields --->
			<cfinclude template="queries/qry_FixturePitchAvailability3.cfm">
			<cfif FixturePitchAvailability3.RecordCount IS 1 >
				<!--- found a match on all five key fields but no more records found with same date, team, ordinal, leaguecode --->
				<br /><cfif Len(Trim(FixturePitchAvailability2.MapURL)) GT 0><a href="#Trim(FixturePitchAvailability2.MapURL)#" target="_blank"><img src="images/icon_map.png" border="0" align="absmiddle" onmouseover="this.src='images/icon_map_hover.png';" onMouseOut="this.src='images/icon_map.png';"></a></cfif>
				
				<span class="pix10navy">#FixturePitchAvailability2.VenueName#</span>
				<cfif Trim(FixturePitchAvailability2.PitchName) IS "1">
				<cfelse>
					<span class="pix10navy">(Pitch #Trim(FixturePitchAvailability2.PitchName)#)</span>
				</cfif>
				<cfif Trim(FixturePitchAvailability2.PitchStatus) IS "OK">
				<cfelse>
					<span class="pix10boldred">#FixturePitchAvailability2.PitchStatus#</span>
				</cfif>
			<cfelseif FixturePitchAvailability3.RecordCount GT 1 >
				<!--- found a match on all five key fields and also more records found with same date, team, ordinal, leaguecode --->
				<span class="pix10navy"><br />#FixturePitchAvailability2.VenueName#</span>
				<cfif Trim(FixturePitchAvailability2.PitchName) IS "1">
				<cfelse>
					<span class="pix10navy">(Pitch #Trim(FixturePitchAvailability2.PitchName)#)</span>
				</cfif>
				<cfif Trim(FixturePitchAvailability2.PitchStatus) IS "OK">
				<cfelse>
					<span class="pix10boldred">#FixturePitchAvailability2.PitchStatus#</span>
				</cfif>
				<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
				<span class="pix10boldred"><br />Choice of pitches</span>
				</cfif>
			<cfelse>
				error in InclFixturePitchAvailability - aborting <cfabort>
			</cfif>
		</cfif>
	</cfif>
</cfoutput>