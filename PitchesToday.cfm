<!--- called by MtchDay.cfm --->
<!--- produces a list, at the bottom of the screen, of pitches being used on this match day. Can only be seen when logged in. --->
<cfinclude template="queries/qry_QPitchesUsed.cfm">
<table width="100%" border="1" cellpadding="2" cellspacing="2" >
	<tr align="left" valign="top">
	<cfset VIDList = "">
		<cfset VIDList = ListAppend(VIDList, 0)>
		<cfif QPitchesUsed.RecordCount GT 0>
			<cfset VIDList = ValueList(QPitchesUsed.VID)>
			<cfset PitchAvailableIDList = ValueList(QPitchesUsed.PitchAvailableID)>
			<td width="50%">
				<table border="0" cellspacing="0" cellpadding="0" >
					<tr>
						<td><span class="pix13boldnavy">Pitches Used Today</span></td>
					</tr>
					<cfoutput query="QPitchesUsed" group="VenueName">
						<tr>
							<td colspan="2"><span class="pix10bold"><a href="PitchAvailableList.cfm?LeagueCode=#LeagueCode#&PA=Venue&VenueID=#VID#">#VenueName#</a></span></td>
							<cfoutput group="PitchNumber">
								<tr>
									<cfset ThisCounter = 0>
									<cfoutput>
										<cfset ThisCounter = ThisCounter+1>
										<cfif ThisCounter GT 1>
											<cfset ThisClass = "bg_highlight">
											<td class="#ThisClass#"><span class="pix13boldred">WARNING &nbsp;</span></td>
										<cfelse>
											<cfset ThisClass = "white">
										</cfif>
										<td class="#ThisClass#"><span class="pix10">#HomeTeam# #HomeOrdinal# v #AwayTeam# #AwayOrdinal#</span><cfif Trim(PitchNumber) IS "1"><span class="pix10">&nbsp;</span><cfelse><span class="pix10">(Pitch #Trim(PitchNumber)#)</span></cfif><cfif Trim(PitchStatus) IS "OK"><span class="pix10">&nbsp;</span><cfelse><span class="pix10boldred">#PitchStatus#</span></cfif></td>
									</cfoutput>
								</tr>
							</cfoutput>
						</tr>
					</cfoutput>
				</table>
			</td>
		<cfelse>
			<cfset PitchAvailableIDList = "" >
			<cfset PitchAvailableIDList = ListAppend(PitchAvailableIDList, 0)>
		</cfif>
		
		<cfinclude template="queries/qry_QPitchesUnused.cfm">
		<cfinclude template="queries/qry_QVenuesFree.cfm">
		
		<cfif QPitchesUnused.RecordCount GT 0 or QVenuesFree.RecordCount GT 0 >
			<td width="50%">
				<table border="0" cellspacing="0" cellpadding="0" >
					<tr>
						<td><span class="pix13boldnavy">Pitches Booked but Unused Today</span></td>
					</tr>
					<cfif QPitchesUnused.RecordCount IS 0>
						<td colspan="2"><span class="pix10bold">None</span></td>
					<cfelse>
						<cfoutput query="QPitchesUnused" group="VenueName">
							<tr>
								<td colspan="2"><span class="pix10bold"><a href="PitchAvailableList.cfm?LeagueCode=#LeagueCode#&PA=Venue&VenueID=#VID#">#VenueName#</a></span></td>
								<cfoutput group="PitchNumber">
									<tr>
										<cfset ThisCounter = 0>
										<cfoutput>
											<cfset ThisCounter = ThisCounter+1>
											<cfif ThisCounter GT 1>
												<cfset ThisClass = "bg_highlight">
												<td class="#ThisClass#"><span class="pix13boldred">WARNING &nbsp;</span></td>
											<cfelse>
												<cfset ThisClass = "white">
											</cfif>
											<td class="#ThisClass#"><span class="pix10">#HomeTeam# #HomeOrdinal#</span><cfif Trim(PitchNumber) IS "1"><span class="pix10">&nbsp;</span><cfelse><span class="pix10">(Pitch #Trim(PitchNumber)#)</span></cfif><cfif Trim(PitchStatus) IS "OK"><span class="pix10">&nbsp;</span><cfelse><span class="pix10boldred">#PitchStatus#</span></cfif></td>
										</cfoutput>
									</tr>
								</cfoutput>
							</tr>
						</cfoutput>
					</cfif>
					<tr>
						<td height="20"><span class="pix13boldnavy"></span></td>
					</tr>
					<cfset no_of_columns_across = 4 >
					<table width="100%">
						<tr>
							<td colspan="#no_of_columns_across#"><span class="pix13boldnavy">Venues Possibly Free Today</span></td>
						</tr>
					<cfif QVenuesFree.RecordCount IS 0>
						<td colspan="2"><span class="pix10bold">None</span></td>
					<cfelse>
							<tr>
								<td valign="top" >
									<cfset VenueCount=0>
									<table border="1" cellpadding="2" cellspacing="0">
										<tr>
										<cfoutput query="QVenuesFree">
											<cfset VenueCount = VenueCount + 1>
													<td valign="top">
														<span class="pix10bold"><a href="PitchAvailableList.cfm?LeagueCode=#LeagueCode#&PA=Venue&VenueID=#FreeVID#">#VenueName#</a></span>
													</td>
												<cfif VenueCount Mod no_of_columns_across IS 0 >
												</tr>
												<tr>
												</cfif>
										</cfoutput>
									</table>
								</td>
							</tr>
						</table>
					</cfif>
						
				</table>
			</td>
		</cfif>
</tr>
</table>