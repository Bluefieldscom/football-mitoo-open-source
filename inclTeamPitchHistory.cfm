<cfinclude template="queries/qry_QPitchAvailable3.cfm">
<cfif QPitchAvailable.RecordCount IS 0>
	<cfset VenueList = "">
	<cfset HVIDList = "">
	<cfset VenueNameList = "">
	<cfset PitchNameList = "">
	<cfset PitchStatusList = "">
	<cfset BookingDateList = "">
	<cfset UnknownCount = 0 >
<cfelse>
	<cfinclude template="queries/qry_QVenueInfo.cfm">
	<cfset VenueList = ValueList(QVenueInfo.VenueName)>
	<cfset HVIDList = ValueList(QVenueInfo.HVID)>
	<cfset VenueNameList = ValueList(QPitchAvailable.VenueName)>
	<cfset PitchNameList = ValueList(QPitchAvailable.PitchName)>
	<cfset PitchStatusList = ValueList(QPitchAvailable.PitchStatus)>
	<cfset BookingDateList = ValueList(QPitchAvailable.BookingDate)>
	<cfset UnknownCount = 0 >
		<table width="100%" border="0" cellspacing="0" cellpadding="5">
			<tr>
				<td>
					<table border="1" align="center" cellpadding="2" cellspacing="0" bgcolor="lightgreen">
						<tr>
							<td><span class="pix10">Date</span></td>
							<td><span class="pix10">Venue</span></td>
							<td><span class="pix10">Pitch</span></td>
							<td><span class="pix10">Status</span></td>
						</tr>
						<cfoutput>
							<cfloop index="x" from="1" to="#QPitchAvailable.RecordCount#" step="1" >
								<cfif StructKeyExists(url, "FixtureDate") AND DateFormat(ListGetAt(BookingDateList,x),'YYYY-MM-DD') IS DateFormat(url.FixtureDate,'YYYY-MM-DD') >
									<tr>
										<cfif ListGetAt(VenueNameList,x) IS "*UNKNOWN*">
											<cfset UnknownCount = UnknownCount + 1 >
											<td bgcolor="white"><span class="pix10bold">#DateFormat(ListGetAt(BookingDateList,x),'DDDD, DD MMMM YYYY')#</span></td>
											<td bgcolor="white"><span class="pix10bold">&nbsp;</span></td>
											<td bgcolor="white"><span class="pix10bold">&nbsp;</span></td>
											<td bgcolor="white"><span class="pix10bold">&nbsp;</span></td>
										<cfelse>
											<td><span class="pix10bold">#DateFormat(ListGetAt(BookingDateList,x),'DDDD, DD MMMM YYYY')#</span></td>
											<td><span class="pix10bold">#ListGetAt(VenueNameList,x)#</span></td>
											<td><span class="pix10bold">#ListGetAt(PitchNameList,x)#</span></td>
											<cfif ListGetAt(PitchStatusList,x) GT 1>
												<td bgcolor="pink"><span class="pix10bold">#ListGetAt(PitchStatusList,x)#</span></td>
											<cfelse>
												<td><span class="pix10bold">#ListGetAt(PitchStatusList,x)#</span></td>
											</cfif>
										</cfif>
									</tr>
								<cfelse>
									<tr>
										<cfif ListGetAt(VenueNameList,x) IS "*UNKNOWN*">
											<cfset UnknownCount = UnknownCount + 1 >
											<td bgcolor="white"><span class="pix10">#DateFormat(ListGetAt(BookingDateList,x),'DDDD, DD MMMM YYYY')#</span></td>
											<td bgcolor="white"><span class="pix10">&nbsp;</span></td>
											<td bgcolor="white"><span class="pix10">&nbsp;</span></td>
											<td bgcolor="white"><span class="pix10">&nbsp;</span></td>
										<cfelse>
											<td><span class="pix10">#DateFormat(ListGetAt(BookingDateList,x),'DDDD, DD MMMM YYYY')#</span></td>
											<td><span class="pix10">#ListGetAt(VenueNameList,x)#</span></td>
											<td><span class="pix10">#ListGetAt(PitchNameList,x)#</span></td>
											<cfif ListGetAt(PitchStatusList,x) GT 1>
												<td bgcolor="pink"><span class="pix10">#ListGetAt(PitchStatusList,x)#</span></td>
											<cfelse>
												<td><span class="pix10">#ListGetAt(PitchStatusList,x)#</span></td>
											</cfif>
										</cfif>
									</tr>
								</cfif>
							</cfloop>
						</cfoutput>
					</table>
				</td>
			</tr>
		</table>
</cfif>
				
